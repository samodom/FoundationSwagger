//
//  ObjectAssociationPolicyTests.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 2/8/15.
//  Copyright (c) 2015 Swagger Soft. All rights reserved.
//

import XCTest

class ObjectAssociationPolicyTests: XCTestCase {

    var policy: ObjectAssociationPolicy!

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testAssignAssociationPolicy() {
        policy = .Assign
        XCTAssertEqual(policy.rawValue, UInt(OBJC_ASSOCIATION_ASSIGN), "The Assign value should correspond to the assign association")
        XCTAssertEqual(ObjectAssociationPolicy(rawValue: UInt(OBJC_ASSOCIATION_ASSIGN))!, policy, "The raw-value initialization should provide the correct enumeration value")
    }

    func testAtomicRetainAssociationPolicy() {
        policy = ObjectAssociationPolicy.AtomicRetain
        XCTAssertEqual(policy.rawValue, UInt(OBJC_ASSOCIATION_RETAIN), "The AtomicRetain value should correspond to the atomic retain policy")
        XCTAssertEqual(ObjectAssociationPolicy(rawValue: UInt(OBJC_ASSOCIATION_RETAIN))!, policy, "The raw-value initialization should provide the correct enumeration value")
    }

    func testNonatomicRetainAssociationPolicy() {
        policy = ObjectAssociationPolicy.NonatomicRetain
        XCTAssertEqual(policy.rawValue, UInt(OBJC_ASSOCIATION_RETAIN_NONATOMIC), "The NonatomicRetain value should correspond to the nonatomic retain policy")
        XCTAssertEqual(ObjectAssociationPolicy(rawValue: UInt(OBJC_ASSOCIATION_RETAIN_NONATOMIC))!, policy, "The raw-value initialization should provide the correct enumeration value")
    }

    func testAtomicCopyAssociationPolicy() {
        policy = ObjectAssociationPolicy.AtomicCopy
        XCTAssertEqual(policy.rawValue, UInt(OBJC_ASSOCIATION_COPY), "The AtomicCopy value should correspond to the atomic copy policy")
        XCTAssertEqual(ObjectAssociationPolicy(rawValue: UInt(OBJC_ASSOCIATION_COPY))!, policy, "The raw-value initialization should provide the correct enumeration value")
    }

    func testNonatomicCopyAssociationPolicy() {
        policy = ObjectAssociationPolicy.NonatomicCopy
        XCTAssertEqual(policy.rawValue, UInt(OBJC_ASSOCIATION_COPY_NONATOMIC), "The NonatomicCopy value should correspond to the nonatomic copy policy")
        XCTAssertEqual(ObjectAssociationPolicy(rawValue: UInt(OBJC_ASSOCIATION_COPY_NONATOMIC))!, policy, "The raw-value initialization should provide the correct enumeration value")
    }

}
