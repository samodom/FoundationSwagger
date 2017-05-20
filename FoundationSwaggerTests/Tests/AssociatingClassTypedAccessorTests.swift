//
//  AssociatingClassTypedAccessorTests.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 11/20/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

import XCTest
import FoundationSwagger

class AssociatingClassTypedAccessorTests: XCTestCase {

    let associatingClasses: [AssociatingClass.Type] = [
        SampleObjectiveCClass.self,
        SampleSwiftClass.self
    ]

    let key = SampleKey1


    func testOptionalBooleanAssociationRetrieval() {
        associatingClasses.forEach { `class` in
            var value = `class`.booleanAssociation(for: key)
            XCTAssertNil(value, "No value should be returned without an association")

            `class`.associate(NSObject(), with: key)
            value = `class`.booleanAssociation(for: key)
            XCTAssertNil(value, "No value should be returned with a non-boolean association")

            `class`.associate(true, with: key)
            value = `class`.booleanAssociation(for: key)
            XCTAssertTrue(value!, "The stored boolean value should be returned")

            `class`.associate(false, with: key)
            value = `class`.booleanAssociation(for: key)
            XCTAssertFalse(value!, "The stored boolean value should be returned")
        }
    }

    func testOptionalSignedIntegerAssociationRetrieval() {
        associatingClasses.forEach { `class` in
            var value = `class`.integerAssociation(for: key)
            XCTAssertNil(value, "No value should be returned without an association")

            `class`.associate(NSObject(), with: key)
            value = `class`.integerAssociation(for: key)
            XCTAssertNil(value, "No value should be returned with a non-signed-integer association")

            `class`.associate(Int(-18), with: key)
            value = `class`.integerAssociation(for: key)
            XCTAssertEqual(value, -18, "The stored signed integer value should be returned")
        }
    }

    func testOptionalUnsignedIntegerAssociationRetrieval() {
        associatingClasses.forEach { `class` in
            var value = `class`.unsignedIntegerAssociation(for: key)
            XCTAssertNil(value, "No value should be returned without an association")

            `class`.associate(NSObject(), with: key)
            value = `class`.unsignedIntegerAssociation(for: key)
            XCTAssertNil(value, "No value should be returned with a non-unsigned-integer association")

            `class`.associate(UInt(14), with: key)
            value = `class`.unsignedIntegerAssociation(for: key)
            XCTAssertEqual(value, 14, "The stored unsigned integer value should be returned")
        }
    }

    func testOptionalFloatAssociationRetrieval() {
        associatingClasses.forEach { `class` in
            var value = `class`.floatAssociation(for: key)
            XCTAssertNil(value, "No value should be returned without an association")

            `class`.associate(NSObject(), with: key)
            value = `class`.floatAssociation(for: key)
            XCTAssertNil(value, "No value should be returned with a non-float association")

            `class`.associate(Float(14.42), with: key)
            value = `class`.floatAssociation(for: key)
            XCTAssertEqual(value, 14.42, "The stored float value should be returned")
        }
    }

    func testOptionalDoubleAssociationRetrieval() {
        associatingClasses.forEach { `class` in
            var value = `class`.doubleAssociation(for: key)
            XCTAssertNil(value, "No value should be returned without an association")

            `class`.associate(NSObject(), with: key)
            value = `class`.doubleAssociation(for: key)
            XCTAssertNil(value, "No value should be returned with a non-double association")

            `class`.associate(Double(14.42), with: key)
            value = `class`.doubleAssociation(for: key)
            XCTAssertEqual(value, 14.42, "The stored double value should be returned")
        }
    }

    func testOptionalStringAssociationRetrieval() {
        associatingClasses.forEach { `class` in
            var value = `class`.stringAssociation(for: key)
            XCTAssertNil(value, "No value should be returned without an association")

            `class`.associate(NSObject(), with: key)
            value = `class`.stringAssociation(for: key)
            XCTAssertNil(value, "No value should be returned with a non-string association")

            `class`.associate("Tony", with: key)
            value = `class`.stringAssociation(for: key)
            XCTAssertEqual(value, "Tony", "The stored string value should be returned")
        }
    }

    func testOptionalUrlAssociationRetrieval() {
        associatingClasses.forEach { `class` in
            var value = `class`.urlAssociation(for: key)
            XCTAssertNil(value, "No value should be returned without an association")

            `class`.associate(NSObject(), with: key)
            value = `class`.urlAssociation(for: key)
            XCTAssertNil(value, "No value should be returned with a non-URL association")

            let sampleUrl = URL(string: "http://www.example.com")!
            `class`.associate(sampleUrl, with: key)
            value = `class`.urlAssociation(for: key)
            XCTAssertEqual(value, sampleUrl, "The stored URL value should be returned")
        }
    }

}
