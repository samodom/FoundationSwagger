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
    var currentCodeSource: CodeSource!

    var executedContext = false

    override func tearDown() {
        association.useOriginalImplementation()

        super.tearDown()
    }


    //  MARK: - Objective-C class methods

    func testSwizzlingObjectiveCClassMethods() {
        setUpAssociation(classType: .objectiveC, methodType: .`class`)

        //  Swizzled
        association.useAlternateImplementation()
        validateMethodsAreSwizzled()

        //  Shouldn't swizzle when swizzled
        association.useAlternateImplementation()
        validateMethodsAreSwizzled()

        //  Unswizzled
        association.useOriginalImplementation()
        validateMethodsAreNotSwizzled()

        //  Shouldn't unswizzle when unswizzled
        association.useOriginalImplementation()
        validateMethodsAreNotSwizzled()
    }

    func testSwizzlingObjectiveCClassMethodsWithContext() {
        //  Swizzled
        setUpAssociation(classType: .objectiveC, methodType: .`class`)

        association.withAlternateImplementation() {
            executedContext = true
            validateMethodsAreSwizzled()
        }

        XCTAssertTrue(executedContext, "The context should be executed while the methods are swizzled")
        validateMethodsAreNotSwizzled()
        executedContext = false

        //  Unswizzled
        association.useAlternateImplementation()

        association.withOriginalImplementation() {
            executedContext = true
            validateMethodsAreNotSwizzled()

        }

        XCTAssertTrue(executedContext, "The context should be executed while the methods are swizzled")
        validateMethodsAreSwizzled()

        association.useOriginalImplementation()
    }

    //  MARK: - Objective-C instance methods

    func testSwizzlingObjectiveCInstanceMethods() {
        setUpAssociation(classType: .objectiveC, methodType: .instance)

        //  Swizzled
        association.useAlternateImplementation()
        validateMethodsAreSwizzled()

        //  Shouldn't swizzle when swizzled
        association.useAlternateImplementation()
        validateMethodsAreSwizzled()

        //  Unswizzled
        association.useOriginalImplementation()
        validateMethodsAreNotSwizzled()

        //  Shouldn't unswizzle when unswizzled
        association.useOriginalImplementation()
        validateMethodsAreNotSwizzled()
    }

    func testSwizzlingObjectiveCInstanceMethodsWithContext() {
        //  Swizzled
        setUpAssociation(classType: .objectiveC, methodType: .instance)

        association.withAlternateImplementation() {
            executedContext = true
            validateMethodsAreSwizzled()
        }

        XCTAssertTrue(executedContext, "The context should be executed while the methods are swizzled")
        validateMethodsAreNotSwizzled()
        executedContext = false

        //  Unswizzled
        association.useAlternateImplementation()

        association.withOriginalImplementation() {
            executedContext = true
            validateMethodsAreNotSwizzled()

        }

        XCTAssertTrue(executedContext, "The context should be executed while the methods are swizzled")
        validateMethodsAreSwizzled()
        validateMethodsAreSwizzled()
        
        association.useOriginalImplementation()
    }

    //  MARK: - Swift class methods

    func testSwizzlingSwiftClassMethods() {
        setUpAssociation(classType: .swift, methodType: .`class`)

        //  Swizzled
        association.useAlternateImplementation()
        validateMethodsAreSwizzled()

        //  Shouldn't swizzle when swizzled
        association.useAlternateImplementation()
        validateMethodsAreSwizzled()

        //  Unswizzled
        association.useOriginalImplementation()
        validateMethodsAreNotSwizzled()

        //  Shouldn't unswizzle when unswizzled
        association.useOriginalImplementation()
        validateMethodsAreNotSwizzled()
    }

    func testSwizzlingSwiftClassMethodsWithContext() {
        //  Swizzled
        setUpAssociation(classType: .swift, methodType: .`class`)

        association.withAlternateImplementation() {
            executedContext = true
            validateMethodsAreSwizzled()
        }

        XCTAssertTrue(executedContext, "The context should be executed while the methods are swizzled")
        validateMethodsAreNotSwizzled()
        executedContext = false

        //  Unswizzled
        association.useAlternateImplementation()

        association.withOriginalImplementation() {
            executedContext = true
            validateMethodsAreNotSwizzled()

        }

        XCTAssertTrue(executedContext, "The context should be executed while the methods are swizzled")
        validateMethodsAreSwizzled()

        association.useOriginalImplementation()
    }

    //  MARK: - Swift instance methods

    func testSwizzlingSwiftInstanceMethods() {
        setUpAssociation(classType: .swift, methodType: .instance)

        //  Swizzled
        association.useAlternateImplementation()
        validateMethodsAreSwizzled()

        //  Shouldn't swizzle when swizzled
        association.useAlternateImplementation()
        validateMethodsAreSwizzled()

        //  Unswizzled
        association.useOriginalImplementation()
        validateMethodsAreNotSwizzled()

        //  Shouldn't unswizzle when unswizzled
        association.useOriginalImplementation()
        validateMethodsAreNotSwizzled()
    }

    func testSwizzlingSwiftInstanceMethodsWithContext() {
        //  Swizzled
        setUpAssociation(classType: .swift, methodType: .instance)

        association.withAlternateImplementation() {
            executedContext = true
            validateMethodsAreSwizzled()
        }

        XCTAssertTrue(executedContext, "The context should be executed while the methods are swizzled")
        validateMethodsAreNotSwizzled()
        executedContext = false

        //  Unswizzled
        association.useAlternateImplementation()

        association.withOriginalImplementation() {
            executedContext = true
            validateMethodsAreNotSwizzled()
        }

        XCTAssertTrue(executedContext, "The context should be executed while the methods are swizzled")
        validateMethodsAreSwizzled()
        
        association.useOriginalImplementation()
    }

    //  MARK: - Mixed

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

}


fileprivate extension MethodSwizzlingTests {

    fileprivate enum ClassType {
        case objectiveC, swift
    }

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

    private func objectiveCClassMethodAssociation() -> MethodAssociation {
        return MethodAssociation(
            forClass: SampleObjectiveCClass.self,
            ofType: .class,
            originalSelector: #selector(SampleObjectiveCClass.sampleClassMethod),
            alternateSelector: #selector(SampleObjectiveCClass.otherClassMethod)
        )
    }

    private func objectiveCInstanceMethodAssociation() -> MethodAssociation {
        return MethodAssociation(
            forClass: SampleObjectiveCClass.self,
            ofType: .instance,
            originalSelector: #selector(SampleObjectiveCClass.sampleInstanceMethod),
            alternateSelector: #selector(SampleObjectiveCClass.otherInstanceMethod)
        )
    }

    private func swiftClassMethodAssociation() -> MethodAssociation {
        return MethodAssociation(
            forClass: SampleSwiftClass.self,
            ofType: .class,
            originalSelector: #selector(SampleSwiftClass.sampleClassMethod),
            alternateSelector: #selector(SampleSwiftClass.otherClassMethod)
        )
    }

    private func swiftInstanceMethodAssociation() -> MethodAssociation {
        return MethodAssociation(
            forClass: SampleSwiftClass.self,
            ofType: .instance,
            originalSelector: #selector(SampleSwiftClass.sampleInstanceMethod),
            alternateSelector: #selector(SampleSwiftClass.otherInstanceMethod)
        )
    }

}
