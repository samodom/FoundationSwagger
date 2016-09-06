//
//  UserDefaultsSubscriptingTests.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 12/7/14.
//  Copyright (c) 2014 Swagger Soft. All rights reserved.
//

import XCTest

class UserDefaultsSubscriptingTests: XCTestCase {

    var defaults = NSUserDefaults.standardUserDefaults()

    override func setUp() {
        super.setUp()

        NSUserDefaults.resetStandardUserDefaults()
    }
    
    override func tearDown() {
        NSUserDefaults.resetStandardUserDefaults()

        super.tearDown()
    }

    func testRetrievingMissingValue() {
        let value = defaults["nothing"]
        XCTAssertTrue(value == nil, "Nothing should be returned for a non-existent value")
    }

    func testStoringBooleanValue() {
        defaults["boolean"] = true
        XCTAssertTrue(defaults.boolForKey("boolean"), "Should be able to store a boolean value using subscripting")
    }

    func testRetrievingBooleanValue() {
        defaults.setBool(true, forKey: "boolean")
        XCTAssertTrue(defaults["boolean"] as Bool, "Should be able to retrieve a boolean value using subscripting")
    }

    func testStoringSignedIntegerValues() {
        defaults["integer"] = Int.min
        XCTAssertEqual(defaults.integerForKey("integer"), Int.min, "Should be able to store an integer value using subscripting")

        defaults["integer"] = Int.max
        XCTAssertEqual(defaults.integerForKey("integer"), Int.max, "Should be able to store an integer value using subscripting")

        defaults["integer"] = Int8.min
        XCTAssertEqual(defaults.integerForKey("integer"), Int(Int8.min), "Should be able to store an integer value using subscripting")

        defaults["integer"] = Int16.max
        XCTAssertEqual(defaults.integerForKey("integer"), Int(Int16.max), "Should be able to store an integer value using subscripting")

        defaults["integer"] = Int32.min
        XCTAssertEqual(defaults.integerForKey("integer"), Int(Int32.min), "Should be able to store an integer value using subscripting")

        defaults["integer"] = Int64.max
        XCTAssertEqual(defaults.integerForKey("integer"), Int(Int64.max), "Should be able to store an integer value using subscripting")
    }

    func testRetrievingSignedIntegerValues() {
        defaults.setInteger(Int.min, forKey: "integer")
        XCTAssertEqual(defaults["integer"] as Int, Int.min, "Should be able to retrieve an integer value using subscripting")

        defaults.setInteger(Int.max, forKey: "integer")
        XCTAssertEqual(defaults["integer"] as Int, Int.max, "Should be able to retrieve an integer value using subscripting")

        defaults.setInteger(Int(Int8.max), forKey: "integer")
        XCTAssertEqual(defaults["integer"] as Int, Int(Int8.max), "Should be able to retrieve an integer value using subscripting")

        defaults.setInteger(Int(Int16.min), forKey: "integer")
        XCTAssertEqual(defaults["integer"] as Int, Int(Int16.min), "Should be able to retrieve an integer value using subscripting")

        defaults.setInteger(Int(Int32.max), forKey: "integer")
        XCTAssertEqual(defaults["integer"] as Int, Int(Int32.max), "Should be able to retrieve an integer value using subscripting")

        defaults.setInteger(Int(Int64.min), forKey: "integer")
        XCTAssertEqual(defaults["integer"] as Int, Int(Int64.min), "Should be able to retrieve an integer value using subscripting")
    }

    func testStoringFloatValues() {
        defaults["float"] = Float(0.0)
        XCTAssertEqual(defaults.floatForKey("float"), Float(0), "Should be able to store a float value using subscripting")

        defaults["float"] = Float.infinity
        XCTAssertEqual(defaults.floatForKey("float"), Float.infinity, "Should be able to store a float value using subscripting")

        defaults["float"] = -(Float.infinity)
        XCTAssertEqual(defaults.floatForKey("float"), -(Float.infinity), "Should be able to store a float value using subscripting")
    }

    func testRetrievingFloatValues() {
        defaults.setFloat(0.0, forKey: "float")
        XCTAssertEqual(defaults["float"] as Float, Float(0.0), "Should be able to retrieve a float value using subscripting")

        defaults.setFloat(14.42, forKey: "float")
        XCTAssertEqual(defaults["float"] as Float, Float(14.42), "Should be able to retrieve a float value using subscripting")

        defaults.setFloat(-14.42e-10, forKey: "float")
        XCTAssertEqual(defaults["float"] as Float, Float(-14.42e-10), "Should be able to retrieve a float value using subscripting")
    }

    func testStoringDoubleValues() {
        defaults["double"] = Double(0.0)
        XCTAssertEqual(defaults.doubleForKey("double"), Double(0.0), "Should be able to store a double value using subscripting")

        defaults["double"] = Double.infinity
        XCTAssertEqual(defaults.doubleForKey("double"), Double.infinity, "Should be able to store a double value using subscripting")

        defaults["double"] = Float.infinity
        XCTAssertEqual(defaults.doubleForKey("double"), Double.infinity, "Float.infinity should be stored as Double.infinity")

        defaults["double"] = -(Double.infinity)
        XCTAssertEqual(defaults.doubleForKey("double"), -(Double.infinity), "Should be able to store a double value using subscripting")

        defaults["double"] = -(Float.infinity)
        XCTAssertEqual(defaults.doubleForKey("double"), -(Double.infinity), "Negative Float.infinity should be stored as negative Double.infinity")
    }

    func testRetrievingDoubleValues() {
        defaults.setDouble(0, forKey: "double")
        XCTAssertEqual(defaults["double"] as Double, Double(0), "Should be able to retrieve a double value using subscripting")

        defaults.setDouble(Double.infinity, forKey: "double")
        XCTAssertEqual(defaults["double"] as Double, Double.infinity, "Should be able to retrieve a double value using subscripting")

        defaults.setFloat(Float.infinity, forKey: "double")
        XCTAssertEqual(defaults["double"] as Double, Double.infinity, "Float.infinity should be stored as Double.infinity")

        defaults.setDouble(-(Double.infinity), forKey: "double")
        XCTAssertEqual(defaults["double"] as Double, -(Double.infinity), "Should be able to retrieve a double value using subscripting")

        defaults.setFloat(-(Float.infinity), forKey: "double")
        XCTAssertEqual(defaults["double"] as Double, -(Double.infinity), "Negative Float.infinity should be stored as negative Double.infinity")
    }

    func testStoringStringValue() {
        defaults["string"] = "Sample String Value"
        XCTAssertEqual(defaults.stringForKey("string")!, "Sample String Value", "Should be able to store a string value using subscripting")
    }

    func testRetrievingStringValue() {
        defaults.setObject("Sample String Value", forKey: "string")
        XCTAssertEqual(defaults["string"] as String, "Sample String Value", "Should be able to retrieve a string value using subscripting")
    }

    func testStoringURLValue() {
        let url = NSURL(string: "http://www.example.com")!
        defaults["url"] = url
        XCTAssertEqual(defaults.URLForKey("url")!, url, "Should be able to store a URL value using subscripting")
    }

    func testRetrievingURLValue() {
        let url = NSURL(string: "http://www.example.com")!
        defaults.setURL(url, forKey: "url")
        XCTAssertEqual(defaults["url"] as NSURL, url, "Should be able to retrieve a URL value using subscripting")
    }

    func testStoringArrayValue() {
        let array = [NSString(string: "one"), NSNumber(integer: 14), NSObject()]
        defaults["array"] = array
        let storedArray = defaults.arrayForKey("array")!
        XCTAssertEqual(storedArray[0] as NSObject, array[0], "Should be able to store an array value using subscripting")
        XCTAssertEqual(storedArray[1] as NSObject, array[1], "Should be able to store an array value using subscripting")
        XCTAssertEqual(storedArray[2] as NSObject, array[2], "Should be able to store an array value using subscripting")
    }

//    func testRetrievingArrayValue() {
//        let array = ["one", 2, NSObject()]
//        defaults.setArray(array, forKey: "array")
//        XCTAssertEqual(defaults["array"] as Array, array, "Should be able to retrieve an array value using subscripting")
//    }

}
