//
//  ClassPermissionsTests.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 2/9/17.
//  Copyright © 2017 Swagger Soft. All rights reserved.
//

import XCTest
import FoundationSwagger


class ClassPermissionsTests: XCTestCase {

    var classPermissions: ClassPermissions!

    func testEmptyClassPermissions() {
        classPermissions = []
        XCTAssertFalse(classPermissions.isReadable,
                       "The permissions should not include the readable permission")
        XCTAssertFalse(classPermissions.isWritable,
                       "The permissions should not include the writable permission")
        XCTAssertFalse(classPermissions.isExecutable,
                       "The permissions should not include the executable permission")
        XCTAssertEqual(classPermissions, ClassPermissions.none,
                       "Empty permissions should include none of the three different permissions")
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
            if ClassPermissions(rawValue: value).rawValue != value % 8 {
                XCTFail("Values beyond a full 3-bit mask (\(value)) should only produce the permissions from the first three bits")
                return
            }
        }
    }
    
}
