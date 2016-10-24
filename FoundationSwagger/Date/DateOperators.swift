//
//  DateOperators.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 3/8/15.
//  Copyright (c) 2015 Swagger Soft. All rights reserved.
//

import Foundation

/**
    Overloaded subtraction operator for calculating the time interval between two dates, assuming the same time zone.
    @param          lhs Date from which to subtract another date.
    @param          rhs Date to subtract from the first date.
    @return         The time interval produced by calling `lhs.timeIntervalSinceDate(rhs)`.
*/
public func -(lhs: Date, rhs: Date) -> TimeInterval {
    return lhs.timeIntervalSince(rhs)
}
