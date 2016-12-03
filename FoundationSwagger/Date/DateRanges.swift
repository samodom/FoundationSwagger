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

    /// Indicates whether this date is within the specified date range.
    /// - parameter range: Date range in which to check for this date's inclusion.
    /// - returns: A boolean value indicating whether this date is within the provided range.
    public func isDuring(_ range: ClosedRange<Date>) -> Bool {
        return range.contains(self)
    }

    /// Indicates whether this date is within the specified date range.
    /// - parameter range: Date range in which to check for this date's inclusion.
    /// - returns: A boolean value indicating whether this date is within the provided range.
    public func isDuring(_ range: Range<Date>) -> Bool {
        return range.contains(self)
    }

}
