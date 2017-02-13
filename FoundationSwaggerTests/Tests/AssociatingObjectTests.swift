//
//  AssociatingObjectTests.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 2/7/15.
//  Copyright (c) 2015 Swagger Soft. All rights reserved.
//

import XCTest
import FoundationSwagger
import SampleTypes


class AssociatingObjectTests: ObjectAssociationTestCase {

    let associatingObjects: [AssociatingObject] = [
        SampleObjectiveCClass(14),
        SampleSwiftClass(14)
    ]

    override func setUp() {
        super.setUp()

        assert(associatingObjects.count == 2)
    }

    override func tearDown() {
        associatingObjects.forEach(objc_removeAssociatedObjects)

        super.tearDown()
    }

}


//  MARK: - Retrieving associations

extension AssociatingObjectTests {

    func testRetrievingAssociations() {
        associatingObjects.forEach { object in
            associations.forEach { (association, isEqual) in
                objc_setAssociatedObject(object, SampleKey1, association, .OBJC_ASSOCIATION_RETAIN)
                XCTAssertTrue(isEqual(object.association(for: SampleKey1)!, association),
                               "The associated object should be retrieved with its key")
                objc_removeAssociatedObjects(object)
            }
        }
    }

    func testSettingWithDefaultPolicy() {
        associatingObjects.forEach { object in
            objectAssociations.forEach { (create, isEqual) in
                autoreleasepool {
                    let association = create()
                    object.associate(association, with: SampleKey1)
                    XCTAssertTrue(isEqual(objc_getAssociatedObject(object, SampleKey1), association),
                                  "The associating object should have an associated object")

                    //  TODO: test atomicity

                    weakReference = association as AnyObject
                }

                XCTAssertNotNil(weakReference, "The association should be retained")
                objc_removeAssociatedObjects(object)
            }


            nonObjectAssociations.forEach { (association, isEqual) in
                object.associate(association, with: SampleKey1)
                XCTAssertTrue(isEqual(objc_getAssociatedObject(object, SampleKey1), association),
                              "The associating object should have an associated value")

                //  TODO: test atomicity

                objc_removeAssociatedObjects(object)
            }
        }
    }

    func testSettingWithAssignPolicy() {
        associatingObjects.forEach { object in
            objectAssociations.forEach { (create, isEqual) in
                autoreleasepool {
                    let association = create()
                    object.associate(association, with: SampleKey1, usingPolicy: .OBJC_ASSOCIATION_ASSIGN)
                    XCTAssertTrue(isEqual(objc_getAssociatedObject(object, SampleKey1), association),
                                          "The associating object should have an associated object")

                    weakReference = association as AnyObject
                }

                XCTAssertNil(weakReference, "The association should be made with pointer assignment")
                objc_removeAssociatedObjects(object)
            }

        }
    }


    func testSettingWithAtomicRetainPolicy() {
        associatingObjects.forEach { object in
            objectAssociations.forEach { (create, isEqual) in
                autoreleasepool {
                    let association = create()
                    object.associate(association, with: SampleKey1, usingPolicy: .OBJC_ASSOCIATION_RETAIN)
                    XCTAssertTrue(isEqual(objc_getAssociatedObject(object, SampleKey1), association),
                                  "The associating object should have an associated object")

                    //  TODO: test atomicity

                    weakReference = association as AnyObject
                }

                XCTAssertNotNil(weakReference, "The association should be retained")
                objc_removeAssociatedObjects(object)
            }


            nonObjectAssociations.forEach { (association, isEqual) in
                object.associate(association, with: SampleKey1, usingPolicy: .OBJC_ASSOCIATION_RETAIN)
                XCTAssertTrue(isEqual(objc_getAssociatedObject(object, SampleKey1), association),
                              "The associating object should have an associated value")

                //  TODO: test atomicity

                objc_removeAssociatedObjects(object)
            }
        }
    }

    func testSettingWithNonatomicRetainPolicy() {
        associatingObjects.forEach { object in
            objectAssociations.forEach { (create, isEqual) in
                autoreleasepool {
                    let association = create()
                    object.associate(association, with: SampleKey1, usingPolicy: .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                    XCTAssertTrue(isEqual(objc_getAssociatedObject(object, SampleKey1), association),
                                  "The associating object should have an associated object")

                    //  TODO: test atomicity

                    weakReference = association as AnyObject
                }

                XCTAssertNotNil(weakReference, "The association should be retained")
                objc_removeAssociatedObjects(object)
            }


            nonObjectAssociations.forEach { (association, isEqual) in
                object.associate(association, with: SampleKey1, usingPolicy: .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                XCTAssertTrue(isEqual(objc_getAssociatedObject(object, SampleKey1), association),
                              "The associating object should have an associated value")

                //  TODO: test atomicity

                objc_removeAssociatedObjects(object)
            }
        }
    }

    func testSettingWithAtomicCopyPolicy() {
        associatingObjects.forEach { object in
            objectAssociations.forEach { (create, isEqual) in
                let association = create()
                object.associate(association, with: SampleKey1, usingPolicy: .OBJC_ASSOCIATION_COPY)

                let reference = objc_getAssociatedObject(object, SampleKey1)!
                XCTAssertTrue(isEqual(reference, association),
                               "The associating object should have an associated object")
                XCTAssertTrue(reference as AnyObject !== association as AnyObject,
                              "The association should be made with a copy of the original object")

                //  TODO: test atomicity

                objc_removeAssociatedObjects(object)
            }

            nonObjectAssociations.forEach { (association, isEqual) in
                object.associate(association, with: SampleKey1, usingPolicy: .OBJC_ASSOCIATION_COPY)
                XCTAssertTrue(isEqual(objc_getAssociatedObject(object, SampleKey1), association),
                              "The associating object should have an associated value")

                //  TODO: test atomicity

                objc_removeAssociatedObjects(object)
            }
        }
    }

    func testSettingWithNonatomicCopyPolicy() {
        associatingObjects.forEach { object in
            objectAssociations.forEach { (create, isEqual) in
                let association = create()
                object.associate(association, with: SampleKey1, usingPolicy: .OBJC_ASSOCIATION_COPY_NONATOMIC)

                let reference = objc_getAssociatedObject(object, SampleKey1)!
                XCTAssertTrue(isEqual(reference, association),
                              "The associating object should have an associated object")
                XCTAssertTrue(reference as AnyObject !== association as AnyObject,
                              "The association should be made with a copy of the original object")

                //  TODO: test atomicity

                objc_removeAssociatedObjects(object)
            }

            nonObjectAssociations.forEach { (association, isEqual) in
                object.associate(association, with: SampleKey1, usingPolicy: .OBJC_ASSOCIATION_COPY_NONATOMIC)
                XCTAssertTrue(isEqual(objc_getAssociatedObject(object, SampleKey1), association),
                              "The associating object should have an associated value")

                //  TODO: test atomicity

                objc_removeAssociatedObjects(object)
            }
        }
    }

    func testRemovingSingleAssociations() {
        associatingObjects.forEach { object in
            objc_setAssociatedObject(object, SampleKey2, 42, .OBJC_ASSOCIATION_RETAIN)

            associations.forEach { (association, isEqual) in
                objc_setAssociatedObject(object, SampleKey1, association, .OBJC_ASSOCIATION_RETAIN)
                object.removeAssociation(for: SampleKey1)
                XCTAssertNil(objc_getAssociatedObject(object, SampleKey1),
                             "The specified association should be removed")
                XCTAssertNotNil(objc_getAssociatedObject(object, SampleKey2),
                                "Other associations should not be removed")
            }

            objc_removeAssociatedObjects(object)
        }
    }

    func testRemovingAllAssociations() {
        associatingObjects.forEach { object in
            objc_setAssociatedObject(object, SampleKey1, 14, .OBJC_ASSOCIATION_RETAIN)
            objc_setAssociatedObject(object, SampleKey2, 42, .OBJC_ASSOCIATION_RETAIN)

            object.removeAllAssociations()
            XCTAssertNil(objc_getAssociatedObject(object, SampleKey1),
                         "All associations should be cleared")
            XCTAssertNil(objc_getAssociatedObject(object, SampleKey2),
                         "All associations should be cleared")

            objc_removeAssociatedObjects(object)
        }
    }

}
