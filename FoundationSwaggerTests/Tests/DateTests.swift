//
//  DateTests.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 3/8/15.
//  Copyright (c) 2015 Swagger Soft. All rights reserved.
//

import XCTest

class DateTests: XCTestCase {

    let now = NSDate()
    var earlier: NSDate!
    var later: NSDate!
    var expected: NSDate!
    let positiveInterval = NSTimeInterval(24.42)
    let negativeInterval = NSTimeInterval(-14.99)

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testAddingPositiveIntervalToDate() {
        later = now + positiveInterval
        expected = now.dateByAddingTimeInterval(positiveInterval)
        XCTAssertEqual(later, expected, "The positive interval should be added to the date")
    }

    func testAddingNegativeIntervalToDate() {
        earlier = now + negativeInterval
        expected = now.dateByAddingTimeInterval(negativeInterval)
        XCTAssertEqual(earlier, expected, "The negative interval should be added to the date")
    }

    func testSubtractingPositiveIntervalFromDate() {
        earlier = now - positiveInterval
        expected = now.dateByAddingTimeInterval(-positiveInterval)
        XCTAssertEqual(earlier, expected, "The positive interval should be subtracted from the date")
    }

    func testSubtractingNegativeIntervalFromDate() {
        later = now - negativeInterval
        expected = now.dateByAddingTimeInterval(-negativeInterval)
        XCTAssertEqual(later, expected, "The negative interval should be subtracted from the date")
    }

}
