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
    var expectedDate: NSDate!
    let positiveInterval = NSTimeInterval(24.42)
    let negativeInterval = NSTimeInterval(-14.99)
    var expectedInterval: NSTimeInterval!

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    //  MARK: Time interval addition/subtraction

    func testAddingPositiveIntervalToDate() {
        later = now + positiveInterval
        expectedDate = now.dateByAddingTimeInterval(positiveInterval)
        XCTAssertEqual(later, expectedDate, "The positive interval should be added to the date")
    }

    func testAddingNegativeIntervalToDate() {
        earlier = now + negativeInterval
        expectedDate = now.dateByAddingTimeInterval(negativeInterval)
        XCTAssertEqual(earlier, expectedDate, "The negative interval should be added to the date")
    }

    func testSubtractingPositiveIntervalFromDate() {
        earlier = now - positiveInterval
        expectedDate = now.dateByAddingTimeInterval(-positiveInterval)
        XCTAssertEqual(earlier, expectedDate, "The positive interval should be subtracted from the date")
    }

    func testSubtractingNegativeIntervalFromDate() {
        later = now - negativeInterval
        expectedDate = now.dateByAddingTimeInterval(-negativeInterval)
        XCTAssertEqual(later, expectedDate, "The negative interval should be subtracted from the date")
    }

    //  MARK: Date subtraction

    func testSubtractingDateFromItself() {
        let interval = now - now
        expectedInterval = 0.0
        XCTAssertEqual(interval, expectedInterval, "There should be a 0.0 second interval between a date and itself")
    }

    func testSubtractingEarlierDateFromLaterDate() {
        earlier = now.dateByAddingTimeInterval(negativeInterval)
        later = now.dateByAddingTimeInterval(positiveInterval)
        let interval = later - earlier
        expectedInterval = later.timeIntervalSinceDate(earlier)
        XCTAssertEqual(interval, expectedInterval, "The subtraction operator should produce the time interval between the two dates")
    }

    func testSubtractingLaterDateFromEarlierDate() {
        earlier = now.dateByAddingTimeInterval(negativeInterval)
        later = now.dateByAddingTimeInterval(positiveInterval)
        let interval = earlier - later
        expectedInterval = earlier.timeIntervalSinceDate(later)
        XCTAssertEqual(interval, expectedInterval, "The subtraction operator should produce the time interval between the two dates")
    }

}
