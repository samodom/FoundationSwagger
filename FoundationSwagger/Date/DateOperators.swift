//
//  DateOperators.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 3/8/15.
//  Copyright (c) 2015 Swagger Soft. All rights reserved.
//

import Foundation

/**
    Overloaded addition operator to allow the creation of dates using an existing date and a time interval.
    @param          date NSDate to use as the base date.
    @param          interval NSTimeInterval to add to the base date.
    @return         New date produced by calling `date.dateByAddingTimeInterval(interval)`.
*/
public func +(date: NSDate, interval: NSTimeInterval) -> NSDate {
    return date.dateByAddingTimeInterval(interval)
}

/**
    Overloaded subtraction operator to allow the creation of dates using an existing date and a time interval.
    @param          date NSDate to use as the base date.
    @param          interval NSTimeInterval to subtract from the base date.
    @return         New date produced by calling `date.dateByAddingTimeInterval(-interval)`.
*/
public func -(date: NSDate, interval: NSTimeInterval) -> NSDate {
    return date.dateByAddingTimeInterval(-interval)
}
