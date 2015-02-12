//
//  Stack.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 9/4/14.
//  Copyright (c) 2014 Swagger Soft. All rights reserved.
//

import Foundation

public struct Stack<T> {
    private var stackArray = [T]()

    public func hasMoreItems() -> Bool {
        return stackArray.count > 0
    }

    public mutating func push(item: T) {
        stackArray.append(item)
    }

    public mutating func pop() -> T {
        return stackArray.removeLast()
    }

    public func peek() -> T? {
        return stackArray.last
    }
}
