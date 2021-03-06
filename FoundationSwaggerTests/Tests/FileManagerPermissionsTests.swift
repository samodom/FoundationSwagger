//
//  FileManagerPermissionsTests.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 2/9/17.
//  Copyright © 2017 Swagger Soft. All rights reserved.
//

import XCTest
import FoundationSwagger


class FileManagerPermissionsTests: XCTestCase {

    let fileManager = FileManager.default
    let allPermissionsMasks = FilePermissionsMask(0) ... MaximumFilePermissionsMask

    var sampleDirectoryPath: String!
    var sampleFilePath: String!
    var nonexistentFilePath: String!


    override func setUp() {
        super.setUp()

        sampleDirectoryPath = SampleDirectory.appendingPathComponent("sampleDirectory").path
        sampleFilePath = SampleDirectory.appendingPathComponent("sampleFile").path
        nonexistentFilePath = SampleDirectory.appendingPathComponent("nothing").path

        try? fileManager.createDirectory(
            atPath: sampleDirectoryPath,
            withIntermediateDirectories: false,
            attributes: nil
        )

        fileManager.createFile(atPath: sampleFilePath, contents: nil, attributes: nil)

        var isDirectory = ObjCBool(false)
        assert(fileManager.fileExists(atPath: sampleDirectoryPath, isDirectory: &isDirectory))
        assert(isDirectory.boolValue)
        assert(fileManager.fileExists(atPath: sampleFilePath))
        assert(!fileManager.fileExists(atPath: nonexistentFilePath))
    }

    override func tearDown() {
        defer { super.tearDown() }

        try? fileManager.removeItem(atPath: sampleFilePath)
        try? fileManager.removeItem(atPath: nonexistentFilePath)
    }


    // MARK: - Retrieving permissions

    func testRetrievingPermissionsForNonexistentFile() {
        var expectedError: NSError?
        do {
            _ = try fileManager.attributesOfItem(atPath: nonexistentFilePath)
            return XCTFail("The previous call should throw an error")
        }
        catch {
            expectedError = error as NSError
        }

        var permissions: FilePermissions?
        var capturedError: NSError?
        do {
            permissions = try fileManager.permissionsOfItem(atPath: nonexistentFilePath)
            return XCTFail("Attempting to retrieve permissions of a nonexistent file should rethrow an error")
        }
        catch {
            capturedError = error as NSError
        }

        XCTAssertNil(permissions, "No permissions should be returned when an error is thrown")
        XCTAssertEqual(capturedError, expectedError, "The same error as the system API throws should be rethrown")
    }

    func testMissingPermissions() {
        fileManager.createAttributesForItemStubSurrogate().withAlternateImplementation {
            do {
                let permissions = try fileManager.permissionsOfItem(atPath: sampleFilePath)
                XCTAssertNil(permissions,
                             "No permissions should have been retrieved since they don't exist")
            }
            catch {
                fatalError("Unexpected error encountered retrieving permissions")
            }
        }
    }

    func testRetrievingPermissionsForExistingFiles() {
        [sampleFilePath!, sampleDirectoryPath!].forEach { path in
            let expectedMask: FilePermissionsMask
            do {
                let attributes = try fileManager.attributesOfItem(atPath: path)
                expectedMask = attributes[FileAttributeKey.posixPermissions]! as! FilePermissionsMask
            }
            catch {
                fatalError("Unable to retrieve expected file permissions")
            }

            let retrievedMask: FilePermissionsMask
            do {
                let permissions = try fileManager.permissionsOfItem(atPath: path)!
                retrievedMask = permissions.mask
            }
            catch {
                return XCTFail("Unable to retrieve permissions: \(error)")
            }

            XCTAssertEqual(retrievedMask, expectedMask, "The wrong permissions were retrieved")
        }
    }


    // MARK: - Setting permissions

    func testSettingPermissionsForNonexistentFile() {
        var expectedError: NSError?
        do {
            let attributes = [
                FileAttributeKey.posixPermissions: FilePermissions(user: ClassPermissions.all).mask
            ]
            try fileManager.setAttributes(attributes, ofItemAtPath: nonexistentFilePath)
            return XCTFail("The previous call should throw an error")
        }
        catch {
            expectedError = error as NSError
        }

        var capturedError: NSError?
        do {
            let permissions = FilePermissions(user: ClassPermissions.all)
            try fileManager.setPermissions(permissions, ofItemAtPath: nonexistentFilePath)
            return XCTFail("Attempting to retrieve permissions of a nonexistent file should rethrow an error")
        }
        catch {
            capturedError = error as NSError
        }

        XCTAssertEqual(capturedError, expectedError, "The same error as the system API throws should be rethrown")
    }

    func testSettingPermissionsForExistingFile() {
        for mask in allPermissionsMasks {
            let permissions = FilePermissions(mask: mask)

            do {
                try fileManager.setPermissions(permissions, ofItemAtPath: sampleFilePath)
            }
            catch {
                return XCTFail("Unable to change file permissions")
            }

            guard let attributes = try? fileManager.attributesOfItem(atPath: sampleFilePath) else {
                fatalError("Unable to retrieve new file permissions")
            }

            guard let newPermissionsMask =
                attributes[FileAttributeKey.posixPermissions] as? FilePermissionsMask else {
                    fatalError("New file permissions are invalid")
            }

            if newPermissionsMask != mask {
                let comparisonString = "\(newPermissionsMask) != \(mask)"
                return XCTFail("The permissions API should set the correct permissions mask: \(comparisonString)")
            }
        }
    }

}

private let SampleDirectory: URL = {
    let paths = NSSearchPathForDirectoriesInDomains(
        .cachesDirectory,
        .userDomainMask,
        true
    )

    guard !paths.isEmpty else {
        fatalError("Unable to find directory")
    }

    return URL(fileURLWithPath: paths.first!, isDirectory: true)
}()
