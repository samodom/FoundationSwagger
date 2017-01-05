//
//  MethodAssociationTests.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 10/24/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

import XCTest
import FoundationSwagger
import SampleTypes

class MethodAssociationTests: XCTestCase {

    var originalSelector: Selector!
    var alternateSelector: Selector!

    func testAllMethodTypes() {
        [MethodAssociation.MethodType.class, .instance].forEach {
            switch $0 {
            case .class, .instance:
                break
            }
        }
    }

    func testCreatingClassMethodAssociationForObjectiveCClass() {
        originalSelector = #selector(SampleObjectiveCClass.sampleClassMethod)
        alternateSelector = #selector(SampleObjectiveCClass.otherClassMethod)

        let association = MethodAssociation(
            forClass: SampleObjectiveCClass.self,
            ofType: .class,
            originalSelector: originalSelector,
            alternateSelector: alternateSelector
        )

        XCTAssertEqual(
            NSStringFromClass(association.owningClass),
            NSStringFromClass(SampleObjectiveCClass.self),
            "The association should be created with the provided class"
        )
        XCTAssertEqual(association.methodType, .class,
                       "The association should be created with the provided method type")
        XCTAssertEqual(association.originalSelector, originalSelector,
                       "The association should be created with the provided original selector")
        XCTAssertEqual(association.alternateSelector, alternateSelector,
                       "The association should be created with the provided alternate selector")
    }

    func testCreatingClassMethodAssociationForSwiftClass() {
        originalSelector = #selector(SampleSwiftClass.sampleClassMethod)
        alternateSelector = #selector(SampleSwiftClass.otherClassMethod)

        let association = MethodAssociation(
            forClass: SampleSwiftClass.self,
            ofType: .class,
            originalSelector: originalSelector,
            alternateSelector: alternateSelector
        )

        XCTAssertEqual(
            NSStringFromClass(association.owningClass),
            NSStringFromClass(SampleSwiftClass.self),
            "The association should be created with the provided class"
        )
        XCTAssertEqual(association.methodType, .class,
                       "The association should be created with the provided method type")
        XCTAssertEqual(association.originalSelector, originalSelector,
                       "The association should be created with the provided original selector")
        XCTAssertEqual(association.alternateSelector, alternateSelector,
                       "The association should be created with the provided alternate selector")
    }

    func testCreatingInstanceMethodAssociationForObjectiveCClass() {
        originalSelector = #selector(SampleObjectiveCClass.sampleInstanceMethod)
        alternateSelector = #selector(SampleObjectiveCClass.otherInstanceMethod)

        let association = MethodAssociation(
            forClass: SampleObjectiveCClass.self,
            ofType: .instance,
            originalSelector: originalSelector,
            alternateSelector: alternateSelector
        )

        XCTAssertEqual(
            NSStringFromClass(association.owningClass),
            NSStringFromClass(SampleObjectiveCClass.self),
            "The association should be created with the provided class"
        )
        XCTAssertEqual(association.methodType, .instance,
                       "The association should be created with the provided method type")
        XCTAssertEqual(association.originalSelector, originalSelector,
                       "The association should be created with the provided original selector")
        XCTAssertEqual(association.alternateSelector, alternateSelector,
                       "The association should be created with the provided alternate selector")
    }

    func testCreatingInstanceMethodAssociationForSwiftClass() {
        originalSelector = #selector(SampleSwiftClass.sampleInstanceMethod)
        alternateSelector = #selector(SampleSwiftClass.otherInstanceMethod)

        let association = MethodAssociation(
            forClass: SampleSwiftClass.self,
            ofType: .instance,
            originalSelector: originalSelector,
            alternateSelector: alternateSelector
        )

        XCTAssertEqual(
            NSStringFromClass(association.owningClass),
            NSStringFromClass(SampleSwiftClass.self),
            "The association should be created with the provided class"
        )
        XCTAssertEqual(association.methodType, .instance,
                       "The association should be created with the provided method type")
        XCTAssertEqual(association.originalSelector, originalSelector,
                       "The association should be created with the provided original selector")
        XCTAssertEqual(association.alternateSelector, alternateSelector,
                       "The association should be created with the provided alternate selector")
    }

}
