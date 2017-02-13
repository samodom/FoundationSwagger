//
//  MethodSwizzlingTestCase.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 12/27/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

import XCTest
import SampleTypes
import FoundationSwagger

class MethodSwizzlingTestCase: XCTestCase {

    enum ClassType {
        case objectiveC, swift
    }

    var surrogate: MethodSurrogate!

    var originalMethod: Method!
    var originalImplementation: IMP!

    var alternateMethod: Method!
    var alternateImplementation: IMP!

    var sampleObject: SampleType!

    var isTestingSwizzledImplementations = false
    var selectorOriginUnderTest = SelectorOrigin.original
    var currentCodeSource: CodeSource!

    var executedContext = false

    override func tearDown() {
        surrogate.useOriginalImplementation()

        super.tearDown()
    }

    //  MARK: - Mixed implementation

    func testMixedAndNestedSwizzlingSafety() {
        setUpSurrogate(classType: .objectiveC, methodType: .instance)

        //  Nested unswizzled ignored
        surrogate.withOriginalImplementation {
            XCTFail("This code should not execute")
        }
        validateMethodsAreNotSwizzled()

        //  Nested swizzled ignored
        surrogate.useAlternateImplementation()
        surrogate.withAlternateImplementation() {
            XCTFail("This code should not execute")
        }
        validateMethodsAreSwizzled()
        surrogate.useOriginalImplementation()

        //  Nested unswizzled not ignored
        surrogate.useAlternateImplementation()
        surrogate.withOriginalImplementation {
            validateMethodsAreNotSwizzled()
        }
        surrogate.useOriginalImplementation()
    }


    //  Common helpers

    func setUpSurrogate(classType: ClassType, methodType: MethodType) {
        switch (classType, methodType) {
        case (.objectiveC, .`class`):
            surrogate = objectiveCClassMethodSurrogate()

        case (.objectiveC, .instance):
            surrogate = objectiveCInstanceMethodSurrogate()

        case (.swift, .`class`):
            surrogate = swiftClassMethodSurrogate()

        case (.swift, .instance):
            surrogate = swiftInstanceMethodSurrogate()
        }

        loadMethodValues()
    }

    private func loadMethodValues() {
        switch surrogate.owningClass.className() {
        case SampleObjectiveCClass.className():
            sampleObject = SampleObjectiveCClass()

        case SampleSwiftClass.className():
            sampleObject = SampleSwiftClass()

        default:
            fatalError("Testing unknown class")
        }

        originalMethod = getMethod(ofOrigin: .original)
        originalImplementation = method_getImplementation(originalMethod)

        alternateMethod = getMethod(ofOrigin: .alternate)
        alternateImplementation = method_getImplementation(alternateMethod)
    }

    func objectiveCClassMethodSurrogate() -> MethodSurrogate {
        return MethodSurrogate(
            forClass: SampleObjectiveCClass.self,
            ofType: .class,
            originalSelector: #selector(SampleObjectiveCClass.sampleClassMethod),
            alternateSelector: #selector(SampleObjectiveCClass.otherClassMethod)
        )
    }

    func objectiveCInstanceMethodSurrogate() -> MethodSurrogate {
        return MethodSurrogate(
            forClass: SampleObjectiveCClass.self,
            ofType: .instance,
            originalSelector: #selector(SampleObjectiveCClass.sampleInstanceMethod),
            alternateSelector: #selector(SampleObjectiveCClass.otherInstanceMethod)
        )
    }

    func swiftClassMethodSurrogate() -> MethodSurrogate {
        return MethodSurrogate(
            forClass: SampleSwiftClass.self,
            ofType: .class,
            originalSelector: #selector(SampleSwiftClass.sampleClassMethod),
            alternateSelector: #selector(SampleSwiftClass.otherClassMethod)
        )
    }

    func swiftInstanceMethodSurrogate() -> MethodSurrogate {
        return MethodSurrogate(
            forClass: SampleSwiftClass.self,
            ofType: .instance,
            originalSelector: #selector(SampleSwiftClass.sampleInstanceMethod),
            alternateSelector: #selector(SampleSwiftClass.otherInstanceMethod)
        )
    }

}
