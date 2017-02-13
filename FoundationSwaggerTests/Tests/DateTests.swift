//
//  DateTests.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 3/8/15.
//  Copyright (c) 2015 Swagger Soft. All rights reserved.
//

import XCTest
import  FoundationSwagger

fileprivate let TimeTolerance = TimeInterval(1e-7)

class DateTests: XCTestCase {

    let now = Date()
    var earlier: Date!
    var later: Date!
    var expectedDate: Date!
    let positiveInterval = TimeInterval(24.42)
    let negativeInterval = TimeInterval(-14.99)
    var expectedInterval: TimeInterval!

    fileprivate func makeOtherDates() {
        earlier = now.addingTimeInterval(negativeInterval)
        later = now.addingTimeInterval(positiveInterval)
    }

    func testSubtractingDateFromItself() {
        let interval = now - now
        expectedInterval = 0.0
        XCTAssertEqual(interval, expectedInterval,
                       "There should be a 0.0 second interval between a date and itself")
    }

    func testSubtractingEarlierDateFromLaterDate() {
        makeOtherDates()
        let interval = later - earlier
        expectedInterval = later.timeIntervalSince(earlier)
        XCTAssertEqual(interval, expectedInterval,
                       "The subtraction operator should produce the time interval between the two dates")
    }

    func testSubtractingLaterDateFromEarlierDate() {
        makeOtherDates()
        let interval = earlier - later
        expectedInterval = earlier.timeIntervalSince(later)
        XCTAssertEqual(interval, expectedInterval,
                       "The subtraction operator should produce the time interval between the two dates")
    }

}
