//
//  NSDateIntervals.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 3/8/15.
//  Copyright (c) 2015 Swagger Soft. All rights reserved.
//

import Foundation

public extension NSDate {

    /**
        Produces a date interval representing the range of all time.
    */
    public class func allOfTime() -> ClosedInterval<NSDate> {
        let start = distantPast() as! NSDate
        let end = distantFuture() as! NSDate
        return start ... end
    }

    /**
        Produces a date interval representing an empty range of time.
    */
    public class func never() -> HalfOpenInterval<NSDate> {
        let start = distantPast() as! NSDate
        return start ..< start
    }

    /**
        Produces a date interval representing the time before this date.
    */
    public func before() -> HalfOpenInterval<NSDate> {
        let start = NSDate.distantPast() as! NSDate
        return start ..< self
    }

    /**
        Produces a date interval representing the time after this date including this date.
    */
    public func after() -> ClosedInterval<NSDate> {
        let end = NSDate.distantFuture() as! NSDate
        return self ... end
    }

    /**
        Indicates whether or not this date is within the specified date interval.
        @param          interval Date interval in which to check for this date's inclusion.
        @return         Boolean value indicating whether or not this date is within the provided interval.
    */
    public func during(interval: ClosedInterval<NSDate>) -> Bool {
        return interval.contains(self)
    }

    /**
        Indicates whether or not this date is within the specified date interval.
        @param          interval Date interval in which to check for this date's inclusion.
        @return         Boolean value indicating whether or not this date is within the provided interval.
    */
    public func during(interval: HalfOpenInterval<NSDate>) -> Bool {
        return interval.contains(self)
    }

}
