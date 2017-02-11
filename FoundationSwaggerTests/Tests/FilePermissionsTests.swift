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

    var filePermissions: FilePermissions!
    var maskExpectations: [FilePermissionsMask]!
    let allPossibleClassPermissions: [ClassPermissions] = {
        let values = ClassPermissions.none.rawValue ... ClassPermissions.all.rawValue
        return values.map { ClassPermissions(rawValue: $0) }
    }()

    func testUserPermissions() {
        maskExpectations = allPossibleClassPermissions.map {
            FilePermissionsMask($0.rawValue) << 6
        }

        zip(allPossibleClassPermissions, maskExpectations).forEach { classPermissions, mask in
            filePermissions = FilePermissions(user: classPermissions)
            XCTAssertEqual(filePermissions.mask, mask,
                           "The user permission values should all be bit-shifted left by 6 places")
        }
    }

    func testGroupPermissions() {
        maskExpectations = allPossibleClassPermissions.map {
            FilePermissionsMask($0.rawValue) << 3
        }

        zip(allPossibleClassPermissions, maskExpectations).forEach { classPermissions, mask in
            filePermissions = FilePermissions(group: classPermissions)
            XCTAssertEqual(filePermissions.mask, mask,
                           "The group permission values should all be bit-shifted left by 3 places")
        }
    }

    func testOthersPermissions() {
        maskExpectations = allPossibleClassPermissions.map {
            FilePermissionsMask($0.rawValue)
        }

        zip(allPossibleClassPermissions, maskExpectations).forEach { classPermissions, mask in
            filePermissions = FilePermissions(others: classPermissions)
            XCTAssertEqual(filePermissions.mask, mask,
                           "The others permission values should be equal to their raw values")
        }
    }

    func testMixedPermissions() {
        let expectedMask: FilePermissionsMask =
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

    func testCreatingBasicPermissions() {
        let allMaskValues = FilePermissionsMask(0) ... MaximumFilePermissionsMask
        for mask in allMaskValues {
            let permissions = FilePermissions(mask: mask)
            if permissions.mask != mask {
                print("mask = \(mask), permissions = \(permissions.mask)")
                return XCTFail("Every valid 16-bit unsigned integer should create file permissions: \(permissions.mask) != \(mask)")
            }
        }
    }

    func testCreatingExtendedPermissions() {
        let allMaskValues = (MaximumFilePermissionsMask + 1) ... FilePermissionsMask.max
        for mask in allMaskValues {
            let permissions = FilePermissions(mask: mask)
            if permissions.mask != mask {
                return XCTFail("Every valid 16-bit unsigned integer should create file permissions: \(permissions.mask) != \(mask)")
            }
        }
    }

    func testExtendedBitsAreCopied() {
        let extendedMask = MaximumFilePermissionsMask + 5
        filePermissions = FilePermissions.init(mask: extendedMask)
        let newPermissions = filePermissions!
        XCTAssertEqual(newPermissions.mask, extendedMask,
                       "The extra bits in an extended mask should be copied to any duplicate permissions")
    }

}
