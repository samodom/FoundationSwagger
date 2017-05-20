//
//  ObjectiveCMethodSwizzlingTests.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 1/2/17.
//  Copyright © 2017 Swagger Soft. All rights reserved.
//

import XCTest
import FoundationSwagger


class ObjectiveCMethodSwizzlingTests: MethodSwizzlingTestCase {

    override func setUp() {
        super.setUp()

        SampleObjectiveCClass.classProperty = OriginalPropertyValue
    }

    override func tearDown() {
        SampleObjectiveCClass.classProperty = OriginalPropertyValue

        super.tearDown()
    }

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

    func testSwizzlingObjectiveCClassPropertyAccessor() {
        surrogate = MethodSurrogate(
            forClass: SampleObjectiveCClass.self,
            ofType: .class,
            originalSelector: #selector(getter: SampleObjectiveCClass.classProperty),
            alternateSelector: #selector(SampleObjectiveCClass.otherClassPropertyGetter)
        )

        surrogate.useAlternateImplementation()
        XCTAssertEqual(SampleObjectiveCClass.classProperty, AlternatePropertyValue,
                       "The property's accessor should be replaced with an alternate method")

        surrogate.useOriginalImplementation()
        XCTAssertEqual(SampleObjectiveCClass.classProperty, OriginalPropertyValue,
                       "The property's accessor should be restored to the original method")
    }

    func testSwizzlingObjectiveCClassPropertyMutator() {
        surrogate = MethodSurrogate(
            forClass: SampleObjectiveCClass.self,
            ofType: .class,
            originalSelector: #selector(setter: SampleObjectiveCClass.classProperty),
            alternateSelector: #selector(SampleObjectiveCClass.otherClassPropertySetter)
        )

        surrogate.useAlternateImplementation()
        SampleObjectiveCClass.classProperty = AlternatePropertyValue
        XCTAssertEqual(SampleObjectiveCClass.classProperty, AlternatePropertyValue + AlternatePropertyValue,
                       "The property's mutator should be replaced with an alternate method")

        surrogate.useOriginalImplementation()
        SampleObjectiveCClass.classProperty = OriginalPropertyValue
        XCTAssertEqual(SampleObjectiveCClass.classProperty, OriginalPropertyValue,
                       "The property's mutator should be restored to the original method")
    }

    func testSwizzlingObjectiveCInstancePropertyAccessor() {
        let sample = SampleObjectiveCClass()

        surrogate = MethodSurrogate(
            forClass: SampleObjectiveCClass.self,
            ofType: .instance,
            originalSelector: #selector(getter: SampleObjectiveCClass.instanceProperty),
            alternateSelector: #selector(SampleObjectiveCClass.otherInstancePropertyGetter)
        )

        surrogate.useAlternateImplementation()
        XCTAssertEqual(sample.instanceProperty, AlternatePropertyValue,
                       "The property's accessor should be replaced with an alternate method")

        surrogate.useOriginalImplementation()
        XCTAssertEqual(sample.instanceProperty, OriginalPropertyValue,
                       "The property's accessor should be restored to the original method")
    }

    func testSwizzlingObjectiveCInstancePropertyMutator() {
        let sample = SampleObjectiveCClass()

        surrogate = MethodSurrogate(
            forClass: SampleObjectiveCClass.self,
            ofType: .instance,
            originalSelector: #selector(setter: SampleObjectiveCClass.instanceProperty),
            alternateSelector: #selector(SampleObjectiveCClass.otherInstancePropertySetter)
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
