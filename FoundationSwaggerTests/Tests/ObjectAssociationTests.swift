//
//  ObjectAssociationTests.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 2/7/15.
//  Copyright (c) 2015 Swagger Soft. All rights reserved.
//

import XCTest
import FoundationSwagger

class ObjectAssociationTests: XCTestCase {

    private struct AssociationKeys {
        static var ObjCKey = "Objective-C association key"
        static var SwiftKey = "Swift association key"
    }

    private let objCObject: SampleObjCClass! = SampleObjCClass("ObjC object")
    private let swiftObject: SampleSwiftClass! = SampleSwiftClass("Swift object")
    private var objCAssociation: SampleObjCClass? = SampleObjCClass("ObjC association")
    private var swiftAssociation: SampleSwiftClass? = SampleSwiftClass("Swift association")
    var association: AnyObject?

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        lastAssociationPolicy = nil
        lastAssociatedObject = nil
        removeAssociatedObjectsCalled = false
        removeAssociatedObjectsObject = nil

        super.tearDown()
    }

    //  MARK: Default policy

    func testDefaultObjectiveCAssociations() {
        objCObject.associate(key: &AssociationKeys.ObjCKey, withObject: objCAssociation!)
        association = objCObject.association(forKey: &AssociationKeys.ObjCKey)
        XCTAssertEqual(association as? SampleObjCClass, objCAssociation!, "The Objective-C object should have an associated Objective-C object")
        XCTAssertEqual(lastAssociationPolicy, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN, "The default association policy should be Assign")
        lastAssociationPolicy = nil

        objCObject.associate(key: &AssociationKeys.SwiftKey, withObject: swiftAssociation!)
        association = objCObject.association(forKey: &AssociationKeys.SwiftKey)
        XCTAssertEqual(association as? SampleSwiftClass, swiftAssociation!, "The Objective-C object should have an associated Swift object")
        XCTAssertEqual(lastAssociationPolicy!, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN, "The default association policy should be Assign")
        lastAssociationPolicy = nil
    }
/**
    func testDefaultSwiftAssociations() {
        swiftObject.associate(key: &AssociationKeys.ObjCKey, withObject: objCAssociation!)
        association = swiftObject.associationForKey(&AssociationKeys.ObjCKey)
        XCTAssertEqual(association as! SampleObjCClass, objCAssociation!, "The Swift object should have an associated Objective-C object")
        XCTAssertEqual(lastAssociationPolicy!, ObjectAssociationPolicy.Assign, "The default association policy should be Assign")
        lastAssociationPolicy = nil

        swiftObject.associateKey(&AssociationKeys.SwiftKey, withObject: swiftAssociation!)
        association = swiftObject.associationForKey(&AssociationKeys.SwiftKey)
        XCTAssertEqual(association as! SampleSwiftClass, swiftAssociation!, "The Swift object should have an associated Swift object")
        XCTAssertEqual(lastAssociationPolicy!, ObjectAssociationPolicy.Assign, "The default association policy should be Assign")
        lastAssociationPolicy = nil
    }


    //  MARK: Assign policy

    func testAssignObjectiveCAssociation() {
        objCObject.associateKey(&AssociationKeys.ObjCKey, withObject: objCAssociation!, policy: .Assign)
        association = objCObject.associationForKey(&AssociationKeys.ObjCKey)
        XCTAssertEqual(association as! SampleObjCClass, objCAssociation!, "The Objective-C object should have an associated Objective-C object")
        XCTAssertEqual(lastAssociationPolicy!, ObjectAssociationPolicy.Assign, "The provided association policy should be used")
        lastAssociationPolicy = nil

        objCObject.associateKey(&AssociationKeys.SwiftKey, withObject: swiftAssociation!, policy: .Assign)
        association = objCObject.associationForKey(&AssociationKeys.SwiftKey)
        XCTAssertEqual(association as! SampleSwiftClass, swiftAssociation!, "The Objective-C object should have an associated Swift object")
        XCTAssertEqual(lastAssociationPolicy!, ObjectAssociationPolicy.Assign, "The provided association policy should be used")
        lastAssociationPolicy = nil
    }

    func testAssignSwiftAssociation() {
        swiftObject.associateKey(&AssociationKeys.ObjCKey, withObject: objCAssociation!, policy: .Assign)
        association = swiftObject.associationForKey(&AssociationKeys.ObjCKey)
        XCTAssertEqual(association as! SampleObjCClass, objCAssociation!, "The Swift object should have an associated Objective-C object")
        XCTAssertEqual(lastAssociationPolicy!, ObjectAssociationPolicy.Assign, "The provided association policy should be used")
        lastAssociationPolicy = nil

        swiftObject.associateKey(&AssociationKeys.SwiftKey, withObject: swiftAssociation!, policy: .Assign)
        association = swiftObject.associationForKey(&AssociationKeys.SwiftKey)
        XCTAssertEqual(association as! SampleSwiftClass, swiftAssociation!, "The Swift object should have an associated Swift object")
        XCTAssertEqual(lastAssociationPolicy!, ObjectAssociationPolicy.Assign, "The provided association policy should be used")
        lastAssociationPolicy = nil
    }


    //  MARK: AtomicRetain policy

    func testAtomicRetainObjectiveCAssociation() {
        objCObject.associateKey(&AssociationKeys.ObjCKey, withObject: objCAssociation!, policy: .AtomicRetain)
        association = objCObject.associationForKey(&AssociationKeys.ObjCKey)
        XCTAssertEqual(association as! SampleObjCClass, objCAssociation!, "The Objective-C object should have an associated Objective-C object")
        XCTAssertEqual(lastAssociationPolicy!, ObjectAssociationPolicy.AtomicRetain, "The provided association policy should be used")
        lastAssociationPolicy = nil

        objCObject.associateKey(&AssociationKeys.SwiftKey, withObject: swiftAssociation!, policy: .AtomicRetain)
        association = objCObject.associationForKey(&AssociationKeys.SwiftKey)
        XCTAssertEqual(association as! SampleSwiftClass, swiftAssociation!, "The Objective-C object should have an associated Swift object")
        XCTAssertEqual(lastAssociationPolicy!, ObjectAssociationPolicy.AtomicRetain, "The provided association policy should be used")
        lastAssociationPolicy = nil
    }

    func testAtomicRetainSwiftAssociation() {
        swiftObject.associateKey(&AssociationKeys.ObjCKey, withObject: objCAssociation!, policy: .AtomicRetain)
        association = swiftObject.associationForKey(&AssociationKeys.ObjCKey)
        XCTAssertEqual(association as! SampleObjCClass, objCAssociation!, "The Objective-C object should have an associated Objective-C object")
        XCTAssertEqual(lastAssociationPolicy!, ObjectAssociationPolicy.AtomicRetain, "The provided association policy should be used")
        lastAssociationPolicy = nil

        swiftObject.associateKey(&AssociationKeys.SwiftKey, withObject: swiftAssociation!, policy: .AtomicRetain)
        association = swiftObject.associationForKey(&AssociationKeys.SwiftKey)
        XCTAssertEqual(association as! SampleSwiftClass, swiftAssociation!, "The Objective-C object should have an associated Swift object")
        XCTAssertEqual(lastAssociationPolicy!, ObjectAssociationPolicy.AtomicRetain, "The provided association policy should be used")
        lastAssociationPolicy = nil
    }


    //  MARK: NonatomicRetain policy

    func testNonatomicRetainObjectiveCAssociation() {
        objCObject.associateKey(&AssociationKeys.ObjCKey, withObject: objCAssociation!, policy: .NonatomicRetain)
        association = objCObject.associationForKey(&AssociationKeys.ObjCKey)
        XCTAssertEqual(association as! SampleObjCClass, objCAssociation!, "The Objective-C object should have an associated Objective-C object")
        XCTAssertEqual(lastAssociationPolicy!, ObjectAssociationPolicy.NonatomicRetain, "The provided association policy should be used")
        lastAssociationPolicy = nil

        objCObject.associateKey(&AssociationKeys.SwiftKey, withObject: swiftAssociation!, policy: .NonatomicRetain)
        association = objCObject.associationForKey(&AssociationKeys.SwiftKey)
        XCTAssertEqual(association as! SampleSwiftClass, swiftAssociation!, "The Objective-C object should have an associated Swift object")
        XCTAssertEqual(lastAssociationPolicy!, ObjectAssociationPolicy.NonatomicRetain, "The provided association policy should be used")
        lastAssociationPolicy = nil
    }

    func testNonatomicRetainSwiftAssociation() {
        swiftObject.associateKey(&AssociationKeys.ObjCKey, withObject: objCAssociation!, policy: .NonatomicRetain)
        association = swiftObject.associationForKey(&AssociationKeys.ObjCKey)
        XCTAssertEqual(association as! SampleObjCClass, objCAssociation!, "The Objective-C object should have an associated Objective-C object")
        XCTAssertEqual(lastAssociationPolicy!, ObjectAssociationPolicy.NonatomicRetain, "The provided association policy should be used")
        lastAssociationPolicy = nil

        swiftObject.associateKey(&AssociationKeys.SwiftKey, withObject: swiftAssociation!, policy: .NonatomicRetain)
        association = swiftObject.associationForKey(&AssociationKeys.SwiftKey)
        XCTAssertEqual(association as! SampleSwiftClass, swiftAssociation!, "The Objective-C object should have an associated Swift object")
        XCTAssertEqual(lastAssociationPolicy!, ObjectAssociationPolicy.NonatomicRetain, "The provided association policy should be used")
        lastAssociationPolicy = nil
    }


    //  MARK: AtomicCopy policy

    func testAtomicCopyObjectiveCAssociation() {
        objCObject.associateKey(&AssociationKeys.ObjCKey, withObject: objCAssociation!, policy: .AtomicCopy)
        association = objCObject.associationForKey(&AssociationKeys.ObjCKey)
        XCTAssertEqual(association as! SampleObjCClass, objCAssociation!, "The Objective-C object should have an associated Objective-C object")
        XCTAssertEqual(lastAssociationPolicy!, ObjectAssociationPolicy.AtomicCopy, "The provided association policy should be used")
        lastAssociationPolicy = nil

        objCObject.associateKey(&AssociationKeys.SwiftKey, withObject: swiftAssociation!, policy: .AtomicCopy)
        association = objCObject.associationForKey(&AssociationKeys.SwiftKey)
        XCTAssertEqual(association as! SampleSwiftClass, swiftAssociation!, "The Objective-C object should have an associated Swift object")
        XCTAssertEqual(lastAssociationPolicy!, ObjectAssociationPolicy.AtomicCopy, "The provided association policy should be used")
        lastAssociationPolicy = nil
    }

    func testAtomicCopySwiftAssociation() {
        swiftObject.associateKey(&AssociationKeys.ObjCKey, withObject: objCAssociation!, policy: .AtomicCopy)
        association = swiftObject.associationForKey(&AssociationKeys.ObjCKey)
        XCTAssertEqual(association as! SampleObjCClass, objCAssociation!, "The Objective-C object should have an associated Objective-C object")
        XCTAssertEqual(lastAssociationPolicy!, ObjectAssociationPolicy.AtomicCopy, "The provided association policy should be used")
        lastAssociationPolicy = nil

        swiftObject.associateKey(&AssociationKeys.SwiftKey, withObject: swiftAssociation!, policy: .AtomicCopy)
        association = swiftObject.associationForKey(&AssociationKeys.SwiftKey)
        XCTAssertEqual(association as! SampleSwiftClass, swiftAssociation!, "The Objective-C object should have an associated Swift object")
        XCTAssertEqual(lastAssociationPolicy!, ObjectAssociationPolicy.AtomicCopy, "The provided association policy should be used")
        lastAssociationPolicy = nil
    }


    //  MARK: NonatomicCopy policy

    func testNonatomicCopyObjectiveCAssociation() {
        objCObject.associateKey(&AssociationKeys.ObjCKey, withObject: objCAssociation!, policy: .NonatomicCopy)
        association = objCObject.associationForKey(&AssociationKeys.ObjCKey)
        XCTAssertEqual(association as! SampleObjCClass, objCAssociation!, "The Objective-C object should have an associated Objective-C object")
        XCTAssertEqual(lastAssociationPolicy!, ObjectAssociationPolicy.NonatomicCopy, "The provided association policy should be used")
        lastAssociationPolicy = nil

        objCObject.associateKey(&AssociationKeys.SwiftKey, withObject: swiftAssociation!, policy: .NonatomicCopy)
        association = objCObject.associationForKey(&AssociationKeys.SwiftKey)
        XCTAssertEqual(association as! SampleSwiftClass, swiftAssociation!, "The Objective-C object should have an associated Swift object")
        XCTAssertEqual(lastAssociationPolicy!, ObjectAssociationPolicy.NonatomicCopy, "The provided association policy should be used")
        lastAssociationPolicy = nil
    }

    func testNonatomicCopySwiftAssociation() {
        swiftObject.associateKey(&AssociationKeys.ObjCKey, withObject: objCAssociation!, policy: .NonatomicCopy)
        association = swiftObject.associationForKey(&AssociationKeys.ObjCKey)
        XCTAssertEqual(association as! SampleObjCClass, objCAssociation!, "The Objective-C object should have an associated Objective-C object")
        XCTAssertEqual(lastAssociationPolicy!, ObjectAssociationPolicy.NonatomicCopy, "The provided association policy should be used")
        lastAssociationPolicy = nil

        swiftObject.associateKey(&AssociationKeys.SwiftKey, withObject: swiftAssociation!, policy: .NonatomicCopy)
        association = swiftObject.associationForKey(&AssociationKeys.SwiftKey)
        XCTAssertEqual(association as! SampleSwiftClass, swiftAssociation!, "The Objective-C object should have an associated Swift object")
        XCTAssertEqual(lastAssociationPolicy!, ObjectAssociationPolicy.NonatomicCopy, "The provided association policy should be used")
        lastAssociationPolicy = nil
    }


    //  MARK: Clearing single association

    func testClearingSingleObjectiveCAssociation() {
        //  Removing associatied Objective-C object
        objCObject.associateKey(&AssociationKeys.ObjCKey, withObject: objCAssociation!, policy: .AtomicRetain)
        objCObject.associateKey(&AssociationKeys.SwiftKey, withObject: swiftAssociation!, policy: .AtomicRetain)
        lastAssociationPolicy = nil
        objCObject.clearAssociationForKey(&AssociationKeys.ObjCKey)
        association = objCObject.associationForKey(&AssociationKeys.ObjCKey)
        XCTAssertNil(association, "The specified association should be cleared")
        association = objCObject.associationForKey(&AssociationKeys.SwiftKey)
        XCTAssertEqual(association as! SampleSwiftClass, swiftAssociation!, "Only the speicified association should be cleared")
        XCTAssertNil(lastAssociatedObject, "Nil should be used as the 'new' association")
        XCTAssertEqual(lastAssociationPolicy!, ObjectAssociationPolicy.Assign, "The Assign policy should be used for clearing associations")

        //  Removing associatied Swift object
        objCObject.associateKey(&AssociationKeys.ObjCKey, withObject: objCAssociation!, policy: .AtomicRetain)
        objCObject.associateKey(&AssociationKeys.SwiftKey, withObject: swiftAssociation!, policy: .AtomicRetain)
        lastAssociationPolicy = nil
        objCObject.clearAssociationForKey(&AssociationKeys.SwiftKey)
        association = objCObject.associationForKey(&AssociationKeys.SwiftKey)
        XCTAssertNil(association, "The specified association should be cleared")
        association = objCObject.associationForKey(&AssociationKeys.ObjCKey)
        XCTAssertEqual(association as! SampleObjCClass, objCAssociation!, "Only the speicified association should be cleared")
        XCTAssertNil(lastAssociatedObject, "Nil should be used as the 'new' association")
        XCTAssertEqual(lastAssociationPolicy!, ObjectAssociationPolicy.Assign, "The Assign policy should be used for clearing associations")
    }

    func testClearingSingleSwiftAssociation() {
        //  Removing associatied Objective-C object
        swiftObject.associateKey(&AssociationKeys.ObjCKey, withObject: objCAssociation!, policy: .AtomicRetain)
        swiftObject.associateKey(&AssociationKeys.SwiftKey, withObject: swiftAssociation!, policy: .AtomicRetain)
        lastAssociationPolicy = nil
        swiftObject.clearAssociationForKey(&AssociationKeys.ObjCKey)
        association = swiftObject.associationForKey(&AssociationKeys.ObjCKey)
        XCTAssertNil(association, "The specified association should be cleared")
        association = swiftObject.associationForKey(&AssociationKeys.SwiftKey)
        XCTAssertEqual(association as! SampleSwiftClass, swiftAssociation!, "Only the speicified association should be cleared")
        XCTAssertNil(lastAssociatedObject, "Nil should be used as the 'new' association")
        XCTAssertEqual(lastAssociationPolicy!, ObjectAssociationPolicy.Assign, "The Assign policy should be used for clearing associations")

        //  Removing associatied Swift object
        swiftObject.associateKey(&AssociationKeys.ObjCKey, withObject: objCAssociation!, policy: .AtomicRetain)
        swiftObject.associateKey(&AssociationKeys.SwiftKey, withObject: swiftAssociation!, policy: .AtomicRetain)
        lastAssociationPolicy = nil
        swiftObject.clearAssociationForKey(&AssociationKeys.SwiftKey)
        association = swiftObject.associationForKey(&AssociationKeys.SwiftKey)
        XCTAssertNil(association, "The specified association should be cleared")
        association = swiftObject.associationForKey(&AssociationKeys.ObjCKey)
        XCTAssertEqual(association as! SampleObjCClass, objCAssociation!, "Only the speicified association should be cleared")
        XCTAssertNil(lastAssociatedObject, "Nil should be used as the 'new' association")
        XCTAssertEqual(lastAssociationPolicy!, ObjectAssociationPolicy.Assign, "The Assign policy should be used for clearing associations")
    }

    //  MARK: Clearing all associations

    func testClearingAllObjectiveCAssociations() {
        objCObject.associateKey(&AssociationKeys.ObjCKey, withObject: objCAssociation!, policy: .AtomicRetain)
        objCObject.associateKey(&AssociationKeys.SwiftKey, withObject: swiftAssociation!, policy: .AtomicRetain)
        objCObject.clearAllAssociations()
        association = objCObject.associationForKey(&AssociationKeys.ObjCKey)
        XCTAssertNil(association, "The Objective-C association should be cleared")
        association = objCObject.associationForKey(&AssociationKeys.SwiftKey)
        XCTAssertNil(association, "The Swift association should be cleared")
        XCTAssertTrue(removeAssociatedObjectsCalled, "The all-object-associations removal function should be called")
        XCTAssertEqual(removeAssociatedObjectsObject as! SampleObjCClass, objCObject, "The correct object should be passed to the function")
    }

    func testClearingAllSwiftAssociations() {
        swiftObject.associateKey(&AssociationKeys.ObjCKey, withObject: objCAssociation!, policy: .AtomicRetain)
        swiftObject.associateKey(&AssociationKeys.SwiftKey, withObject: swiftAssociation!, policy: .AtomicRetain)
        swiftObject.clearAllAssociations()
        association = swiftObject.associationForKey(&AssociationKeys.ObjCKey)
        XCTAssertNil(association, "The Objective-C association should be cleared")
        association = swiftObject.associationForKey(&AssociationKeys.SwiftKey)
        XCTAssertNil(association, "The Swift association should be cleared")
        XCTAssertTrue(removeAssociatedObjectsCalled, "The all-object-associations removal function should be called")
        XCTAssertEqual(removeAssociatedObjectsObject as! SampleSwiftClass, swiftObject, "The correct object should be passed to the function")
    }
*/
}


//  MARK: Sample classes for testing

private class SampleObjCClass: NSObject {
    private let name: String
    private init(_ name: String) {
        self.name = name
    }

    private override func copy() -> AnyObject {
        return SampleObjCClass(name)
    }

    private override func isEqual(_ object: AnyObject?) -> Bool {
        let other = object as! SampleObjCClass
        return name == other.name
    }
}

private class SampleSwiftClass: Equatable, NSCopying {
    private let name: String
    private init(_ name: String) {
        self.name = name
    }

    @objc private func copy() -> AnyObject {
        return copy(with: nil)
    }

    @objc private func copy(with zone: NSZone?) -> AnyObject {
        return SampleSwiftClass(name)
    }
}

extension SampleSwiftClass: ObjectAssociable {
    private func associate(key: UnsafePointer<Void>, withObject association: AnyObject, policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_ASSIGN) {
        objc_setAssociatedObject(self, key, association, policy)
    }

    private func association(forKey key: UnsafePointer<Void>) -> AnyObject? {
        return objc_getAssociatedObject(self, key)
    }

    private func clearAssociation(forKey key: UnsafePointer<Void>) {
        objc_setAssociatedObject(self, key, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
    }

    private func clearAllAssociations() {
        objc_removeAssociatedObjects(self)
    }
}

private func ==(lhs: SampleSwiftClass, rhs: SampleSwiftClass) -> Bool {
    return lhs.name == rhs.name
}
