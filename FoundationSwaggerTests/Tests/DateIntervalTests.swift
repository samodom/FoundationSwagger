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

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testCreatingClosedInterval() {
        let interval = beforeDate ... afterDate
        XCTAssertEqual(interval.start, beforeDate, "The interval should be created with the correct start")
        XCTAssertEqual(interval.end, afterDate, "The interval should be created with the correct end")
        XCTAssertFalse(interval.isEmpty, "The interval should not be empty")
        XCTAssertTrue(interval.contains(beforeDate), "The interval should contain the start")
        XCTAssertTrue(interval.contains(now), "The interval should contain dates between the start and end")
        XCTAssertTrue(interval.contains(afterDate), "The interval should contain the end")
    }

    func testCreatingHalfOpenInterval() {
        let interval = beforeDate ..< afterDate
        XCTAssertEqual(interval.start, beforeDate, "The interval should be created with the correct start")
        XCTAssertEqual(interval.end, afterDate, "The interval should be created with the correct end")
        XCTAssertFalse(interval.isEmpty, "The interval should not be empty")
        XCTAssertTrue(interval.contains(beforeDate), "The interval should contain the start")
        XCTAssertTrue(interval.contains(now), "The interval should contain dates between the start and end")
        XCTAssertFalse(interval.contains(afterDate), "The interval should not contain the end")
    }

    func testAllOfTimeInterval() {
        let interval = NSDate.allOfTime()
        XCTAssertEqual(interval.start, distantPast, "The interval start should be the distant past")
        XCTAssertEqual(interval.end, distantFuture, "The interval end should be the distant future")
        XCTAssertFalse(interval.isEmpty, "The interval should not be empty")
        XCTAssertTrue(interval.contains(distantPast), "The interval should contain the start")
        XCTAssertTrue(interval.contains(now), "The interval should contain dates between the start and end")
        XCTAssertTrue(interval.contains(distantFuture), "The interval should contain the end")
    }

    func testNeverInterval() {
        let interval = NSDate.never()
        XCTAssertEqual(interval.start, distantPast, "The interval start should be the distant past")
        XCTAssertEqual(interval.end, distantPast, "The interval end should be the distant past")
        XCTAssertTrue(interval.isEmpty, "The interval should be empty")
        XCTAssertFalse(interval.contains(distantPast), "The interval should not contain the start")
        XCTAssertFalse(interval.contains(now), "The interval should contain any dates")
        XCTAssertFalse(interval.contains(distantFuture), "The interval should not contain the end")
    }

    func testBeforeInterval() {
        let interval = now.before()
        XCTAssertEqual(interval.start, distantPast, "The interval should start in the distant past")
        XCTAssertEqual(interval.end, now, "The interval should end with the provided date")
        XCTAssertFalse(interval.isEmpty, "The interval should not be empty")
        XCTAssertTrue(interval.contains(distantPast), "The interval should contain the start")
        XCTAssertTrue(interval.contains(beforeDate), "The interval should contain dates between the start and end")
        XCTAssertFalse(interval.contains(now), "The interval should not contain the end")
    }

    func testAfterInterval() {
        let interval = now.after()
        XCTAssertEqual(interval.start, now, "The interval start should be the provided date")
        XCTAssertEqual(interval.end, distantFuture, "The interval end should be the distant future")
        XCTAssertFalse(interval.isEmpty, "The interval should not be empty")
        XCTAssertTrue(interval.contains(now), "The interval should contain the start")
        XCTAssertTrue(interval.contains(afterDate), "The interval should contain dates between the start and end")
        XCTAssertTrue(interval.contains(distantFuture), "The interval should contain the end")
    }

}
