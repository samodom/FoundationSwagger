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

    var association: MethodAssociation!

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
        association.useOriginalImplementation()

        super.tearDown()
    }

    //  MARK: - Mixed implementation

    func testMixedAndNestedSwizzlingSafety() {
        setUpAssociation(classType: .objectiveC, methodType: .instance)

        //  Nested unswizzled ignored
        association.withOriginalImplementation {
            XCTFail("This code should not execute")
        }
        validateMethodsAreNotSwizzled()

        //  Nested swizzled ignored
        association.useAlternateImplementation()
        association.withAlternateImplementation() {
            XCTFail("This code should not execute")
        }
        validateMethodsAreSwizzled()
        association.useOriginalImplementation()

        //  Nested unswizzled not ignored
        association.useAlternateImplementation()
        association.withOriginalImplementation {
            validateMethodsAreNotSwizzled()
        }
        association.useOriginalImplementation()
    }


    //  Common helpers

    func setUpAssociation(classType: ClassType, methodType: MethodAssociation.MethodType) {
        switch (classType, methodType) {
        case (.objectiveC, .`class`):
            association = objectiveCClassMethodAssociation()

        case (.objectiveC, .instance):
            association = objectiveCInstanceMethodAssociation()

        case (.swift, .`class`):
            association = swiftClassMethodAssociation()

        case (.swift, .instance):
            association = swiftInstanceMethodAssociation()
        }

        loadMethodValues()
    }

    private func loadMethodValues() {
        switch association.owningClass.className() {
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

    func objectiveCClassMethodAssociation() -> MethodAssociation {
        return MethodAssociation(
            forClass: SampleObjectiveCClass.self,
            ofType: .class,
            originalSelector: #selector(SampleObjectiveCClass.sampleClassMethod),
            alternateSelector: #selector(SampleObjectiveCClass.otherClassMethod)
        )
    }

    func objectiveCInstanceMethodAssociation() -> MethodAssociation {
        return MethodAssociation(
            forClass: SampleObjectiveCClass.self,
            ofType: .instance,
            originalSelector: #selector(SampleObjectiveCClass.sampleInstanceMethod),
            alternateSelector: #selector(SampleObjectiveCClass.otherInstanceMethod)
        )
    }

    func swiftClassMethodAssociation() -> MethodAssociation {
        return MethodAssociation(
            forClass: SampleSwiftClass.self,
            ofType: .class,
            originalSelector: #selector(SampleSwiftClass.sampleClassMethod),
            alternateSelector: #selector(SampleSwiftClass.otherClassMethod)
        )
    }

    func swiftInstanceMethodAssociation() -> MethodAssociation {
        return MethodAssociation(
            forClass: SampleSwiftClass.self,
            ofType: .instance,
            originalSelector: #selector(SampleSwiftClass.sampleInstanceMethod),
            alternateSelector: #selector(SampleSwiftClass.otherInstanceMethod)
        )
    }

}
