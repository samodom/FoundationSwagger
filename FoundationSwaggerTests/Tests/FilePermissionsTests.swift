//
//  FilePermissionsTests.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 2/8/17.
//  Copyright © 2017 Swagger Soft. All rights reserved.
//

import XCTest
import FoundationSwagger


class FilePermissionsTests: XCTestCase {

    // MARK: - Class permissions

    var classPermissions: ClassPermissions!
    let allPossibleClassPermissions: [ClassPermissions] = {
        let values = ClassPermissions.none.rawValue ... ClassPermissions.all.rawValue
        return values.map { ClassPermissions(rawValue: $0) }
    }()

    var filePermissions: FilePermissions!
    var maskExpectations: [UInt16]!

    func testEmptyClassPermissions() {
        classPermissions = []
        XCTAssertFalse(classPermissions.isReadable,
                       "The permissions should not include the readable permission")
        XCTAssertFalse(classPermissions.isWritable,
                       "The permissions should not include the writable permission")
        XCTAssertFalse(classPermissions.isExecutable,
                       "The permissions should not include the executable permission")
        XCTAssertEqual(classPermissions, ClassPermissions.none,
                       "`none` permissions should include none of the three different permissions")
    }

    func testReadableClassPermissions() {
        classPermissions = .readable
        XCTAssertTrue(classPermissions.isReadable,
                      "The permissions should include the readable permission")
        XCTAssertFalse(classPermissions.isWritable,
                       "Empty permissions should not include the writable permission")
        XCTAssertFalse(classPermissions.isExecutable,
                       "Empty permissions should not include the executable permission")
    }

    func testWritableClassPermissions() {
        classPermissions = .writable
        XCTAssertFalse(classPermissions.isReadable,
                       "The permissions should not include the readable permission")
        XCTAssertTrue(classPermissions.isWritable,
                      "The permissions should include the writable permission")
        XCTAssertFalse(classPermissions.isExecutable,
                       "The permissions should not include the executable permission")
    }

    func testExecutableClassPermissions() {
        classPermissions = .executable
        XCTAssertFalse(classPermissions.isReadable,
                       "The permissions should not include the readable permission")
        XCTAssertFalse(classPermissions.isWritable,
                       "The permissions should not include the writable permission")
        XCTAssertTrue(classPermissions.isExecutable,
                      "The permissions should include the executable permission")
    }

    func testReadableWritableClassPermissions() {
        classPermissions = [.readable, .writable]
        XCTAssertTrue(classPermissions.isReadable,
                      "The permissions should include the readable permission")
        XCTAssertTrue(classPermissions.isWritable,
                      "The permissions should include the writable permission")
        XCTAssertFalse(classPermissions.isExecutable,
                       "The permissions should not include the executable permission")
    }

    func testReadableExecutableClassPermissions() {
        classPermissions = [.readable, .executable]
        XCTAssertTrue(classPermissions.isReadable,
                      "The permissions should include the readable permission")
        XCTAssertFalse(classPermissions.isWritable,
                       "The permissions should not include the writable permission")
        XCTAssertTrue(classPermissions.isExecutable,
                      "The permissions should include the executable permission")
    }

    func testWritableExecutableClassPermissions() {
        classPermissions = [.writable, .executable]
        XCTAssertFalse(classPermissions.isReadable,
                       "The permissions should not include the readable permission")
        XCTAssertTrue(classPermissions.isWritable,
                      "The permissions should include the writable permission")
        XCTAssertTrue(classPermissions.isExecutable,
                      "The permissions should include the executable permission")
    }

    func testAllClassPermissions() {
        classPermissions = [.readable, .writable, .executable]
        XCTAssertTrue(classPermissions.isReadable,
                      "The permissions should include the readable permission")
        XCTAssertTrue(classPermissions.isWritable,
                      "The permissions should include the writable permission")
        XCTAssertTrue(classPermissions.isExecutable,
                      "The permissions should include the executable permission")
        XCTAssertEqual(classPermissions, ClassPermissions.all,
                       "`all` permissions should include all three different permissions")
    }

    func testInvalidClassPermissions() {
        let invalidRange = 8 ... UInt8.max
        for value in invalidRange {
            if ClassPermissions(rawValue: value).rawValue != 0 {
                XCTFail("Values beyond a full 3-bit mask (\(value)) are invalid and should only produce the empty permissions set")
                return
            }
        }
    }


    // MARK: - File permissions

    func testUserPermissions() {
        maskExpectations = allPossibleClassPermissions.map {
            UInt16($0.rawValue) << 6
        }

        zip(allPossibleClassPermissions, maskExpectations).forEach { permission, mask in
            filePermissions = FilePermissions(user: permission)
            XCTAssertEqual(filePermissions.mask, mask,
                           "The user permission masks should all be bit-shifted left by 6 places")
        }
    }

    func testGroupPermissions() {
        maskExpectations = allPossibleClassPermissions.map {
            UInt16($0.rawValue) << 3
        }

        zip(allPossibleClassPermissions, maskExpectations).forEach { permission, mask in
            filePermissions = FilePermissions(group: permission)
            XCTAssertEqual(filePermissions.mask, mask,
                           "The group permission masks should all be bit-shifted left by 3 places")
        }
    }

    func testOthersPermissions() {
        maskExpectations = allPossibleClassPermissions.map {
            UInt16($0.rawValue)
        }

        zip(allPossibleClassPermissions, maskExpectations).forEach { permission, mask in
            filePermissions = FilePermissions(others: permission)
            XCTAssertEqual(filePermissions.mask, mask,
                           "The others permission masks should be equal to its raw value")
        }
    }

    func testMixedPermissions() {
        let expectedMask: UInt16 =
            7 << 6 + // user readable, writable and executable
            5 << 3 + // group readable, executable
            2 // others writable

        filePermissions = FilePermissions(
            user: .all,
            group: [.readable, .executable],
            others: .writable
        )

        XCTAssertEqual(filePermissions.mask, expectedMask,
                       "The bit mask of a mixed set of permissions should use the appropriate bit shifting")
    }

}
