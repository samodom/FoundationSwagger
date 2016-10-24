//
//  ObjectAssociationTests.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 2/7/15.
//  Copyright (c) 2015 Swagger Soft. All rights reserved.
//

import XCTest
import FoundationSwagger

fileprivate let SampleKey = UnsafeRawPointer("Sample key")

class ObjectAssociationTests: XCTestCase {

    let objCObject = SampleObjectiveCClass(14)

    let objCStructAssociation = SampleObjectiveCStructure(value: 14)
    let objCEnumAssociation = SampleObjectiveCEnumerationAlpha

    let swiftObject = SampleSwiftClass(14)

    let swiftStructAssociation = SampleSwiftStructure(value: 14)
    let swiftEnumAssociation = SampleSwiftEnumeration.only(14)

    weak var weakReference: AnyObject?

}

//  MARK: - Retrieving associations

extension ObjectAssociationTests {

    func testRetrievingObjectiveCAssociationsFromObjectiveCObject() {
        let objectAssociation = SampleObjectiveCClass(42)
        objc_setAssociatedObject(objCObject, SampleKey, objectAssociation, .OBJC_ASSOCIATION_RETAIN)
        XCTAssertEqual(
            objCObject.associationForKey(SampleKey) as? SampleObjectiveCClass,
            objectAssociation,
            "The associated object should be retrieved with its key"
        )

        objc_setAssociatedObject(objCObject, SampleKey, objCStructAssociation, .OBJC_ASSOCIATION_RETAIN)
        XCTAssertTrue(
            SampleObjectiveCStructuresEqual(
                objCObject.associationForKey(SampleKey) as! SampleObjectiveCStructure,
                objCStructAssociation
            ),
            "The associated struct should be retrieved with its key"
        )

        objc_setAssociatedObject(objCObject, SampleKey, objCEnumAssociation, .OBJC_ASSOCIATION_RETAIN)
        XCTAssertEqual(
            objCObject.associationForKey(SampleKey) as? SampleObjectiveCEnumeration,
            objCEnumAssociation,
            "The associated enum should be retrieved with its key"
        )
    }

    func testRetrievingSwiftAssociationsFromObjectiveCObject() {
        let objectAssociation = SampleSwiftClass(42)
        objc_setAssociatedObject(objCObject, SampleKey, objectAssociation, .OBJC_ASSOCIATION_RETAIN)
        XCTAssertEqual(
            objCObject.associationForKey(SampleKey) as? SampleSwiftClass,
            objectAssociation,
            "The associated object should be retrieved with its key"
        )

        objc_setAssociatedObject(objCObject, SampleKey, swiftStructAssociation, .OBJC_ASSOCIATION_RETAIN)
        XCTAssertEqual(
            objCObject.associationForKey(SampleKey) as? SampleSwiftStructure,
            swiftStructAssociation,
            "The associated struct should be retrieved with its key"
        )

        objc_setAssociatedObject(objCObject, SampleKey, swiftEnumAssociation, .OBJC_ASSOCIATION_RETAIN)
        XCTAssertEqual(
            objCObject.associationForKey(SampleKey) as? SampleSwiftEnumeration,
            swiftEnumAssociation,
            "The associated enum should be retrieved with its key"
        )
    }

    func testRetrievingObjectiveCAssociationsFromSwiftObject() {
        let objectAssociation = SampleObjectiveCClass(42)
        objc_setAssociatedObject(swiftObject, SampleKey, objectAssociation, .OBJC_ASSOCIATION_RETAIN)
        XCTAssertEqual(
            swiftObject.associationForKey(SampleKey) as? SampleObjectiveCClass,
            objectAssociation,
            "The associated object should be retrieved with its key"
        )

        objc_setAssociatedObject(swiftObject, SampleKey, objCStructAssociation, .OBJC_ASSOCIATION_RETAIN)
        XCTAssertTrue(
            SampleObjectiveCStructuresEqual(
                swiftObject.associationForKey(SampleKey) as! SampleObjectiveCStructure,
                objCStructAssociation
            ),
            "The associated struct should be retrieved with its key"
        )

        objc_setAssociatedObject(swiftObject, SampleKey, objCEnumAssociation, .OBJC_ASSOCIATION_RETAIN)
        XCTAssertEqual(
            swiftObject.associationForKey(SampleKey) as? SampleObjectiveCEnumeration,
            objCEnumAssociation,
            "The associated enum should be retrieved with its key"
        )
    }

    func testRetrievingSwiftAssociationsFromSwiftObject() {
        let objectAssociation = SampleSwiftClass(42)
        objc_setAssociatedObject(swiftObject, SampleKey, objectAssociation, .OBJC_ASSOCIATION_RETAIN)
        XCTAssertEqual(
            swiftObject.associationForKey(SampleKey) as? SampleSwiftClass,
            objectAssociation,
            "The associated object should be retrieved with its key"
        )

        objc_setAssociatedObject(swiftObject, SampleKey, swiftStructAssociation, .OBJC_ASSOCIATION_RETAIN)
        XCTAssertEqual(
            swiftObject.associationForKey(SampleKey) as? SampleSwiftStructure,
            swiftStructAssociation,
            "The associated struct should be retrieved with its key"
        )

        objc_setAssociatedObject(swiftObject, SampleKey, swiftEnumAssociation, .OBJC_ASSOCIATION_RETAIN)
        XCTAssertEqual(
            swiftObject.associationForKey(SampleKey) as? SampleSwiftEnumeration,
            swiftEnumAssociation,
            "The associated enum should be retrieved with its key"
        )
    }

}


//  MARK: - Assign policy

extension ObjectAssociationTests {

    func testAssignObjectiveCAssociationWithObjectiveCTypes() {
        autoreleasepool {
            let association = SampleObjectiveCClass(42)
            objCObject.associate(association, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_ASSIGN)
            XCTAssertEqual(
                objc_getAssociatedObject(objCObject, SampleKey) as? SampleObjectiveCClass,
                association,
                "The Objective-C object should have an associated Objective-C object"
            )

            weakReference = association
        }

        XCTAssertNil(weakReference, "The association should be made with pointer assignment")
    }

    func testAssignObjectiveCAssociationWithSwiftTypes() {
        autoreleasepool {
            let association = SampleSwiftClass(42)
            objCObject.associate(association, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_ASSIGN)
            XCTAssertEqual(
                objc_getAssociatedObject(objCObject, SampleKey) as? SampleSwiftClass,
                association,
                "The Objective-C object should have an associated Swift object"
            )

            weakReference = association
        }

        XCTAssertNil(weakReference, "The association should be made with pointer assignment")
    }

    func testAssignSwiftAssociationWithObjectiveCTypes() {
        autoreleasepool {
            let association = SampleObjectiveCClass(42)
            swiftObject.associate(association, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_ASSIGN)
            XCTAssertEqual(objc_getAssociatedObject(swiftObject, SampleKey) as? SampleObjectiveCClass, association, "The Swift object should have an associated Objective-C object")
            XCTAssertEqual(swiftObject.associationForKey(SampleKey) as? SampleObjectiveCClass, association, "The association should be retrievable using the new API")
            weakReference = association
        }

        XCTAssertNil(weakReference, "The association should be made with pointer assignment")
    }

    func testAssignSwiftAssociationWithSwiftTypes() {
        autoreleasepool {
            let association = SampleSwiftClass(42)
            swiftObject.associate(association, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_ASSIGN)
            XCTAssertEqual(objc_getAssociatedObject(swiftObject, SampleKey) as? SampleSwiftClass, association, "The Swift object should have an associated Swift object")
            XCTAssertEqual(swiftObject.associationForKey(SampleKey) as? SampleSwiftClass, association, "The Swift object should have an associated Swift object")
            weakReference = association
        }

        XCTAssertNil(weakReference, "The association should be made with pointer assignment")
    }

}


//  MARK: - Atomic retain policy

extension ObjectAssociationTests {

    func testAtomicRetainObjectiveCAssociationWithObjectiveCTypes() {
        autoreleasepool {
            let association = SampleObjectiveCClass(42)
            objCObject.associate(association, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_RETAIN)
            XCTAssertEqual(
                objc_getAssociatedObject(objCObject, SampleKey) as? SampleObjectiveCClass,
                association,
                "The Objective-C object should have an associated Objective-C object"
            )
            //  TODO: test atomicity

            weakReference = association
        }

        XCTAssertNotNil(weakReference, "The association should be retained")

        objCObject.associate(objCStructAssociation, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_RETAIN)
        XCTAssertTrue(
            SampleObjectiveCStructuresEqual(
                objCObject.associationForKey(SampleKey) as! SampleObjectiveCStructure,
                objCStructAssociation
            ),
            "The Objective-C object should have an associated Objective-C struct"
        )
        //  TODO: test atomicity

        objCObject.associate(objCEnumAssociation, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_RETAIN)
        XCTAssertEqual(
            objc_getAssociatedObject(objCObject, SampleKey) as? SampleObjectiveCEnumeration,
            objCEnumAssociation,
            "The Objective-C object should have an associated Objective-C enum"
        )
        //  TODO: test atomicity
    }

    func testAtomicRetainObjectiveCAssociationWithSwiftTypes() {
        autoreleasepool {
            let association = SampleSwiftClass(42)
            objCObject.associate(association, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_RETAIN)
            XCTAssertEqual(
                objCObject.associationForKey(SampleKey) as? SampleSwiftClass,
                association,
                "The Objective-C object should have an associated Swift object"
            )
            //  TODO: test atomicity

            weakReference = association
        }

        XCTAssertNotNil(weakReference, "The association should be retained")

        objCObject.associate(swiftStructAssociation, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_RETAIN)
        XCTAssertEqual(
            objCObject.associationForKey(SampleKey) as? SampleSwiftStructure,
            swiftStructAssociation,
            "The Objective-C object should have an associated Swift struct"
        )
        //  TODO: test atomicity

        objCObject.associate(swiftEnumAssociation, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_RETAIN)
        XCTAssertEqual(
            objc_getAssociatedObject(objCObject, SampleKey) as? SampleSwiftEnumeration,
            swiftEnumAssociation,
            "The Objective-C object should have an associated Swift enum"
        )
        //  TODO: test atomicity
    }

    func testAtomicRetainSwiftAssociationWithObjectiveCTypes() {
        autoreleasepool {
            let association = SampleObjectiveCClass(42)
            swiftObject.associate(association, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_RETAIN)
            XCTAssertEqual(
                objc_getAssociatedObject(swiftObject, SampleKey) as? SampleObjectiveCClass,
                association,
                "The Swift object should have an associated Objective-C object"
            )
            //  TODO: test atomicity

            weakReference = association
        }

        XCTAssertNotNil(weakReference, "The association should be retained")

        swiftObject.associate(objCStructAssociation, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_RETAIN)
        XCTAssertTrue(
            SampleObjectiveCStructuresEqual(
                swiftObject.associationForKey(SampleKey) as! SampleObjectiveCStructure,
                objCStructAssociation
            ),
            "The Swift object should have an associated Objective-C struct"
        )
        //  TODO: test atomicity

        swiftObject.associate(objCEnumAssociation, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_RETAIN)
        XCTAssertEqual(
            objc_getAssociatedObject(swiftObject, SampleKey) as? SampleObjectiveCEnumeration,
            objCEnumAssociation,
            "The Swift object should have an associated Objective-C enum"
        )
        //  TODO: test atomicity
    }

    func testAtomicRetainSwiftAssociationWithSwiftTypes() {
        autoreleasepool {
            let association = SampleSwiftClass(42)
            swiftObject.associate(association, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_RETAIN)
            XCTAssertEqual(
                swiftObject.associationForKey(SampleKey) as? SampleSwiftClass,
                association,
                "The Swift object should have an associated Swift object"
            )
            //  TODO: test atomicity

            weakReference = association
        }

        XCTAssertNotNil(weakReference, "The association should be retained")

        swiftObject.associate(swiftStructAssociation, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_RETAIN)
        XCTAssertEqual(
            swiftObject.associationForKey(SampleKey) as? SampleSwiftStructure,
            swiftStructAssociation,
            "The Swift object should have an associated Swift struct"
        )
        //  TODO: test atomicity

        swiftObject.associate(swiftEnumAssociation, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_RETAIN)
        XCTAssertEqual(
            objc_getAssociatedObject(swiftObject, SampleKey) as? SampleSwiftEnumeration,
            swiftEnumAssociation,
            "The Swift object should have an associated Swift enum"
        )
        //  TODO: test atomicity
    }

}


//  MARK: - Non-atomic retain policy

extension ObjectAssociationTests {

    func testNonAtomicRetainObjectiveCAssociationWithObjectiveCTypes() {
        autoreleasepool {
            let association = SampleObjectiveCClass(42)
            objCObject.associate(association, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            XCTAssertEqual(
                objc_getAssociatedObject(objCObject, SampleKey) as? SampleObjectiveCClass,
                association,
                "The Objective-C object should have an associated Objective-C object"
            )
            //  TODO: test atomicity

            weakReference = association
        }

        XCTAssertNotNil(weakReference, "The association should be retained")

        objCObject.associate(objCStructAssociation, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        XCTAssertTrue(
            SampleObjectiveCStructuresEqual(
                objCObject.associationForKey(SampleKey) as! SampleObjectiveCStructure,
                objCStructAssociation
            ),
            "The Objective-C object should have an associated Objective-C struct"
        )
        //  TODO: test atomicity

        objCObject.associate(objCEnumAssociation, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        XCTAssertEqual(
            objc_getAssociatedObject(objCObject, SampleKey) as? SampleObjectiveCEnumeration,
            objCEnumAssociation,
            "The Objective-C object should have an associated Objective-C enum"
        )
        //  TODO: test atomicity
    }

    func testNonAtomicRetainObjectiveCAssociationWithSwiftTypes() {
        autoreleasepool {
            let association = SampleSwiftClass(42)
            objCObject.associate(association, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            XCTAssertEqual(
                objCObject.associationForKey(SampleKey) as? SampleSwiftClass,
                association,
                "The Objective-C object should have an associated Swift object"
            )
            //  TODO: test atomicity

            weakReference = association
        }

        XCTAssertNotNil(weakReference, "The association should be retained")

        objCObject.associate(swiftStructAssociation, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        XCTAssertEqual(
            objCObject.associationForKey(SampleKey) as? SampleSwiftStructure,
            swiftStructAssociation,
            "The Objective-C object should have an associated Swift struct"
        )
        //  TODO: test atomicity

        objCObject.associate(swiftEnumAssociation, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        XCTAssertEqual(
            objc_getAssociatedObject(objCObject, SampleKey) as? SampleSwiftEnumeration,
            swiftEnumAssociation,
            "The Objective-C object should have an associated Swift enum"
        )
        //  TODO: test atomicity
    }

    func testNonAtomicRetainSwiftAssociationWithObjectiveCTypes() {
        autoreleasepool {
            let association = SampleObjectiveCClass(42)
            swiftObject.associate(association, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            XCTAssertEqual(
                objc_getAssociatedObject(swiftObject, SampleKey) as? SampleObjectiveCClass,
                association,
                "The Swift object should have an associated Objective-C object"
            )
            //  TODO: test atomicity

            weakReference = association
        }

        XCTAssertNotNil(weakReference, "The association should be retained")

        swiftObject.associate(objCStructAssociation, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        XCTAssertTrue(
            SampleObjectiveCStructuresEqual(
                swiftObject.associationForKey(SampleKey) as! SampleObjectiveCStructure,
                objCStructAssociation
            ),
            "The Swift object should have an associated Objective-C struct"
        )
        //  TODO: test atomicity

        swiftObject.associate(objCEnumAssociation, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        XCTAssertEqual(
            objc_getAssociatedObject(swiftObject, SampleKey) as? SampleObjectiveCEnumeration,
            objCEnumAssociation,
            "The Swift object should have an associated Objective-C enum"
        )
        //  TODO: test atomicity
    }

    func testNonAtomicRetainSwiftAssociationWithSwiftTypes() {
        autoreleasepool {
            let association = SampleSwiftClass(42)
            swiftObject.associate(association, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            XCTAssertEqual(
                swiftObject.associationForKey(SampleKey) as? SampleSwiftClass,
                association,
                "The Swift object should have an associated Swift object"
            )
            //  TODO: test atomicity

            weakReference = association
        }

        XCTAssertNotNil(weakReference, "The association should be retained")

        swiftObject.associate(swiftStructAssociation, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        XCTAssertEqual(
            swiftObject.associationForKey(SampleKey) as? SampleSwiftStructure,
            swiftStructAssociation,
            "The Swift object should have an associated Swift struct"
        )
        //  TODO: test atomicity

        swiftObject.associate(swiftEnumAssociation, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        XCTAssertEqual(
            objc_getAssociatedObject(swiftObject, SampleKey) as? SampleSwiftEnumeration,
            swiftEnumAssociation,
            "The Swift object should have an associated Swift enum"
        )
        //  TODO: test atomicity
    }

}


//  MARK: - Atomic copy policy

extension ObjectAssociationTests {

    func testAtomicCopyObjectiveCAssociationWithObjectiveCTypes() {
        let association = SampleObjectiveCClass(42)
        objCObject.associate(association, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_COPY)
        let reference = objc_getAssociatedObject(objCObject, SampleKey) as? SampleObjectiveCClass
        XCTAssertEqual(reference, association, "The Objective-C object should have an associated Objective-C object")
        XCTAssertTrue(reference !== association, "The association should be made with a copy of the original object")
        //  TODO: test atomicity

        objCObject.associate(objCStructAssociation, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_COPY)
        XCTAssertTrue(
            SampleObjectiveCStructuresEqual(
                objCObject.associationForKey(SampleKey) as! SampleObjectiveCStructure,
                objCStructAssociation
            ),
            "The Objective-C object should have an associated Objective-C struct"
        )
        //  TODO: test atomicity

        objCObject.associate(objCEnumAssociation, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_COPY)
        XCTAssertEqual(
            objc_getAssociatedObject(objCObject, SampleKey) as? SampleObjectiveCEnumeration,
            objCEnumAssociation,
            "The Objective-C object should have an associated Objective-C enum"
        )
        //  TODO: test atomicity
    }

    func testAtomicCopyObjectiveCAssociationWithSwiftTypes() {
        let association = SampleSwiftClass(42)
        objCObject.associate(association, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_COPY)
        let reference = objCObject.associationForKey(SampleKey) as? SampleSwiftClass
        XCTAssertEqual(reference, association, "The Objective-C object should have an associated Swift object")
        XCTAssertTrue(reference !== association, "The association should be made with a copy of the original object")
        //  TODO: test atomicity

        objCObject.associate(swiftStructAssociation, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_COPY)
        XCTAssertEqual(
            objCObject.associationForKey(SampleKey) as? SampleSwiftStructure,
            swiftStructAssociation,
            "The Objective-C object should have an associated Swift struct"
        )
        //  TODO: test atomicity

        objCObject.associate(swiftEnumAssociation, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_COPY)
        XCTAssertEqual(
            objc_getAssociatedObject(objCObject, SampleKey) as? SampleSwiftEnumeration,
            swiftEnumAssociation,
            "The Objective-C object should have an associated Swift enum"
        )
        //  TODO: test atomicity
    }

    func testAtomicCopySwiftAssociationWithObjectiveCTypes() {
        let association = SampleObjectiveCClass(42)
        swiftObject.associate(association, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_COPY)
        let reference = objc_getAssociatedObject(swiftObject, SampleKey) as? SampleObjectiveCClass
        XCTAssertEqual(reference, association, "The Swift object should have an associated Objective-C object")
        XCTAssertTrue(reference !== association, "The association should be made with a copy of the original object")
        //  TODO: test atomicity

        swiftObject.associate(objCStructAssociation, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_COPY)
        XCTAssertTrue(
            SampleObjectiveCStructuresEqual(
                swiftObject.associationForKey(SampleKey) as! SampleObjectiveCStructure,
                objCStructAssociation
            ),
            "The Swift object should have an associated Objective-C struct"
        )
        //  TODO: test atomicity

        swiftObject.associate(objCEnumAssociation, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_COPY)
        XCTAssertEqual(
            objc_getAssociatedObject(swiftObject, SampleKey) as? SampleObjectiveCEnumeration,
            objCEnumAssociation,
            "The Swift object should have an associated Objective-C enum"
        )
        //  TODO: test atomicity
    }

    func testAtomicCopySwiftAssociationWithSwiftTypes() {
        let association = SampleSwiftClass(42)
        swiftObject.associate(association, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_COPY)
        let reference = swiftObject.associationForKey(SampleKey) as? SampleSwiftClass
        XCTAssertEqual(reference, association, "The Swift object should have an associated Swift object")
        XCTAssertTrue(reference !== association, "The association should be made with a copy of the original object")
        //  TODO: test atomicity

        swiftObject.associate(swiftStructAssociation, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_COPY)
        XCTAssertEqual(
            swiftObject.associationForKey(SampleKey) as? SampleSwiftStructure,
            swiftStructAssociation,
            "The Swift object should have an associated Swift struct"
        )
        //  TODO: test atomicity

        swiftObject.associate(swiftEnumAssociation, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_COPY)
        XCTAssertEqual(
            objc_getAssociatedObject(swiftObject, SampleKey) as? SampleSwiftEnumeration,
            swiftEnumAssociation,
            "The Swift object should have an associated Swift enum"
        )
        //  TODO: test atomicity
    }

}


//  MARK: - Non-atomic copy policy

extension ObjectAssociationTests {

    func testNonAtomicCopyObjectiveCAssociationWithObjectiveCTypes() {
        let association = SampleObjectiveCClass(42)
        objCObject.associate(association, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_COPY_NONATOMIC)
        let reference = objc_getAssociatedObject(objCObject, SampleKey) as? SampleObjectiveCClass
        XCTAssertEqual(reference, association, "The Objective-C object should have an associated Objective-C object")
        XCTAssertTrue(reference !== association, "The association should be made with a copy of the original object")
        //  TODO: test atomicity

        objCObject.associate(objCStructAssociation, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_COPY)
        XCTAssertTrue(
            SampleObjectiveCStructuresEqual(
                objCObject.associationForKey(SampleKey) as! SampleObjectiveCStructure,
                objCStructAssociation
            ),
            "The Objective-C object should have an associated Objective-C struct"
        )
        //  TODO: test atomicity

        objCObject.associate(objCEnumAssociation, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_COPY_NONATOMIC)
        XCTAssertEqual(
            objc_getAssociatedObject(objCObject, SampleKey) as? SampleObjectiveCEnumeration,
            objCEnumAssociation,
            "The Objective-C object should have an associated Objective-C enum"
        )
        //  TODO: test atomicity
    }

    func testNonAtomicCopyObjectiveCAssociationWithSwiftTypes() {
        let association = SampleSwiftClass(42)
        objCObject.associate(association, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_COPY_NONATOMIC)
        let reference = objCObject.associationForKey(SampleKey) as? SampleSwiftClass
        XCTAssertEqual(reference, association, "The Objective-C object should have an associated Swift object")
        XCTAssertTrue(reference !== association, "The association should be made with a copy of the original object")
        //  TODO: test atomicity

        objCObject.associate(swiftStructAssociation, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_COPY_NONATOMIC)
        XCTAssertEqual(
            objCObject.associationForKey(SampleKey) as? SampleSwiftStructure,
            swiftStructAssociation,
            "The Objective-C object should have an associated Swift struct"
        )
        //  TODO: test atomicity

        objCObject.associate(swiftEnumAssociation, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_COPY_NONATOMIC)
        XCTAssertEqual(
            objc_getAssociatedObject(objCObject, SampleKey) as? SampleSwiftEnumeration,
            swiftEnumAssociation,
            "The Objective-C object should have an associated Swift enum"
        )
        //  TODO: test atomicity
    }

    func testNonAtomicCopySwiftAssociationWithObjectiveCTypes() {
        let association = SampleObjectiveCClass(42)
        swiftObject.associate(association, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_COPY_NONATOMIC)
        let reference = objc_getAssociatedObject(swiftObject, SampleKey) as? SampleObjectiveCClass
        XCTAssertEqual(reference, association, "The Swift object should have an associated Objective-C object")
        XCTAssertTrue(reference !== association, "The association should be made with a copy of the original object")
        //  TODO: test atomicity

        swiftObject.associate(objCStructAssociation, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_COPY_NONATOMIC)
        XCTAssertTrue(
            SampleObjectiveCStructuresEqual(
                swiftObject.associationForKey(SampleKey) as! SampleObjectiveCStructure,
                objCStructAssociation
            ),
            "The Swift object should have an associated Objective-C struct"
        )
        //  TODO: test atomicity

        swiftObject.associate(objCEnumAssociation, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_COPY_NONATOMIC)
        XCTAssertEqual(
            objc_getAssociatedObject(swiftObject, SampleKey) as? SampleObjectiveCEnumeration,
            objCEnumAssociation,
            "The Swift object should have an associated Objective-C enum"
        )
        //  TODO: test atomicity
    }

    func testNonAtomicCopySwiftAssociationWithSwiftTypes() {
        let association = SampleSwiftClass(42)
        swiftObject.associate(association, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_COPY_NONATOMIC)
        let reference = swiftObject.associationForKey(SampleKey) as? SampleSwiftClass
        XCTAssertEqual(reference, association, "The Swift object should have an associated Swift object")
        XCTAssertTrue(reference !== association, "The association should be made with a copy of the original object")
        //  TODO: test atomicity

        swiftObject.associate(swiftStructAssociation, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_COPY_NONATOMIC)
        XCTAssertEqual(
            swiftObject.associationForKey(SampleKey) as? SampleSwiftStructure,
            swiftStructAssociation,
            "The Swift object should have an associated Swift struct"
        )
        //  TODO: test atomicity

        swiftObject.associate(swiftEnumAssociation, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_COPY_NONATOMIC)
        XCTAssertEqual(
            objc_getAssociatedObject(swiftObject, SampleKey) as? SampleSwiftEnumeration,
            swiftEnumAssociation,
            "The Swift object should have an associated Swift enum"
        )
        //  TODO: test atomicity
    }

}

//  MARK: - Default policy

extension ObjectAssociationTests {

    func testDefaultPolicyObjectiveCAssociationWithObjectiveCTypes() {
        autoreleasepool {
            let association = SampleObjectiveCClass(42)
            objCObject.associate(association, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            XCTAssertEqual(
                objc_getAssociatedObject(objCObject, SampleKey) as? SampleObjectiveCClass,
                association,
                "The Objective-C object should have an associated Objective-C object"
            )
            //  TODO: test atomicity

            weakReference = association
        }

        XCTAssertNotNil(weakReference, "The default policy should be non-atomic retain")

        objCObject.associate(objCStructAssociation, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        XCTAssertTrue(
            SampleObjectiveCStructuresEqual(
                objCObject.associationForKey(SampleKey) as! SampleObjectiveCStructure,
                objCStructAssociation
            ),
            "The default policy should be non-atomic retain"
        )
        //  TODO: test atomicity

        objCObject.associate(objCEnumAssociation, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        XCTAssertEqual(
            objc_getAssociatedObject(objCObject, SampleKey) as? SampleObjectiveCEnumeration,
            objCEnumAssociation,
            "The default policy should be non-atomic retain"
        )
        //  TODO: test atomicity
    }

    func testDefaultPolicyObjectiveCAssociationWithSwiftTypes() {
        autoreleasepool {
            let association = SampleSwiftClass(42)
            objCObject.associate(association, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            XCTAssertEqual(
                objCObject.associationForKey(SampleKey) as? SampleSwiftClass,
                association,
                "The Objective-C object should have an associated Swift object"
            )
            //  TODO: test atomicity

            weakReference = association
        }

        XCTAssertNotNil(weakReference, "The default policy should be non-atomic retain")

        objCObject.associate(swiftStructAssociation, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        XCTAssertEqual(
            objCObject.associationForKey(SampleKey) as? SampleSwiftStructure,
            swiftStructAssociation,
            "The default policy should be non-atomic retain"
        )
        //  TODO: test atomicity

        objCObject.associate(swiftEnumAssociation, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        XCTAssertEqual(
            objc_getAssociatedObject(objCObject, SampleKey) as? SampleSwiftEnumeration,
            swiftEnumAssociation,
            "The default policy should be non-atomic retain"
        )
        //  TODO: test atomicity
    }

    func testDefaultPolicySwiftAssociationWithObjectiveCTypes() {
        autoreleasepool {
            let association = SampleObjectiveCClass(42)
            swiftObject.associate(association, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            XCTAssertEqual(
                objc_getAssociatedObject(swiftObject, SampleKey) as? SampleObjectiveCClass,
                association,
                "The Swift object should have an associated Objective-C object"
            )
            //  TODO: test atomicity

            weakReference = association
        }

        XCTAssertNotNil(weakReference, "The default policy should be non-atomic retain")

        swiftObject.associate(objCStructAssociation, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        XCTAssertTrue(
            SampleObjectiveCStructuresEqual(
                swiftObject.associationForKey(SampleKey) as! SampleObjectiveCStructure,
                objCStructAssociation
            ),
            "The default policy should be non-atomic retain"
        )
        //  TODO: test atomicity

        swiftObject.associate(objCEnumAssociation, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        XCTAssertEqual(
            objc_getAssociatedObject(swiftObject, SampleKey) as? SampleObjectiveCEnumeration,
            objCEnumAssociation,
            "The default policy should be non-atomic retain"
        )
        //  TODO: test atomicity
    }

    func testDefaultPolicySwiftAssociationWithSwiftTypes() {
        autoreleasepool {
            let association = SampleSwiftClass(42)
            swiftObject.associate(association, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            XCTAssertEqual(
                swiftObject.associationForKey(SampleKey) as? SampleSwiftClass,
                association,
                "The Swift object should have an associated Swift object"
            )
            //  TODO: test atomicity

            weakReference = association
        }

        XCTAssertNotNil(weakReference, "The default policy should be non-atomic retain")

        swiftObject.associate(swiftStructAssociation, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        XCTAssertEqual(
            swiftObject.associationForKey(SampleKey) as? SampleSwiftStructure,
            swiftStructAssociation,
            "The default policy should be non-atomic retain"
        )
        //  TODO: test atomicity

        swiftObject.associate(swiftEnumAssociation, withKey: SampleKey, usingPolicy: .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        XCTAssertEqual(
            objc_getAssociatedObject(swiftObject, SampleKey) as? SampleSwiftEnumeration,
            swiftEnumAssociation,
            "The default policy should be non-atomic retain"
        )
        //  TODO: test atomicity
    }

}
