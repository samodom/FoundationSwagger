//
//  MethodSwizzlingHelpers.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 10/24/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

@testable import FoundationSwagger
import SampleTypes

//  MARK: - Running sample method

extension MethodSwizzlingTests {

    func executeSampleMethod() -> Int {
        switch (association.methodType, selectorOriginUnderTest) {
        case (.`class`, .original):
            return association.owningClass.sampleClassMethod()

        case (.`class`, .alternate):
            return association.owningClass.otherClassMethod()

        case (.instance, .original):
            return sampleObject.sampleInstanceMethod()

        case (.instance, .alternate):
            return sampleObject.otherInstanceMethod()
        }
    }

    var expectedOutputForSampleMethod: Int {
        switch (selectorOriginUnderTest, isTestingSwizzledImplementations) {
        case (.original, false),
             (.alternate, true):
            return OriginalMethodReturnValue

        case (.original, true),
             (.alternate, false):
            return AlternateMethodReturnValue
        }
    }

}


//  MARK: - Method lookup

extension MethodSwizzlingTests {

    func getMethod(ofOrigin origin: SelectorOrigin) -> Method {
        let selector = selectorOfOrigin(origin)
        switch association.methodType {
        case .class:
            return class_getClassMethod(association.owningClass, selector)

        case .instance:
            return class_getInstanceMethod(association.owningClass, selector)
        }
    }

    fileprivate func selectorOfOrigin(_ origin: SelectorOrigin) -> Selector {
        switch origin {
        case .original:
            return association.originalSelector

        case .alternate:
            return association.alternateSelector
        }
    }
    

}

extension MethodSwizzlingTests {

    var expectedMethod: Method {
        switch selectorOfOrigin(selectorOriginUnderTest) {
        case association.originalSelector:
            return originalMethod

        case association.alternateSelector:
            return alternateMethod

        default:
            fatalError("Attempting to use invalid selector")
        }
    }

    var currentImplementation: IMP {
        switch selectorOriginUnderTest {
        case .original:
            return method_getImplementation(originalMethod)

        case .alternate:
            return method_getImplementation(alternateMethod)
        }
    }

    var expectedImplementation: IMP {
        switch (selectorOriginUnderTest, isTestingSwizzledImplementations) {
        case (.original, true),
             (.alternate, false):
            return alternateImplementation

        case (.original, false),
             (.alternate, true):
            return originalImplementation
        }
    }

}
