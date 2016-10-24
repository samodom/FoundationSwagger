//
//  DateRangeTests.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 3/8/15.
//  Copyright (c) 2015 Swagger Soft. All rights reserved.
//

import XCTest
import FoundationSwagger

class DateRangeTests: XCTestCase {

    let now = Date()
    let beforeDate = Date(timeIntervalSinceNow: -4.321)
    let afterDate = Date(timeIntervalSinceNow: 2.458)
    let distantPast = Date.distantPast 
    let distantFuture = Date.distantFuture 
    var closedRange: ClosedRange<Date>!
    var halfOpenRange: Range<Date>!

    func testCreatingClosedRange() {
        closedRange = beforeDate ... afterDate
        XCTAssertEqual(closedRange.lowerBound, beforeDate, "The range should be created with the correct start")
        XCTAssertEqual(closedRange.upperBound, afterDate, "The range should be created with the correct end")
        XCTAssertFalse(closedRange.isEmpty, "The range should not be empty")
        XCTAssertTrue(closedRange.contains(beforeDate), "The range should contain the start")
        XCTAssertTrue(closedRange.contains(now), "The range should contain dates between the start and end")
        XCTAssertTrue(closedRange.contains(afterDate), "The range should contain the end")
    }

    func testCreatingHalfOpenRange() {
        halfOpenRange = beforeDate ..< afterDate
        XCTAssertEqual(halfOpenRange.lowerBound, beforeDate, "The range should be created with the correct start")
        XCTAssertEqual(halfOpenRange.upperBound, afterDate, "The range should be created with the correct end")
        XCTAssertFalse(halfOpenRange.isEmpty, "The range should not be empty")
        XCTAssertTrue(halfOpenRange.contains(beforeDate), "The range should contain the start")
        XCTAssertTrue(halfOpenRange.contains(now), "The range should contain dates between the start and end")
        XCTAssertFalse(halfOpenRange.contains(afterDate), "The range should not contain the end")
    }

    func testAllOfTimeRange() {
        closedRange = Date.allOfTime()
        XCTAssertEqual(closedRange.lowerBound, distantPast, "The range start should be the distant past")
        XCTAssertEqual(closedRange.upperBound, distantFuture, "The range end should be the distant future")
        XCTAssertFalse(closedRange.isEmpty, "The range should not be empty")
        XCTAssertTrue(closedRange.contains(distantPast), "The range should contain the start")
        XCTAssertTrue(closedRange.contains(now), "The range should contain dates between the start and end")
        XCTAssertTrue(closedRange.contains(distantFuture), "The range should contain the end")
    }

    func testNeverRange() {
        halfOpenRange = Date.never()
        XCTAssertEqual(halfOpenRange.lowerBound, distantPast, "The range start should be the distant past")
        XCTAssertEqual(halfOpenRange.upperBound, distantPast, "The range end should be the distant past")
        XCTAssertTrue(halfOpenRange.isEmpty, "The range should be empty")
        XCTAssertFalse(halfOpenRange.contains(distantPast), "The range should not contain the start")
        XCTAssertFalse(halfOpenRange.contains(now), "The range should contain any dates")
        XCTAssertFalse(halfOpenRange.contains(distantFuture), "The range should not contain the end")
    }

    func testBeforeRange() {
        halfOpenRange = now.before()
        XCTAssertEqual(halfOpenRange.lowerBound, distantPast, "The range should start in the distant past")
        XCTAssertEqual(halfOpenRange.upperBound, now, "The range should end with the provided date")
        XCTAssertFalse(halfOpenRange.isEmpty, "The range should not be empty")
        XCTAssertTrue(halfOpenRange.contains(distantPast), "The range should contain the start")
        XCTAssertTrue(halfOpenRange.contains(beforeDate), "The range should contain dates between the start and end")
        XCTAssertFalse(halfOpenRange.contains(now), "The range should not contain the end")
    }

    func testAfterRange() {
        closedRange = now.after()
        XCTAssertEqual(closedRange.lowerBound, now, "The range start should be the provided date")
        XCTAssertEqual(closedRange.upperBound, distantFuture, "The range end should be the distant future")
        XCTAssertFalse(closedRange.isEmpty, "The range should not be empty")
        XCTAssertTrue(closedRange.contains(now), "The range should contain the start")
        XCTAssertTrue(closedRange.contains(afterDate), "The range should contain dates between the start and end")
        XCTAssertTrue(closedRange.contains(distantFuture), "The range should contain the end")
    }

    func testDuringClosedRange() {
        closedRange = now ... afterDate
        XCTAssertFalse(distantPast.during(closedRange), "The date should not be considered during the provided range")
        XCTAssertFalse(beforeDate.during(closedRange), "The date should not be considered during the provided range")
        XCTAssertTrue(now.during(closedRange), "The date should be considered during the provided range")
        XCTAssertTrue(afterDate.during(closedRange), "The date should be considered during the provided range")
        XCTAssertFalse(distantFuture.during(closedRange), "The date should not be considered during the provided range")
    }

    func testDuringHalfOpenRange() {
        halfOpenRange = now ..< afterDate
        XCTAssertFalse(distantPast.during(halfOpenRange), "The date should not be considered during the provided range")
        XCTAssertFalse(beforeDate.during(halfOpenRange), "The date should not be considered during the provided range")
        XCTAssertTrue(now.during(halfOpenRange), "The date should be considered during the provided range")
        XCTAssertFalse(afterDate.during(halfOpenRange), "The date should not be considered during the provided range")
        XCTAssertFalse(distantPast.during(halfOpenRange), "The date should be considered during the provided range")
    }

}
