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
        setUpAssociation(classType: .swift, methodType: .`class`)

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

    func testSwizzlingSwiftClassMethodsWithContext() {
        //  Swizzled
        setUpAssociation(classType: .swift, methodType: .`class`)

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

    func testSwizzlingSwiftInstanceMethods() {
        setUpAssociation(classType: .swift, methodType: .instance)

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

    func testSwizzlingSwiftInstanceMethodsWithContext() {
        //  Swizzled
        setUpAssociation(classType: .swift, methodType: .instance)

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

}
