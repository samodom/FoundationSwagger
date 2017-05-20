//
//  MethodSwizzlingHelpers.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 10/24/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

import FoundationSwagger

//  MARK: - Running sample method

extension MethodSwizzlingTestCase {

    func executeSampleMethod() -> Int {
        switch (surrogate.methodType, selectorOriginUnderTest) {
        case (.`class`, .original):
            return surrogate.owningClass.sampleClassMethod()

        case (.`class`, .alternate):
            return surrogate.owningClass.otherClassMethod()

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


extension MethodSwizzlingTestCase {

    var expectedMethod: Method {
        switch selectorOfOrigin(selectorOriginUnderTest) {
        case surrogate.originalSelector:
            return originalMethod

        case surrogate.alternateSelector:
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

    func getMethod(ofOrigin origin: SelectorOrigin) -> Method {
        let selector = selectorOfOrigin(origin)
        switch surrogate.methodType {
        case .class:
            return class_getClassMethod(surrogate.owningClass, selector)

        case .instance:
            return class_getInstanceMethod(surrogate.owningClass, selector)
        }
    }

    fileprivate func selectorOfOrigin(_ origin: SelectorOrigin) -> Selector {
        switch origin {
        case .original:
            return surrogate.originalSelector

        case .alternate:
            return surrogate.alternateSelector
        }
    }

}
