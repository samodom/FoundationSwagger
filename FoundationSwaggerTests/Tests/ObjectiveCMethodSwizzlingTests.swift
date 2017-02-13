//
//  ObjectiveCMethodSwizzlingTests.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 1/2/17.
//  Copyright © 2017 Swagger Soft. All rights reserved.
//

import XCTest

class ObjectiveCMethodSwizzlingTests: MethodSwizzlingTestCase {
    
    func testSwizzlingObjectiveCClassMethods() {
        setUpSurrogate(classType: .objectiveC, methodType: .`class`)

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

    func testSwizzlingObjectiveCClassMethodsWithContext() {
        //  Swizzled
        setUpSurrogate(classType: .objectiveC, methodType: .`class`)

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

    func testSwizzlingObjectiveCInstanceMethods() {
        setUpSurrogate(classType: .objectiveC, methodType: .instance)

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

    func testSwizzlingObjectiveCInstanceMethodsWithContext() {
        //  Swizzled
        setUpSurrogate(classType: .objectiveC, methodType: .instance)

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
        validateMethodsAreSwizzled()
        
        surrogate.useOriginalImplementation()
    }

}
