//
//  MethodSurrogateTests.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 10/24/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

import XCTest
import FoundationSwagger


class MethodSurrogateTests: XCTestCase {

    var originalSelector: Selector!
    var alternateSelector: Selector!

    func testAllMethodTypes() {
        [MethodType.class, .instance].forEach {
            switch $0 {
            case .class, .instance:
                break
            }
        }
    }

    func testCreatingClassMethodSurrogateForObjectiveCClass() {
        originalSelector = #selector(SampleObjectiveCClass.sampleClassMethod)
        alternateSelector = #selector(SampleObjectiveCClass.otherClassMethod)

        let surrogate = MethodSurrogate(
            forClass: SampleObjectiveCClass.self,
            ofType: .class,
            originalSelector: originalSelector,
            alternateSelector: alternateSelector
        )

        XCTAssertEqual(
            NSStringFromClass(surrogate.owningClass),
            NSStringFromClass(SampleObjectiveCClass.self),
            "The surrogate should be created with the provided class"
        )
        XCTAssertEqual(surrogate.methodType, .class,
                       "The surrogate should be created with the provided method type")
        XCTAssertEqual(surrogate.originalSelector, originalSelector,
                       "The surrogate should be created with the provided original selector")
        XCTAssertEqual(surrogate.alternateSelector, alternateSelector,
                       "The surrogate should be created with the provided alternate selector")
    }

    func testCreatingClassMethodSurrogateForSwiftClass() {
        originalSelector = #selector(SampleSwiftClass.sampleClassMethod)
        alternateSelector = #selector(SampleSwiftClass.otherClassMethod)

        let surrogate = MethodSurrogate(
            forClass: SampleSwiftClass.self,
            ofType: .class,
            originalSelector: originalSelector,
            alternateSelector: alternateSelector
        )

        XCTAssertEqual(
            NSStringFromClass(surrogate.owningClass),
            NSStringFromClass(SampleSwiftClass.self),
            "The surrogate should be created with the provided class"
        )
        XCTAssertEqual(surrogate.methodType, .class,
                       "The surrogate should be created with the provided method type")
        XCTAssertEqual(surrogate.originalSelector, originalSelector,
                       "The surrogate should be created with the provided original selector")
        XCTAssertEqual(surrogate.alternateSelector, alternateSelector,
                       "The surrogate should be created with the provided alternate selector")
    }

    func testCreatingInstanceMethodSurrogateForObjectiveCClass() {
        originalSelector = #selector(SampleObjectiveCClass.sampleInstanceMethod)
        alternateSelector = #selector(SampleObjectiveCClass.otherInstanceMethod)

        let surrogate = MethodSurrogate(
            forClass: SampleObjectiveCClass.self,
            ofType: .instance,
            originalSelector: originalSelector,
            alternateSelector: alternateSelector
        )

        XCTAssertEqual(
            NSStringFromClass(surrogate.owningClass),
            NSStringFromClass(SampleObjectiveCClass.self),
            "The surrogate should be created with the provided class"
        )
        XCTAssertEqual(surrogate.methodType, .instance,
                       "The surrogate should be created with the provided method type")
        XCTAssertEqual(surrogate.originalSelector, originalSelector,
                       "The surrogate should be created with the provided original selector")
        XCTAssertEqual(surrogate.alternateSelector, alternateSelector,
                       "The surrogate should be created with the provided alternate selector")
    }

    func testCreatingInstanceMethodSurrogateForSwiftClass() {
        originalSelector = #selector(SampleSwiftClass.sampleInstanceMethod)
        alternateSelector = #selector(SampleSwiftClass.otherInstanceMethod)

        let surrogate = MethodSurrogate(
            forClass: SampleSwiftClass.self,
            ofType: .instance,
            originalSelector: originalSelector,
            alternateSelector: alternateSelector
        )

        XCTAssertEqual(
            NSStringFromClass(surrogate.owningClass),
            NSStringFromClass(SampleSwiftClass.self),
            "The surrogate should be created with the provided class"
        )
        XCTAssertEqual(surrogate.methodType, .instance,
                       "The surrogate should be created with the provided method type")
        XCTAssertEqual(surrogate.originalSelector, originalSelector,
                       "The surrogate should be created with the provided original selector")
        XCTAssertEqual(surrogate.alternateSelector, alternateSelector,
                       "The surrogate should be created with the provided alternate selector")
    }

}
