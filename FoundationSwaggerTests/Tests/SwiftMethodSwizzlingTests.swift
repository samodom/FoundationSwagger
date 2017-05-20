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

    override func setUp() {
        super.setUp()

        SampleSwiftClass.classProperty = OriginalPropertyValue
    }

    override func tearDown() {
        SampleSwiftClass.classProperty = OriginalPropertyValue

        super.tearDown()
    }

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

    func testSwizzlingSwiftClassPropertyAccessor() {
        surrogate = MethodSurrogate(
            forClass: SampleSwiftClass.self,
            ofType: .class,
            originalSelector: #selector(getter: SampleSwiftClass.classProperty),
            alternateSelector: #selector(SampleSwiftClass.otherClassPropertyGetter)
        )

        surrogate.useAlternateImplementation()
        XCTAssertEqual(SampleSwiftClass.classProperty, AlternatePropertyValue,
                       "The property's accessor should be replaced with an alternate method")

        surrogate.useOriginalImplementation()
        XCTAssertEqual(SampleSwiftClass.classProperty, OriginalPropertyValue,
                       "The property's accessor should be restored to the original method")
    }

    func testSwizzlingSwiftClassPropertyMutator() {
        surrogate = MethodSurrogate(
            forClass: SampleSwiftClass.self,
            ofType: .class,
            originalSelector: #selector(setter: SampleSwiftClass.classProperty),
            alternateSelector: #selector(SampleSwiftClass.otherClassPropertySetter)
        )

        surrogate.useAlternateImplementation()
        SampleSwiftClass.classProperty = AlternatePropertyValue
        XCTAssertEqual(SampleSwiftClass.classProperty, AlternatePropertyValue + AlternatePropertyValue,
                       "The property's mutator should be replaced with an alternate method")

        surrogate.useOriginalImplementation()
        SampleSwiftClass.classProperty = OriginalPropertyValue
        XCTAssertEqual(SampleSwiftClass.classProperty, OriginalPropertyValue,
                       "The property's mutator should be restored to the original method")
    }

    func testSwizzlingSwiftInstancePropertyAccessor() {
        let sample = SampleSwiftClass()

        surrogate = MethodSurrogate(
            forClass: SampleSwiftClass.self,
            ofType: .instance,
            originalSelector: #selector(getter: SampleSwiftClass.instanceProperty),
            alternateSelector: #selector(SampleSwiftClass.otherInstancePropertyGetter)
        )

        surrogate.useAlternateImplementation()
        XCTAssertEqual(sample.instanceProperty, AlternatePropertyValue,
                       "The property's accessor should be replaced with an alternate method")

        surrogate.useOriginalImplementation()
        XCTAssertEqual(sample.instanceProperty, OriginalPropertyValue,
                       "The property's accessor should be restored to the original method")
    }

    func testSwizzlingSwiftInstancePropertyMutator() {
        let sample = SampleSwiftClass()

        surrogate = MethodSurrogate(
            forClass: SampleSwiftClass.self,
            ofType: .instance,
            originalSelector: #selector(setter: SampleSwiftClass.instanceProperty),
            alternateSelector: #selector(SampleSwiftClass.otherInstancePropertySetter)
        )

        surrogate.useAlternateImplementation()
        sample.instanceProperty = AlternatePropertyValue
        XCTAssertEqual(sample.instanceProperty, AlternatePropertyValue + AlternatePropertyValue,
                       "The property's mutator should be replaced with an alternate method")

        surrogate.useOriginalImplementation()
        sample.instanceProperty = OriginalPropertyValue
        XCTAssertEqual(sample.instanceProperty, OriginalPropertyValue,
                       "The property's mutator should be restored to the original method")
    }

}
