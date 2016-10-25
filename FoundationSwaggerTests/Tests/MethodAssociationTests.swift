//
//  MethodAssociationTests.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 10/24/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

import XCTest
import FoundationSwagger

class MethodAssociationTests: XCTestCase {

    var originalSelector: Selector!
    var alternateSelector: Selector!

    func testAllMethodTypes() {
        let types = [MethodAssociation.MethodType.class, .instance]
        types.forEach {
            switch $0 {
            case .class, .instance:
                break
            }
        }
    }

    func testCreatingClassMethodAssociationForObjectiveCClass() {
        originalSelector = #selector(SampleObjectiveCClass.sampleClassMethod(_:))
        alternateSelector = #selector(SampleObjectiveCClass.otherClassMethod(_:))

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
        XCTAssertEqual(association.methodType, .class, "The association should be created with the provided method type")
        XCTAssertEqual(association.originalSelector, originalSelector, "The association should be created with the provided original selector")
        XCTAssertEqual(association.alternateSelector, alternateSelector, "The association should be created with the provided alternate selector")
    }

    func testCreatingClassMethodAssociationForSwiftClass() {
        originalSelector = #selector(SampleSwiftClass.sampleClassMethod(_:))
        alternateSelector = #selector(SampleSwiftClass.otherClassMethod(_:))

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
        XCTAssertEqual(association.methodType, .class, "The association should be created with the provided method type")
        XCTAssertEqual(association.originalSelector, originalSelector, "The association should be created with the provided original selector")
        XCTAssertEqual(association.alternateSelector, alternateSelector, "The association should be created with the provided alternate selector")
    }

    func testCreatingInstanceMethodAssociationForObjectiveCClass() {
        originalSelector = #selector(SampleObjectiveCClass.sampleInstanceMethod(_:))
        alternateSelector = #selector(SampleObjectiveCClass.otherInstanceMethod(_:))

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
        XCTAssertEqual(association.methodType, .instance, "The association should be created with the provided method type")
        XCTAssertEqual(association.originalSelector, originalSelector, "The association should be created with the provided original selector")
        XCTAssertEqual(association.alternateSelector, alternateSelector, "The association should be created with the provided alternate selector")
    }

    func testCreatingInstanceMethodAssociationForSwiftClass() {
        originalSelector = #selector(SampleSwiftClass.sampleInstanceMethod(_:))
        alternateSelector = #selector(SampleSwiftClass.otherInstanceMethod(_:))

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
        XCTAssertEqual(association.methodType, .instance, "The association should be created with the provided method type")
        XCTAssertEqual(association.originalSelector, originalSelector, "The association should be created with the provided original selector")
        XCTAssertEqual(association.alternateSelector, alternateSelector, "The association should be created with the provided alternate selector")
    }

}
