//
//  AssociatingClassTypedAccessorTests.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 11/20/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

import XCTest
import SampleTypes
import FoundationSwagger

class AssociatingClassTypedAccessorTests: XCTestCase {

    let associatingClasses: [AssociatingObject] = [
        SampleObjectiveCClass(14),
        SampleSwiftClass(14)
    ]

    let key = SampleKey1


    func testOptionalBooleanAssociationRetrieval() {
        associatingClasses.forEach { object in
            var value = object.booleanAssociation(for: key)
            XCTAssertNil(value, "No value should be returned without an association")

            object.associate(NSObject(), with: key)
            value = object.booleanAssociation(for: key)
            XCTAssertNil(value, "No value should be returned with a non-boolean association")

            object.associate(true, with: key)
            value = object.booleanAssociation(for: key)
            XCTAssertTrue(value!, "The stored boolean value should be returned")

            object.associate(false, with: key)
            value = object.booleanAssociation(for: key)
            XCTAssertFalse(value!, "The stored boolean value should be returned")
        }
    }

    func testOptionalSignedIntegerAssociationRetrieval() {
        associatingClasses.forEach { object in
            var value = object.integerAssociation(for: key)
            XCTAssertNil(value, "No value should be returned without an association")

            object.associate(NSObject(), with: key)
            value = object.integerAssociation(for: key)
            XCTAssertNil(value, "No value should be returned with a non-signed-integer association")

            object.associate(Int(-18), with: key)
            value = object.integerAssociation(for: key)
            XCTAssertEqual(value, -18, "The stored signed integer value should be returned")
        }
    }

    func testOptionalUnsignedIntegerAssociationRetrieval() {
        associatingClasses.forEach { object in
            var value = object.unsignedIntegerAssociation(for: key)
            XCTAssertNil(value, "No value should be returned without an association")

            object.associate(NSObject(), with: key)
            value = object.unsignedIntegerAssociation(for: key)
            XCTAssertNil(value, "No value should be returned with a non-unsigned-integer association")

            object.associate(UInt(14), with: key)
            value = object.unsignedIntegerAssociation(for: key)
            XCTAssertEqual(value, 14, "The stored unsigned integer value should be returned")
        }
    }

    func testOptionalFloatAssociationRetrieval() {
        associatingClasses.forEach { object in
            var value = object.floatAssociation(for: key)
            XCTAssertNil(value, "No value should be returned without an association")

            object.associate(NSObject(), with: key)
            value = object.floatAssociation(for: key)
            XCTAssertNil(value, "No value should be returned with a non-float association")

            object.associate(Float(14.42), with: key)
            value = object.floatAssociation(for: key)
            XCTAssertEqual(value, 14.42, "The stored float value should be returned")
        }
    }

    func testOptionalDoubleAssociationRetrieval() {
        associatingClasses.forEach { object in
            var value = object.doubleAssociation(for: key)
            XCTAssertNil(value, "No value should be returned without an association")

            object.associate(NSObject(), with: key)
            value = object.doubleAssociation(for: key)
            XCTAssertNil(value, "No value should be returned with a non-double association")

            object.associate(Double(14.42), with: key)
            value = object.doubleAssociation(for: key)
            XCTAssertEqual(value, 14.42, "The stored double value should be returned")
        }
    }

    func testOptionalStringAssociationRetrieval() {
        associatingClasses.forEach { object in
            var value = object.stringAssociation(for: key)
            XCTAssertNil(value, "No value should be returned without an association")

            object.associate(NSObject(), with: key)
            value = object.stringAssociation(for: key)
            XCTAssertNil(value, "No value should be returned with a non-string association")

            object.associate("Tony", with: key)
            value = object.stringAssociation(for: key)
            XCTAssertEqual(value, "Tony", "The stored string value should be returned")
        }
    }

    func testOptionalUrlAssociationRetrieval() {
        associatingClasses.forEach { object in
            var value = object.urlAssociation(for: key)
            XCTAssertNil(value, "No value should be returned without an association")

            object.associate(NSObject(), with: key)
            value = object.urlAssociation(for: key)
            XCTAssertNil(value, "No value should be returned with a non-URL association")

            let sampleUrl = URL(string: "http://www.example.com")!
            object.associate(sampleUrl, with: key)
            value = object.urlAssociation(for: key)
            XCTAssertEqual(value, sampleUrl, "The stored URL value should be returned")
        }
    }

}
