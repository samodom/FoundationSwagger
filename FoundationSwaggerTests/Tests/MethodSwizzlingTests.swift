//
//  MethodSwizzlingTests.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 10/24/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

import XCTest
import FoundationSwagger
import SampleTypes

class MethodSwizzlingTests: XCTestCase {

    var association: MethodAssociation!

    var originalMethod: Method!
    var originalImplementation: IMP!

    var alternateMethod: Method!
    var alternateImplementation: IMP!

    var sampleObject: SampleType!

    var isTestingSwizzledImplementations = false
    var selectorOriginUnderTest = SelectorOrigin.original


    func testSwizzlingObjectiveCClassMethods() {
        association = MethodAssociation(
            forClass: SampleObjectiveCClass.self,
            ofType: .class,
            originalSelector: #selector(SampleObjectiveCClass.sampleClassMethod),
            alternateSelector: #selector(SampleObjectiveCClass.otherClassMethod)
        )

        loadMethodValues()
        validateMethodsAreSwizzled()
        validateMethodsAreNotSwizzled()
        validateMethodsAreNotSwizzledWhenAlreadySwizzled()
        validateMethodsAreNotUnswizzledWhenAlreadyUnswizzled()
    }

    func testSwizzlingObjectiveCInstanceMethods() {
        association = MethodAssociation(
            forClass: SampleObjectiveCClass.self,
            ofType: .instance,
            originalSelector: #selector(SampleObjectiveCClass.sampleInstanceMethod),
            alternateSelector: #selector(SampleObjectiveCClass.otherInstanceMethod)
        )

        loadMethodValues()
        validateMethodsAreSwizzled()
        validateMethodsAreNotSwizzled()
        validateMethodsAreNotSwizzledWhenAlreadySwizzled()
        validateMethodsAreNotUnswizzledWhenAlreadyUnswizzled()
    }

    func testSwizzlingSwiftClassMethods() {
        association = MethodAssociation(
            forClass: SampleSwiftClass.self,
            ofType: .class,
            originalSelector: #selector(SampleSwiftClass.sampleClassMethod),
            alternateSelector: #selector(SampleSwiftClass.otherClassMethod)
        )

        loadMethodValues()
        validateMethodsAreSwizzled()
        validateMethodsAreNotSwizzled()
        validateMethodsAreNotSwizzledWhenAlreadySwizzled()
        validateMethodsAreNotUnswizzledWhenAlreadyUnswizzled()
    }

    func testSwizzlingSwiftInstanceMethods() {
        association = MethodAssociation(
            forClass: SampleSwiftClass.self,
            ofType: .instance,
            originalSelector: #selector(SampleSwiftClass.sampleInstanceMethod),
            alternateSelector: #selector(SampleSwiftClass.otherInstanceMethod)
        )

        loadMethodValues()
        validateMethodsAreSwizzled()
        validateMethodsAreNotSwizzled()
        validateMethodsAreNotSwizzledWhenAlreadySwizzled()
        validateMethodsAreNotUnswizzledWhenAlreadyUnswizzled()
    }

}

fileprivate extension MethodSwizzlingTests {

    func loadMethodValues() {
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

}
