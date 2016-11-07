//
//  MethodSwizzlingHelpers.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 10/24/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

@testable import FoundationSwagger
import SampleTypes


fileprivate typealias SwizzlingMethod = (NullaryVoidClosure?) -> Void


//  MARK: - High-level testing methods and setup

extension MethodSwizzlingTests {

    func validateMethodsAreSwizzled(
        inFile file: String = #file,
        atLine line: UInt = #line
        ) {

        currentCodeSource = CodeSource(file: file, line: line)
        isTestingSwizzledImplementations = true
        validateMethods()
    }

    func validateMethodsAreNotSwizzled(
        inFile file: String = #file,
        atLine line: UInt = #line
        ) {

        currentCodeSource = CodeSource(file: file, line: line)
        isTestingSwizzledImplementations = false
        validateMethods()
    }

    enum SelectorOrigin: String {
        case original, alternate

        fileprivate static var all: [SelectorOrigin] {
            return [.original, .alternate]
        }
    }

}


//  MARK: - Custom assertions

fileprivate extension MethodSwizzlingTests {

    func validateMethods() {
        SelectorOrigin.all.forEach {
            selectorOriginUnderTest = $0
            validateMethodIsValid()
            validateImplementationIsValid()
            validateSampleOutputMatches()
            validateAssociationSwizzleState()
        }
    }

    private func validateMethodIsValid() {
        if getMethod(ofOrigin: selectorOriginUnderTest) != expectedMethod {
            recordFailure(
                withDescription: "The \(selectorOriginUnderTest) method invalid",
                inFile: currentCodeSource.file,
                atLine: currentCodeSource.line,
                expected: true
            )
        }
    }

    private func validateImplementationIsValid() {
        if currentImplementation != expectedImplementation {
            recordFailure(
                withDescription: mismatchedImplementationFailureKey,
                inFile: currentCodeSource.file,
                atLine: currentCodeSource.line,
                expected: true
            )
        }
    }

    private func validateSampleOutputMatches() {
        let currentOutput = executeSampleMethod()
        let expectedOutput = expectedOutputForSampleMethod

        if currentOutput != expectedOutput {
            let errorMessage = "The output value using the \(selectorOriginUnderTest) selector does not match the expected value: \(currentOutput) != \(expectedOutput)"
            recordFailure(
                withDescription: errorMessage,
                inFile: currentCodeSource.file,
                atLine: currentCodeSource.line,
                expected: true
            )
        }
    }

    private func validateAssociationSwizzleState() {
        if association.isSwizzled != isTestingSwizzledImplementations {
            let errorMessage = "The association should \(isTestingSwizzledImplementations ? "" : "not ")be flagged as being swizzled"
            recordFailure(
                withDescription: errorMessage,
                inFile: currentCodeSource.file,
                atLine: currentCodeSource.line,
                expected: true
            )
        }
    }

    private var mismatchedImplementationFailureKey: String {
        let expectedOrigin = isTestingSwizzledImplementations ? !selectorOriginUnderTest : selectorOriginUnderTest
        return "The \(selectorOriginUnderTest) selector should now be associated with the \(expectedOrigin) method implementation"
    }

}

//  MARK: - Running sample method

fileprivate extension MethodSwizzlingTests {

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

private prefix func !(origin: MethodSwizzlingTests.SelectorOrigin) -> MethodSwizzlingTests.SelectorOrigin {
    switch origin {
    case .original:
        return .alternate

    case .alternate:
        return .original
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

fileprivate extension MethodSwizzlingTests {

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
