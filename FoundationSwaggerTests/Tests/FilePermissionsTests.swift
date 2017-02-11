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

    let allPossibleClassPermissions: [ClassPermissions] = {
        let values = ClassPermissions.none.rawValue ... ClassPermissions.all.rawValue
        return values.map { ClassPermissions(rawValue: $0) }
    }()

    var filePermissions: FilePermissions!
    var maskExpectations: [UInt16]!
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
