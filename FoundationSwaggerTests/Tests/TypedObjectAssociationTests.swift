//
//  TypedObjectAssociationTests.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 11/20/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

import XCTest
import FoundationSwagger

class TypedObjectAssociationTests: XCTestCase {

    let object = NSObject()
    let key = ObjectAssociationKey("sample key")


    //  MARK: - Booleans

    func testOptionalBooleanAssociationRetrieval() {
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

    func testDefaultBooleanAssociationRetrieval() {
        var value = object.booleanAssociation(for: key, defaultValue: true)
        XCTAssertTrue(value, "The default value should be returned without an association")

        object.associate(NSObject(), with: key)
        value = object.booleanAssociation(for: key, defaultValue: true)
        XCTAssertTrue(value, "The default value should be returned with a non-boolean association")

        object.associate(true, with: key)
        value = object.booleanAssociation(for: key, defaultValue: false)
        XCTAssertTrue(value, "The stored boolean value should be returned")

        object.associate(false, with: key)
        value = object.booleanAssociation(for: key, defaultValue: true)
        XCTAssertFalse(value, "The stored boolean value should be returned")
    }


    //  MARK: - Signed integers

    func testOptionalSignedIntegerAssociationRetrieval() {
        var value = object.integerAssociation(for: key)
        XCTAssertNil(value, "No value should be returned without an association")

        object.associate(NSObject(), with: key)
        value = object.integerAssociation(for: key)
        XCTAssertNil(value, "No value should be returned with a non-signed-integer association")

        object.associate(-18, with: key)
        value = object.integerAssociation(for: key)
        XCTAssertEqual(value, -18, "The stored signed integer value should be returned")
    }

    func testDefaultSignedIntegerAssociationRetrieval() {
        var value = object.integerAssociation(for: key, defaultValue: -18)
        XCTAssertEqual(value, -18, "The default value should be returned without an association")

        object.associate(NSObject(), with: key)
        value = object.integerAssociation(for: key, defaultValue: -18)
        XCTAssertEqual(value, -18, "The default value should be returned with a non-signed-integer association")

        object.associate(-22, with: key)
        value = object.integerAssociation(for: key, defaultValue: -18)
        XCTAssertEqual(value, -22, "The stored signed integer value should be returned")
    }


    //  MARK: - Unsigned integers

    func testOptionalUnsignedIntegerAssociationRetrieval() {
        var value = object.unsignedIntegerAssociation(for: key)
        XCTAssertNil(value, "No value should be returned without an association")

        object.associate(NSObject(), with: key)
        value = object.unsignedIntegerAssociation(for: key)
        XCTAssertNil(value, "No value should be returned with a non-unsigned-integer association")

        object.associate(UInt(14), with: key)
        value = object.unsignedIntegerAssociation(for: key)
        XCTAssertEqual(value, 14, "The stored unsigned integer value should be returned")
    }

    func testDefaultUnsignedIntegerAssociationRetrieval() {
        var value = object.unsignedIntegerAssociation(for: key, defaultValue: 42)
        XCTAssertEqual(value, 42, "The default value should be returned without an association")

        object.associate(NSObject(), with: key)
        value = object.unsignedIntegerAssociation(for: key, defaultValue: 42)
        XCTAssertEqual(value, 42, "The default value should be returned with a non-unsigned-integer association")

        object.associate(UInt(14), with: key)
        value = object.unsignedIntegerAssociation(for: key, defaultValue: 42)
        XCTAssertEqual(value, 14, "The stored unsigned integer value should be returned")
    }


    //  MARK: - Floats

    func testOptionalFloatAssociationRetrieval() {
        var value = object.floatAssociation(for: key)
        XCTAssertNil(value, "No value should be returned without an association")

        object.associate(NSObject(), with: key)
        value = object.floatAssociation(for: key)
        XCTAssertNil(value, "No value should be returned with a non-float association")

        object.associate(Float(14.42), with: key)
        value = object.floatAssociation(for: key)
        XCTAssertEqual(value, 14.42, "The stored float value should be returned")
    }

    func testDefaultFloatAssociationRetrieval() {
        let storedFloat = Float(14.42)
        let defaultFloat = Float(99.99)

        var value = object.floatAssociation(for: key, defaultValue: defaultFloat)
        XCTAssertEqual(value, defaultFloat, "The default value should be returned without an association")

        object.associate(NSObject(), with: key)
        value = object.floatAssociation(for: key, defaultValue: defaultFloat)
        XCTAssertEqual(value, defaultFloat, "The default value should be returned with a non-float association")

        object.associate(storedFloat, with: key)
        value = object.floatAssociation(for: key, defaultValue: defaultFloat)
        XCTAssertEqual(value, storedFloat, "The stored float value should be returned")
    }


    //  MARK: - Doubles

    func testOptionalDoubleAssociationRetrieval() {
        var value = object.doubleAssociation(for: key)
        XCTAssertNil(value, "No value should be returned without an association")

        object.associate(NSObject(), with: key)
        value = object.doubleAssociation(for: key)
        XCTAssertNil(value, "No value should be returned with a non-double association")

        object.associate(Double(14.42), with: key)
        value = object.doubleAssociation(for: key)
        XCTAssertEqual(value, 14.42, "The stored double value should be returned")
    }

    func testDefaultDoubleAssociationRetrieval() {
        let storedDouble = Double(14.42)
        let defaultDouble = Double(99.99)

        var value = object.doubleAssociation(for: key, defaultValue: defaultDouble)
        XCTAssertEqual(value, defaultDouble, "The default value should be returned without an association")

        object.associate(NSObject(), with: key)
        value = object.doubleAssociation(for: key, defaultValue: defaultDouble)
        XCTAssertEqual(value, defaultDouble, "The default value should be returned with a non-double association")

        object.associate(storedDouble, with: key)
        value = object.doubleAssociation(for: key, defaultValue: defaultDouble)
        XCTAssertEqual(value, storedDouble, "The stored double value should be returned")
    }
    

    //  MARK: - Strings

    func testOptionalStringAssociationRetrieval() {
        var value = object.stringAssociation(for: key)
        XCTAssertNil(value, "No value should be returned without an association")

        object.associate(NSObject(), with: key)
        value = object.stringAssociation(for: key)
        XCTAssertNil(value, "No value should be returned with a non-string association")

        object.associate("Tony", with: key)
        value = object.stringAssociation(for: key)
        XCTAssertEqual(value, "Tony", "The stored string value should be returned")
    }

    func testDefaultStringAssociationRetrieval() {
        var value = object.stringAssociation(for: key, defaultValue: "Stewart")
        XCTAssertEqual(value, "Stewart", "The default value should be returned without an association")

        object.associate(NSObject(), with: key)
        value = object.stringAssociation(for: key, defaultValue: "Stewart")
        XCTAssertEqual(value, "Stewart", "The default value should be returned with a non-string association")

        object.associate("Tony", with: key)
        value = object.stringAssociation(for: key, defaultValue: "Stewart")
        XCTAssertEqual(value, "Tony", "The stored string value should be returned")
    }
    

    //  MARK: - URLs

    func testOptionalUrlAssociationRetrieval() {
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

    func testDefaultUrlAssociationRetrieval() {
        let defaultUrl = URL(string: "http://www.test.com")!

        var value = object.urlAssociation(for: key, defaultValue: defaultUrl)
        XCTAssertEqual(value, defaultUrl, "The default value should be returned without an association")

        object.associate(NSObject(), with: key)
        value = object.urlAssociation(for: key, defaultValue: defaultUrl)
        XCTAssertEqual(value, defaultUrl, "The default value should be returned with a non-URL association")

        let sampleUrl = URL(string: "http://www.example.com")!
        object.associate(sampleUrl, with: key)
        value = object.urlAssociation(for: key, defaultValue: defaultUrl)
        XCTAssertEqual(value, sampleUrl, "The stored URL value should be returned")
    }
    
}
