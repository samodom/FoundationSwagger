//
//  DateRanges.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 3/8/15.
//  Copyright (c) 2015 Swagger Soft. All rights reserved.
//

import Foundation

public extension Date {

    /// Produces a date range representing the range of all time.
    public static func allOfTime() -> ClosedRange<Date> {
        let start = distantPast 
        let end = distantFuture 
        return start ... end
    }

    /// Produces a date range representing an empty range of time.
    public static func never() -> Range<Date> {
        let start = distantPast 
        return start ..< start
    }

    /// Produces a date range representing the time before this date.
    public func before() -> Range<Date> {
        let start = Date.distantPast 
        return start ..< self
    }

    /// Produces a date range representing the time after this date including this date.
    public func after() -> ClosedRange<Date> {
        let end = Date.distantFuture 
        return self ... end
    }

    public func during(_ range: ClosedRange<Date>) -> Bool {
    /// Indicates whether or not this date is within the specified date range.
    /// - parameter range: Date range in which to check for this date's inclusion.
    /// - returns: A boolean value indicating whether or not this date is within the provided range.
        return range.contains(self)
    }

    public func during(_ range: Range<Date>) -> Bool {
    /// Indicates whether or not this date is within the specified date range.
    /// - parameter range: Date range in which to check for this date's inclusion.
    /// - returns: A boolean value indicating whether or not this date is within the provided range.
        return range.contains(self)
    }

}
