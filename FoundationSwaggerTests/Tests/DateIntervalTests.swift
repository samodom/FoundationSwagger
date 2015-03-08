//
//  DateIntervalTests.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 3/8/15.
//  Copyright (c) 2015 Swagger Soft. All rights reserved.
//

import XCTest

class DateIntervalTests: XCTestCase {

    let now = NSDate()
    let beforeDate = NSDate(timeIntervalSinceNow: -4.321)
    let afterDate = NSDate(timeIntervalSinceNow: 2.458)
    let distantPast = NSDate.distantPast() as! NSDate
    let distantFuture = NSDate.distantFuture() as! NSDate
    var closedInterval: ClosedInterval<NSDate>!
    var halfOpenInterval: HalfOpenInterval<NSDate>!

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testCreatingClosedInterval() {
        closedInterval = beforeDate ... afterDate
        XCTAssertEqual(closedInterval.start, beforeDate, "The interval should be created with the correct start")
        XCTAssertEqual(closedInterval.end, afterDate, "The interval should be created with the correct end")
        XCTAssertFalse(closedInterval.isEmpty, "The interval should not be empty")
        XCTAssertTrue(closedInterval.contains(beforeDate), "The interval should contain the start")
        XCTAssertTrue(closedInterval.contains(now), "The interval should contain dates between the start and end")
        XCTAssertTrue(closedInterval.contains(afterDate), "The interval should contain the end")
    }

    func testCreatingHalfOpenInterval() {
        halfOpenInterval = beforeDate ..< afterDate
        XCTAssertEqual(halfOpenInterval.start, beforeDate, "The interval should be created with the correct start")
        XCTAssertEqual(halfOpenInterval.end, afterDate, "The interval should be created with the correct end")
        XCTAssertFalse(halfOpenInterval.isEmpty, "The interval should not be empty")
        XCTAssertTrue(halfOpenInterval.contains(beforeDate), "The interval should contain the start")
        XCTAssertTrue(halfOpenInterval.contains(now), "The interval should contain dates between the start and end")
        XCTAssertFalse(halfOpenInterval.contains(afterDate), "The interval should not contain the end")
    }

    func testAllOfTimeInterval() {
        closedInterval = NSDate.allOfTime()
        XCTAssertEqual(closedInterval.start, distantPast, "The interval start should be the distant past")
        XCTAssertEqual(closedInterval.end, distantFuture, "The interval end should be the distant future")
        XCTAssertFalse(closedInterval.isEmpty, "The interval should not be empty")
        XCTAssertTrue(closedInterval.contains(distantPast), "The interval should contain the start")
        XCTAssertTrue(closedInterval.contains(now), "The interval should contain dates between the start and end")
        XCTAssertTrue(closedInterval.contains(distantFuture), "The interval should contain the end")
    }

    func testNeverInterval() {
        halfOpenInterval = NSDate.never()
        XCTAssertEqual(halfOpenInterval.start, distantPast, "The interval start should be the distant past")
        XCTAssertEqual(halfOpenInterval.end, distantPast, "The interval end should be the distant past")
        XCTAssertTrue(halfOpenInterval.isEmpty, "The interval should be empty")
        XCTAssertFalse(halfOpenInterval.contains(distantPast), "The interval should not contain the start")
        XCTAssertFalse(halfOpenInterval.contains(now), "The interval should contain any dates")
        XCTAssertFalse(halfOpenInterval.contains(distantFuture), "The interval should not contain the end")
    }

    func testBeforeInterval() {
        halfOpenInterval = now.before()
        XCTAssertEqual(halfOpenInterval.start, distantPast, "The interval should start in the distant past")
        XCTAssertEqual(halfOpenInterval.end, now, "The interval should end with the provided date")
        XCTAssertFalse(halfOpenInterval.isEmpty, "The interval should not be empty")
        XCTAssertTrue(halfOpenInterval.contains(distantPast), "The interval should contain the start")
        XCTAssertTrue(halfOpenInterval.contains(beforeDate), "The interval should contain dates between the start and end")
        XCTAssertFalse(halfOpenInterval.contains(now), "The interval should not contain the end")
    }

    func testAfterInterval() {
        closedInterval = now.after()
        XCTAssertEqual(closedInterval.start, now, "The interval start should be the provided date")
        XCTAssertEqual(closedInterval.end, distantFuture, "The interval end should be the distant future")
        XCTAssertFalse(closedInterval.isEmpty, "The interval should not be empty")
        XCTAssertTrue(closedInterval.contains(now), "The interval should contain the start")
        XCTAssertTrue(closedInterval.contains(afterDate), "The interval should contain dates between the start and end")
        XCTAssertTrue(closedInterval.contains(distantFuture), "The interval should contain the end")
    }

    func testDuringClosedInterval() {
        closedInterval = now ... afterDate
        XCTAssertFalse(distantPast.during(closedInterval), "The date should not be considered during the provided interval")
        XCTAssertFalse(beforeDate.during(closedInterval), "The date should not be considered during the provided interval")
        XCTAssertTrue(now.during(closedInterval), "The date should be considered during the provided interval")
        XCTAssertTrue(afterDate.during(closedInterval), "The date should be considered during the provided interval")
        XCTAssertFalse(distantFuture.during(closedInterval), "The date should not be considered during the provided interval")
    }

    func testDuringHalfOpenInterval() {
        halfOpenInterval = now ..< afterDate
        XCTAssertFalse(distantPast.during(halfOpenInterval), "The date should not be considered during the provided interval")
        XCTAssertFalse(beforeDate.during(halfOpenInterval), "The date should not be considered during the provided interval")
        XCTAssertTrue(now.during(halfOpenInterval), "The date should be considered during the provided interval")
        XCTAssertFalse(afterDate.during(halfOpenInterval), "The date should not be considered during the provided interval")
        XCTAssertFalse(distantPast.during(halfOpenInterval), "The date should be considered during the provided interval")
    }

}
