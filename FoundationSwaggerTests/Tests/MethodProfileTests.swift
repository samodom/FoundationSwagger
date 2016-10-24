//
//  MethodProfileTests.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 10/23/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

import XCTest
@testable import FoundationSwagger

class MethodProfileTests: XCTestCase {

    var owningClass: AnyClass!
    var selector: Selector!
    var method: Method!
    var implementation: IMP!

    var profile: MethodProfile!

    func testCreatingProfileForObjectiveCClassMethod() {
        owningClass = SampleObjectiveCClass.self
        selector = #selector(SampleObjectiveCClass.sampleClassMethod(_:))
        loadClassMethodValues()

        XCTAssertEqual(profile.selector, selector, "The profile should be created with the provided selector")
        XCTAssertEqual(profile.method, method, "The profile should refer to the correct method")
        XCTAssertEqual(profile.implementation, implementation, "The profile should refer to the correct method implementation")
    }

    func testCreatingProfileForSwiftClassMethod() {
        owningClass = SampleSwiftClass.self
        selector = #selector(SampleSwiftClass.sampleClassMethod(_:))
        loadClassMethodValues()

        XCTAssertEqual(profile.selector, selector, "The profile should be created with the provided selector")
        XCTAssertEqual(profile.method, method, "The profile should refer to the correct method")
        XCTAssertEqual(profile.implementation, implementation, "The profile should refer to the correct method implementation")
    }

    func testCreatingProfileForObjectiveCInstanceMethod() {
        owningClass = SampleObjectiveCClass.self
        selector = #selector(SampleObjectiveCClass.sampleInstanceMethod(_:))
        loadInstanceMethodValues()

        XCTAssertEqual(profile.selector, selector, "The profile should be created with the provided selector")
        XCTAssertEqual(profile.method, method, "The profile should refer to the correct method")
        XCTAssertEqual(profile.implementation, implementation, "The profile should refer to the correct method implementation")
    }

    func testCreatingProfileForSwiftInstanceMethod() {
        owningClass = SampleSwiftClass.self
        selector = #selector(SampleSwiftClass.sampleInstanceMethod(_:))
        loadInstanceMethodValues()

        XCTAssertEqual(profile.selector, selector, "The profile should be created with the provided selector")
        XCTAssertEqual(profile.method, method, "The profile should refer to the correct method")
        XCTAssertEqual(profile.implementation, implementation, "The profile should refer to the correct method implementation")
    }

}

fileprivate extension MethodProfileTests {

    func loadClassMethodValues() {
        assert(owningClass != nil)
        assert(selector != nil)

        method = class_getClassMethod(owningClass, selector)
        implementation = method_getImplementation(method)

        profile = ClassMethodProfile(class: owningClass, selector: selector)
    }

    func loadInstanceMethodValues() {
        assert(owningClass != nil)
        assert(selector != nil)

        method = class_getInstanceMethod(owningClass, selector)
        implementation = method_getImplementation(method)

        profile = InstanceMethodProfile(class: owningClass, selector: selector)
    }

}
