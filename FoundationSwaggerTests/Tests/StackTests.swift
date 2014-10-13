//
//  StackTests.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 9/16/14.
//  Copyright (c) 2014 Swagger Soft. All rights reserved.
//

import XCTest

class StackTests: XCTestCase {

    var stack = Stack<String>()

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testEmptyStackHasNoItems() {
        XCTAssertFalse(stack.hasMoreItems(), "An empty stack should not report having any items")
    }

    func testCanPeekAtEmptyStack() {
        XCTAssertTrue(stack.peek() == nil, "Peeking at an empty stack should produce a nil value")
    }

    func testCanPushItemOntoStack() {
        stack.push("alpha")
        XCTAssertTrue(stack.hasMoreItems(), "The stack should push an item and then report having items")
    }

    func testCanPeekAtItemOnTopOfStack() {
        stack.push("alpha")
        XCTAssertTrue(stack.peek() != nil, "Peeking at a non-empty stack should produce a non-nil value")
        XCTAssertEqual(stack.peek()!, "alpha", "The stack should allow peeking at the top item")
        XCTAssertTrue(stack.hasMoreItems(), "The stack should still report having items since it should not pop on a peek")
    }

    func testCanPopItemOffOfStack() {
        stack.push("alpha")
        let poppedValue = stack.pop()
        XCTAssertEqual(poppedValue, "alpha", "The stack should pop an item")
        XCTAssertFalse(stack.hasMoreItems(), "The stack should not have any more items after popping the only item")
    }

    func testStackMaintainsLastInFirstOutOrdering() {
        stack.push("alpha")
        stack.push("bravo")
        stack.push("charlie")
        XCTAssertEqual(stack.pop(), "charlie", "The top item should be popped")
        stack.push("delta")
        XCTAssertEqual(stack.pop(), "delta", "The top item should be popped")
        XCTAssertEqual(stack.pop(), "bravo", "The top item should be popped")
        XCTAssertEqual(stack.pop(), "alpha", "The top item should be popped")
        XCTAssertFalse(stack.hasMoreItems(), "The stack should be empty after popping off all of the values")
    }
}
