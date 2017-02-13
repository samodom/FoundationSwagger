//
//  SwiftMethodSwizzlingTests.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 10/24/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

import XCTest
import FoundationSwagger


class SwiftMethodSwizzlingTests: MethodSwizzlingTestCase {

    func testSwizzlingSwiftClassMethods() {
        setUpSurrogate(classType: .swift, methodType: .`class`)

        //  Swizzled
        surrogate.useAlternateImplementation()
        validateMethodsAreSwizzled()

        //  Shouldn't swizzle when swizzled
        surrogate.useAlternateImplementation()
        validateMethodsAreSwizzled()

        //  Unswizzled
        surrogate.useOriginalImplementation()
        validateMethodsAreNotSwizzled()

        //  Shouldn't unswizzle when unswizzled
        surrogate.useOriginalImplementation()
        validateMethodsAreNotSwizzled()
    }

    func testSwizzlingSwiftClassMethodsWithContext() {
        //  Swizzled
        setUpSurrogate(classType: .swift, methodType: .`class`)

        surrogate.withAlternateImplementation() {
            executedContext = true
            validateMethodsAreSwizzled()
        }

        XCTAssertTrue(executedContext, "The context should be executed while the methods are swizzled")
        validateMethodsAreNotSwizzled()
        executedContext = false

        //  Unswizzled
        surrogate.useAlternateImplementation()

        surrogate.withOriginalImplementation() {
            executedContext = true
            validateMethodsAreNotSwizzled()

        }

        XCTAssertTrue(executedContext, "The context should be executed while the methods are swizzled")
        validateMethodsAreSwizzled()

        surrogate.useOriginalImplementation()
    }

    func testSwizzlingSwiftInstanceMethods() {
        setUpSurrogate(classType: .swift, methodType: .instance)

        //  Swizzled
        surrogate.useAlternateImplementation()
        validateMethodsAreSwizzled()

        //  Shouldn't swizzle when swizzled
        surrogate.useAlternateImplementation()
        validateMethodsAreSwizzled()

        //  Unswizzled
        surrogate.useOriginalImplementation()
        validateMethodsAreNotSwizzled()

        //  Shouldn't unswizzle when unswizzled
        surrogate.useOriginalImplementation()
        validateMethodsAreNotSwizzled()
    }

    func testSwizzlingSwiftInstanceMethodsWithContext() {
        //  Swizzled
        setUpSurrogate(classType: .swift, methodType: .instance)

        surrogate.withAlternateImplementation() {
            executedContext = true
            validateMethodsAreSwizzled()
        }

        XCTAssertTrue(executedContext, "The context should be executed while the methods are swizzled")
        validateMethodsAreNotSwizzled()
        executedContext = false

        //  Unswizzled
        surrogate.useAlternateImplementation()

        surrogate.withOriginalImplementation() {
            executedContext = true
            validateMethodsAreNotSwizzled()
        }

        XCTAssertTrue(executedContext, "The context should be executed while the methods are swizzled")
        validateMethodsAreSwizzled()
        
        surrogate.useOriginalImplementation()
    }

}
