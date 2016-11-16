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


    //  MARK: - Objective-C class methods

    func testSwizzlingObjectiveCClassMethods() {
        association = objectiveCClassMethodAssociation()
        loadMethodValues()

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
        association = objectiveCClassMethodAssociation()
        loadMethodValues()

        //  Swizzled
        association.useAlternateImplementation() {
            self.validateMethodsAreSwizzled()

            //  Shouldn't swizzle when swizzled
            self.association.useAlternateImplementation()
            self.validateMethodsAreSwizzled()
            self.executedContext = true
        }
        XCTAssertTrue(executedContext, "The context should be executed while the methods are swizzled")
        executedContext = false

        //  Unswizzled
        association.useOriginalImplementation() {
            self.validateMethodsAreNotSwizzled()

            //  Shouldn't unswizzle when unswizzled
            self.association.useOriginalImplementation()
            self.validateMethodsAreNotSwizzled()
            self.executedContext = true
        }
        XCTAssertTrue(executedContext, "The context should be executed while the methods are swizzled")
    }

    //  MARK: - Objective-C instance methods

    func testSwizzlingObjectiveCInstanceMethods() {
        association = objectiveCInstanceMethodAssociation()
        loadMethodValues()

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
        association = objectiveCInstanceMethodAssociation()
        loadMethodValues()

        //  Swizzled
        association.useAlternateImplementation() {
            self.validateMethodsAreSwizzled()

            //  Shouldn't swizzle when swizzled
            self.association.useAlternateImplementation()
            self.validateMethodsAreSwizzled()
            self.executedContext = true
        }
        XCTAssertTrue(executedContext, "The context should be executed while the methods are swizzled")
        executedContext = false

        //  Unswizzled
        association.useOriginalImplementation() {
            self.validateMethodsAreNotSwizzled()

            //  Shouldn't unswizzle when unswizzled
            self.association.useOriginalImplementation()
            self.validateMethodsAreNotSwizzled()
            self.executedContext = true
        }
        XCTAssertTrue(executedContext, "The context should be executed while the methods are swizzled")
    }

    //  MARK: - Swift class methods

    func testSwizzlingSwiftClassMethods() {
        association = swiftClassMethodAssociation()
        loadMethodValues()

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
        association = swiftClassMethodAssociation()
        loadMethodValues()

        //  Swizzled
        association.useAlternateImplementation() {
            self.validateMethodsAreSwizzled()

            //  Shouldn't swizzle when swizzled
            self.association.useAlternateImplementation()
            self.validateMethodsAreSwizzled()
            self.executedContext = true
        }
        XCTAssertTrue(executedContext, "The context should be executed while the methods are swizzled")
        executedContext = false

        //  Unswizzled
        association.useOriginalImplementation() {
            self.validateMethodsAreNotSwizzled()

            //  Shouldn't unswizzle when unswizzled
            self.association.useOriginalImplementation()
            self.validateMethodsAreNotSwizzled()
            self.executedContext = true
        }
        XCTAssertTrue(executedContext, "The context should be executed while the methods are swizzled")
    }

    //  MARK: - Swift instance methods

    func testSwizzlingSwiftInstanceMethods() {
        association = swiftInstanceMethodAssociation()
        loadMethodValues()

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
        association = swiftInstanceMethodAssociation()
        loadMethodValues()

        //  Swizzled
        association.useAlternateImplementation() {
            self.validateMethodsAreSwizzled()

            //  Shouldn't swizzle when swizzled
            self.association.useAlternateImplementation()
            self.validateMethodsAreSwizzled()
            self.executedContext = true
        }
        XCTAssertTrue(executedContext, "The context should be executed while the methods are swizzled")
        executedContext = false

        //  Unswizzled
        association.useOriginalImplementation() {
            self.validateMethodsAreNotSwizzled()

            //  Shouldn't unswizzle when unswizzled
            self.association.useOriginalImplementation()
            self.validateMethodsAreNotSwizzled()
            self.executedContext = true
        }
        XCTAssertTrue(executedContext, "The context should be executed while the methods are swizzled")
    }

}


extension MethodSwizzlingTests {

    func loadMethodValues() {
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

    func objectiveCClassMethodAssociation() -> MethodAssociation {
        return MethodAssociation(
            forClass: SampleObjectiveCClass.self,
            ofType: .class,
            originalSelector: #selector(SampleObjectiveCClass.sampleClassMethod),
            alternateSelector: #selector(SampleObjectiveCClass.otherClassMethod)
        )
    }

    func objectiveCInstanceMethodAssociation() -> MethodAssociation {
        return MethodAssociation(
            forClass: SampleObjectiveCClass.self,
            ofType: .instance,
            originalSelector: #selector(SampleObjectiveCClass.sampleInstanceMethod),
            alternateSelector: #selector(SampleObjectiveCClass.otherInstanceMethod)
        )
    }

    func swiftClassMethodAssociation() -> MethodAssociation {
        return MethodAssociation(
            forClass: SampleSwiftClass.self,
            ofType: .class,
            originalSelector: #selector(SampleSwiftClass.sampleClassMethod),
            alternateSelector: #selector(SampleSwiftClass.otherClassMethod)
        )
    }

    func swiftInstanceMethodAssociation() -> MethodAssociation {
        return MethodAssociation(
            forClass: SampleSwiftClass.self,
            ofType: .instance,
            originalSelector: #selector(SampleSwiftClass.sampleInstanceMethod),
            alternateSelector: #selector(SampleSwiftClass.otherInstanceMethod)
        )
    }

}
