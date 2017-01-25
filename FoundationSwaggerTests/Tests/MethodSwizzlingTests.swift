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

    var surrogate: MethodSurrogate!

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
        surrogate.useOriginalImplementation()

        super.tearDown()
    }


    //  MARK: - Objective-C class methods

    func testSwizzlingObjectiveCClassMethods() {
        setUpSurrogate(classType: .objectiveC, methodType: .`class`)

        //  Swizzled
        surrogate.useAlternateImplementation()
        validateMethodsAreSwizzled()

        //  Shouldn't swizzle when swizzled
        surrogate.useAlternateImplementation()
        validateMethodsAreSwizzled()

        //  Unswizzled
        surrogate.useOriginalImplementation()
        validateMethodsAreNotSwizzled()

        //  Shouldn't unswizzle when unswizzled
        surrogate.useOriginalImplementation()
        validateMethodsAreNotSwizzled()
    }

    func testSwizzlingObjectiveCClassMethodsWithContext() {
        //  Swizzled
        setUpSurrogate(classType: .objectiveC, methodType: .`class`)

        surrogate.withAlternateImplementation() {
            executedContext = true
            validateMethodsAreSwizzled()
        }

        XCTAssertTrue(executedContext, "The context should be executed while the methods are swizzled")
        validateMethodsAreNotSwizzled()
        executedContext = false

        //  Unswizzled
        surrogate.useAlternateImplementation()

        surrogate.withOriginalImplementation() {
            executedContext = true
            validateMethodsAreNotSwizzled()

        }

        XCTAssertTrue(executedContext, "The context should be executed while the methods are swizzled")
        validateMethodsAreSwizzled()

        surrogate.useOriginalImplementation()
    }

    //  MARK: - Objective-C instance methods

    func testSwizzlingObjectiveCInstanceMethods() {
        setUpSurrogate(classType: .objectiveC, methodType: .instance)

        //  Swizzled
        surrogate.useAlternateImplementation()
        validateMethodsAreSwizzled()

        //  Shouldn't swizzle when swizzled
        surrogate.useAlternateImplementation()
        validateMethodsAreSwizzled()

        //  Unswizzled
        surrogate.useOriginalImplementation()
        validateMethodsAreNotSwizzled()

        //  Shouldn't unswizzle when unswizzled
        surrogate.useOriginalImplementation()
        validateMethodsAreNotSwizzled()
    }

    func testSwizzlingObjectiveCInstanceMethodsWithContext() {
        //  Swizzled
        setUpSurrogate(classType: .objectiveC, methodType: .instance)

        surrogate.withAlternateImplementation() {
            executedContext = true
            validateMethodsAreSwizzled()
        }

        XCTAssertTrue(executedContext, "The context should be executed while the methods are swizzled")
        validateMethodsAreNotSwizzled()
        executedContext = false

        //  Unswizzled
        surrogate.useAlternateImplementation()

        surrogate.withOriginalImplementation() {
            executedContext = true
            validateMethodsAreNotSwizzled()

        }

        XCTAssertTrue(executedContext, "The context should be executed while the methods are swizzled")
        validateMethodsAreSwizzled()
        validateMethodsAreSwizzled()
        
        surrogate.useOriginalImplementation()
    }

    //  MARK: - Swift class methods

    func testSwizzlingSwiftClassMethods() {
        setUpSurrogate(classType: .swift, methodType: .`class`)

        //  Swizzled
        surrogate.useAlternateImplementation()
        validateMethodsAreSwizzled()

        //  Shouldn't swizzle when swizzled
        surrogate.useAlternateImplementation()
        validateMethodsAreSwizzled()

        //  Unswizzled
        surrogate.useOriginalImplementation()
        validateMethodsAreNotSwizzled()

        //  Shouldn't unswizzle when unswizzled
        surrogate.useOriginalImplementation()
        validateMethodsAreNotSwizzled()
    }

    func testSwizzlingSwiftClassMethodsWithContext() {
        //  Swizzled
        setUpSurrogate(classType: .swift, methodType: .`class`)

        surrogate.withAlternateImplementation() {
            executedContext = true
            validateMethodsAreSwizzled()
        }

        XCTAssertTrue(executedContext, "The context should be executed while the methods are swizzled")
        validateMethodsAreNotSwizzled()
        executedContext = false

        //  Unswizzled
        surrogate.useAlternateImplementation()

        surrogate.withOriginalImplementation() {
            executedContext = true
            validateMethodsAreNotSwizzled()

        }

        XCTAssertTrue(executedContext, "The context should be executed while the methods are swizzled")
        validateMethodsAreSwizzled()

        surrogate.useOriginalImplementation()
    }

    //  MARK: - Swift instance methods

    func testSwizzlingSwiftInstanceMethods() {
        setUpSurrogate(classType: .swift, methodType: .instance)

        //  Swizzled
        surrogate.useAlternateImplementation()
        validateMethodsAreSwizzled()

        //  Shouldn't swizzle when swizzled
        surrogate.useAlternateImplementation()
        validateMethodsAreSwizzled()

        //  Unswizzled
        surrogate.useOriginalImplementation()
        validateMethodsAreNotSwizzled()

        //  Shouldn't unswizzle when unswizzled
        surrogate.useOriginalImplementation()
        validateMethodsAreNotSwizzled()
    }

    func testSwizzlingSwiftInstanceMethodsWithContext() {
        //  Swizzled
        setUpSurrogate(classType: .swift, methodType: .instance)

        surrogate.withAlternateImplementation() {
            executedContext = true
            validateMethodsAreSwizzled()
        }

        XCTAssertTrue(executedContext, "The context should be executed while the methods are swizzled")
        validateMethodsAreNotSwizzled()
        executedContext = false

        //  Unswizzled
        surrogate.useAlternateImplementation()

        surrogate.withOriginalImplementation() {
            executedContext = true
            validateMethodsAreNotSwizzled()
        }

        XCTAssertTrue(executedContext, "The context should be executed while the methods are swizzled")
        validateMethodsAreSwizzled()
        
        surrogate.useOriginalImplementation()
    }

    //  MARK: - Mixed

    func testMixedAndNestedSwizzlingSafety() {
        setUpSurrogate(classType: .objectiveC, methodType: .instance)

        //  Nested unswizzled ignored
        surrogate.withOriginalImplementation {
            XCTFail("This code should not execute")
        }
        validateMethodsAreNotSwizzled()

        //  Nested swizzled ignored
        surrogate.useAlternateImplementation()
        surrogate.withAlternateImplementation() {
            XCTFail("This code should not execute")
        }
        validateMethodsAreSwizzled()
        surrogate.useOriginalImplementation()

        //  Nested unswizzled not ignored
        surrogate.useAlternateImplementation()
        surrogate.withOriginalImplementation {
            validateMethodsAreNotSwizzled()
        }
        surrogate.useOriginalImplementation()
    }

}


fileprivate extension MethodSwizzlingTests {

    fileprivate enum ClassType {
        case objectiveC, swift
    }

    func setUpSurrogate(classType: ClassType, methodType: MethodType) {
        switch (classType, methodType) {
        case (.objectiveC, .`class`):
            surrogate = objectiveCClassMethodSurrogate()

        case (.objectiveC, .instance):
            surrogate = objectiveCInstanceMethodSurrogate()

        case (.swift, .`class`):
            surrogate = swiftClassMethodSurrogate()

        case (.swift, .instance):
            surrogate = swiftInstanceMethodSurrogate()
        }

        loadMethodValues()
    }

    private func loadMethodValues() {
        switch surrogate.owningClass.className() {
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

    private func objectiveCClassMethodSurrogate() -> MethodSurrogate {
        return MethodSurrogate(
            forClass: SampleObjectiveCClass.self,
            ofType: .class,
            originalSelector: #selector(SampleObjectiveCClass.sampleClassMethod),
            alternateSelector: #selector(SampleObjectiveCClass.otherClassMethod)
        )
    }

    private func objectiveCInstanceMethodSurrogate() -> MethodSurrogate {
        return MethodSurrogate(
            forClass: SampleObjectiveCClass.self,
            ofType: .instance,
            originalSelector: #selector(SampleObjectiveCClass.sampleInstanceMethod),
            alternateSelector: #selector(SampleObjectiveCClass.otherInstanceMethod)
        )
    }

    private func swiftClassMethodSurrogate() -> MethodSurrogate {
        return MethodSurrogate(
            forClass: SampleSwiftClass.self,
            ofType: .class,
            originalSelector: #selector(SampleSwiftClass.sampleClassMethod),
            alternateSelector: #selector(SampleSwiftClass.otherClassMethod)
        )
    }

    private func swiftInstanceMethodSurrogate() -> MethodSurrogate {
        return MethodSurrogate(
            forClass: SampleSwiftClass.self,
            ofType: .instance,
            originalSelector: #selector(SampleSwiftClass.sampleInstanceMethod),
            alternateSelector: #selector(SampleSwiftClass.otherInstanceMethod)
        )
    }

}
