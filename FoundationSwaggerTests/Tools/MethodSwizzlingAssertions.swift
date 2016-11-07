//
//  MethodSwizzlingAssertions.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 11/6/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

import Foundation
@testable import FoundationSwagger


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

        validateMethodAssociationStoredWithClass()
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
    
}

private prefix func !(origin: MethodSwizzlingTests.SelectorOrigin) -> MethodSwizzlingTests.SelectorOrigin {
    switch origin {
    case .original:
        return .alternate

    case .alternate:
        return .original
    }
}