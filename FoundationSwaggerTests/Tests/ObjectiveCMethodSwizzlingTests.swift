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
        setUpAssociation(classType: .objectiveC, methodType: .`class`)

        //  Swizzled
        association.useAlternateImplementation()
        validateMethodsAreSwizzled()

        //  Shouldn't swizzle when swizzled
        association.useAlternateImplementation()
        validateMethodsAreSwizzled()

        //  Unswizzled
        association.useOriginalImplementation()
        validateMethodsAreNotSwizzled()

        //  Shouldn't unswizzle when unswizzled
        association.useOriginalImplementation()
        validateMethodsAreNotSwizzled()
    }

    func testSwizzlingObjectiveCClassMethodsWithContext() {
        //  Swizzled
        setUpAssociation(classType: .objectiveC, methodType: .`class`)

        association.withAlternateImplementation() {
            executedContext = true
            validateMethodsAreSwizzled()
        }

        XCTAssertTrue(executedContext, "The context should be executed while the methods are swizzled")
        validateMethodsAreNotSwizzled()
        executedContext = false

        //  Unswizzled
        association.useAlternateImplementation()

        association.withOriginalImplementation() {
            executedContext = true
            validateMethodsAreNotSwizzled()

        }

        XCTAssertTrue(executedContext, "The context should be executed while the methods are swizzled")
        validateMethodsAreSwizzled()
        
        association.useOriginalImplementation()
    }

    func testSwizzlingObjectiveCInstanceMethods() {
        setUpAssociation(classType: .objectiveC, methodType: .instance)

        //  Swizzled
        association.useAlternateImplementation()
        validateMethodsAreSwizzled()

        //  Shouldn't swizzle when swizzled
        association.useAlternateImplementation()
        validateMethodsAreSwizzled()

        //  Unswizzled
        association.useOriginalImplementation()
        validateMethodsAreNotSwizzled()

        //  Shouldn't unswizzle when unswizzled
        association.useOriginalImplementation()
        validateMethodsAreNotSwizzled()
    }

    func testSwizzlingObjectiveCInstanceMethodsWithContext() {
        //  Swizzled
        setUpAssociation(classType: .objectiveC, methodType: .instance)

        association.withAlternateImplementation() {
            executedContext = true
            validateMethodsAreSwizzled()
        }

        XCTAssertTrue(executedContext, "The context should be executed while the methods are swizzled")
        validateMethodsAreNotSwizzled()
        executedContext = false

        //  Unswizzled
        association.useAlternateImplementation()

        association.withOriginalImplementation() {
            executedContext = true
            validateMethodsAreNotSwizzled()

        }

        XCTAssertTrue(executedContext, "The context should be executed while the methods are swizzled")
        validateMethodsAreSwizzled()
        validateMethodsAreSwizzled()
        
        association.useOriginalImplementation()
    }

}
