//
//  DateTests.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 3/8/15.
//  Copyright (c) 2015 Swagger Soft. All rights reserved.
//

import XCTest

let TIME_TOLERANCE = NSTimeInterval(1e-7)

class DateTests: XCTestCase {

    let now = NSDate()
    var earlier: NSDate!
    var later: NSDate!
    var expectedDate: NSDate!
    let positiveInterval = NSTimeInterval(24.42)
    let negativeInterval = NSTimeInterval(-14.99)
    var expectedInterval: NSTimeInterval!
    var lessThan = false
    var lessThanOrEqual = false
    var greaterThan = false
    var greaterThanOrEqual = false


    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    private func makeOtherDates() {
        earlier = now.dateByAddingTimeInterval(negativeInterval)
        later = now.dateByAddingTimeInterval(positiveInterval)
    }

    private func nudgeDateEarlier(date: NSDate) -> NSDate {
        return date.dateByAddingTimeInterval(-TIME_TOLERANCE)
    }

    private func nudgeDateLater(date: NSDate) -> NSDate {
        return date.dateByAddingTimeInterval(TIME_TOLERANCE)
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
        makeOtherDates()
        let interval = later - earlier
        expectedInterval = later.timeIntervalSinceDate(earlier)
        XCTAssertEqual(interval, expectedInterval, "The subtraction operator should produce the time interval between the two dates")
    }

    func testSubtractingLaterDateFromEarlierDate() {
        makeOtherDates()
        let interval = earlier - later
        expectedInterval = earlier.timeIntervalSinceDate(later)
        XCTAssertEqual(interval, expectedInterval, "The subtraction operator should produce the time interval between the two dates")
    }

    //  MARK: Date comparison

    func testNowIsEqualToNow() {
        XCTAssertEqual(now, now, "A date should be considered equal to itself")
    }

    func testNotNowIsNotEqualToNow() {
        earlier = nudgeDateEarlier(now)
        XCTAssertNotEqual(earlier, now, "A date even a smidge earlier should not be considered equal")
        later = nudgeDateLater(now)
        XCTAssertNotEqual(later, now, "A date even a smidge later should not be considered equal")
    }

    func testEarlierDateLessThanNow() {
        makeOtherDates()
        lessThan = earlier < now
        XCTAssertTrue(lessThan, "The earlier date should be considered 'less than' the later date")
        earlier = nudgeDateEarlier(now)
        lessThan = earlier < now
        XCTAssertTrue(lessThan, "The earlier date should be considered 'less than' the later date")
    }

    func testEarlierDateLessThanOrEqualToNow() {
        makeOtherDates()
        lessThanOrEqual = earlier <= now
        XCTAssertTrue(lessThanOrEqual, "The earlier date should be considered 'less than or equal to' the later date")
        earlier = nudgeDateEarlier(now)
        lessThanOrEqual = earlier <= now
        XCTAssertTrue(lessThanOrEqual, "The earlier date should be considered 'less than or equal to' the later date")
    }

    func testLaterDateNotLessThanNow() {
        makeOtherDates()
        lessThan = later < now
        XCTAssertFalse(lessThan, "The later date should be considered 'less than' the earlier date")
    }

    func testLaterDateNotLessThanOrEqualToNow() {
        makeOtherDates()
        lessThanOrEqual = later <= now
        XCTAssertFalse(lessThanOrEqual, "The later date should not be considered 'less than or equal to' the earlier date")
    }
    
    func testNowNotLessThanNow() {
        lessThan = now < now
        XCTAssertFalse(lessThan, "A date should not be considered 'less than' itself")
    }

    func testNowLessThanOrEqualToNow() {
        lessThanOrEqual = now <= now
        XCTAssertTrue(lessThanOrEqual, "A date should be considered 'less than or equal to' itself")
    }
    
}
