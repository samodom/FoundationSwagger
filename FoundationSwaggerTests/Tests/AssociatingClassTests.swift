//
//  AssociatingClassTests.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 2/7/15.
//  Copyright (c) 2015 Swagger Soft. All rights reserved.
//

import XCTest
import FoundationSwagger


class AssociatingClassTests: ObjectAssociationTestCase {

    let associatingClasses: [AssociatingClass.Type] = [
        SampleObjectiveCClass.self,
        SampleSwiftClass.self
    ]

    override func setUp() {
        super.setUp()

        assert(associatingClasses.count == 2)
    }

    override func tearDown() {
        associatingClasses.forEach(objc_removeAssociatedObjects)

        super.tearDown()
    }

}


extension AssociatingClassTests {

    func testRetrievingAssociations() {
        associatingClasses.forEach { `class` in
            associations.forEach { (association, isEqual) in
                objc_setAssociatedObject(`class`, SampleKey1, association, .OBJC_ASSOCIATION_RETAIN)
                XCTAssertTrue(isEqual(`class`.association(for: SampleKey1)!, association),
                               "The associated object should be retrieved with its key")
                objc_removeAssociatedObjects(`class`)
            }
        }
    }

    func testSettingWithDefaultPolicy() {
        associatingClasses.forEach { `class` in
            objectAssociations.forEach { (create, isEqual) in
                autoreleasepool {
                    let association = create()
                    `class`.associate(association, with: SampleKey1)
                    XCTAssertTrue(isEqual(objc_getAssociatedObject(`class`, SampleKey1), association),
                                  "The associating object should have an associated object")

                    //  TODO: test atomicity

                    weakReference = association as AnyObject
                }

                XCTAssertNotNil(weakReference, "The association should be retained")
                objc_removeAssociatedObjects(`class`)
            }


            nonObjectAssociations.forEach { (association, isEqual) in
                `class`.associate(association, with: SampleKey1)
                XCTAssertTrue(isEqual(objc_getAssociatedObject(`class`, SampleKey1), association),
                              "The associating object should have an associated value")

                //  TODO: test atomicity

                objc_removeAssociatedObjects(`class`)
            }
        }
    }

    func testSettingWithAssignPolicy() {
        associatingClasses.forEach { `class` in
            objectAssociations.forEach { (create, isEqual) in
                autoreleasepool {
                    let association = create()
                    `class`.associate(association, with: SampleKey1, usingPolicy: .OBJC_ASSOCIATION_ASSIGN)
                    XCTAssertTrue(isEqual(objc_getAssociatedObject(`class`, SampleKey1), association),
                                          "The associating object should have an associated object")

                    weakReference = association as AnyObject
                }

                XCTAssertNil(weakReference, "The association should be made with pointer assignment")
                objc_removeAssociatedObjects(`class`)
            }

        }
    }


    func testSettingWithAtomicRetainPolicy() {
        associatingClasses.forEach { `class` in
            objectAssociations.forEach { (create, isEqual) in
                autoreleasepool {
                    let association = create()
                    `class`.associate(association, with: SampleKey1, usingPolicy: .OBJC_ASSOCIATION_RETAIN)
                    XCTAssertTrue(isEqual(objc_getAssociatedObject(`class`, SampleKey1), association),
                                  "The associating object should have an associated object")

                    //  TODO: test atomicity

                    weakReference = association as AnyObject
                }

                XCTAssertNotNil(weakReference, "The association should be retained")
                objc_removeAssociatedObjects(`class`)
            }


            nonObjectAssociations.forEach { (association, isEqual) in
                `class`.associate(association, with: SampleKey1, usingPolicy: .OBJC_ASSOCIATION_RETAIN)
                XCTAssertTrue(isEqual(objc_getAssociatedObject(`class`, SampleKey1), association),
                              "The associating object should have an associated value")

                //  TODO: test atomicity

                objc_removeAssociatedObjects(`class`)
            }
        }
    }

    func testSettingWithNonatomicRetainPolicy() {
        associatingClasses.forEach { `class` in
            objectAssociations.forEach { (create, isEqual) in
                autoreleasepool {
                    let association = create()
                    `class`.associate(association, with: SampleKey1, usingPolicy: .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                    XCTAssertTrue(isEqual(objc_getAssociatedObject(`class`, SampleKey1), association),
                                  "The associating object should have an associated object")

                    //  TODO: test atomicity

                    weakReference = association as AnyObject
                }

                XCTAssertNotNil(weakReference, "The association should be retained")
                objc_removeAssociatedObjects(`class`)
            }


            nonObjectAssociations.forEach { (association, isEqual) in
                `class`.associate(association, with: SampleKey1, usingPolicy: .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                XCTAssertTrue(isEqual(objc_getAssociatedObject(`class`, SampleKey1), association),
                              "The associating object should have an associated value")

                //  TODO: test atomicity

                objc_removeAssociatedObjects(`class`)
            }
        }
    }

    func testSettingWithAtomicCopyPolicy() {
        associatingClasses.forEach { `class` in
            objectAssociations.forEach { (create, isEqual) in
                let association = create()
                `class`.associate(association, with: SampleKey1, usingPolicy: .OBJC_ASSOCIATION_COPY)

                let reference = objc_getAssociatedObject(`class`, SampleKey1)!
                XCTAssertTrue(isEqual(reference, association),
                               "The associating object should have an associated object")
                XCTAssertTrue(reference as AnyObject !== association as AnyObject,
                              "The association should be made with a copy of the original object")

                //  TODO: test atomicity

                objc_removeAssociatedObjects(`class`)
            }

            nonObjectAssociations.forEach { (association, isEqual) in
                `class`.associate(association, with: SampleKey1, usingPolicy: .OBJC_ASSOCIATION_COPY)
                XCTAssertTrue(isEqual(objc_getAssociatedObject(`class`, SampleKey1), association),
                              "The associating object should have an associated value")

                //  TODO: test atomicity

                objc_removeAssociatedObjects(`class`)
            }
        }
    }

    func testSettingWithNonatomicCopyPolicy() {
        associatingClasses.forEach { `class` in
            objectAssociations.forEach { (create, isEqual) in
                let association = create()
                `class`.associate(association, with: SampleKey1, usingPolicy: .OBJC_ASSOCIATION_COPY_NONATOMIC)

                let reference = objc_getAssociatedObject(`class`, SampleKey1)!
                XCTAssertTrue(isEqual(reference, association),
                              "The associating object should have an associated object")
                XCTAssertTrue(reference as AnyObject !== association as AnyObject,
                              "The association should be made with a copy of the original object")

                //  TODO: test atomicity

                objc_removeAssociatedObjects(`class`)
            }

            nonObjectAssociations.forEach { (association, isEqual) in
                `class`.associate(association, with: SampleKey1, usingPolicy: .OBJC_ASSOCIATION_COPY_NONATOMIC)
                XCTAssertTrue(isEqual(objc_getAssociatedObject(`class`, SampleKey1), association),
                              "The associating object should have an associated value")

                //  TODO: test atomicity

                objc_removeAssociatedObjects(`class`)
            }
        }
    }

    func testRemovingSingleAssociations() {
        associatingClasses.forEach { `class` in
            objc_setAssociatedObject(`class`, SampleKey2, 42, .OBJC_ASSOCIATION_RETAIN)

            associations.forEach { (association, isEqual) in
                objc_setAssociatedObject(`class`, SampleKey1, association, .OBJC_ASSOCIATION_RETAIN)
                `class`.removeAssociation(for: SampleKey1)
                XCTAssertNil(objc_getAssociatedObject(`class`, SampleKey1),
                             "The specified association should be removed")
                XCTAssertNotNil(objc_getAssociatedObject(`class`, SampleKey2),
                                "Other associations should not be removed")
            }

            objc_removeAssociatedObjects(`class`)
        }
    }

    func testRemovingAllAssociations() {
        associatingClasses.forEach { `class` in
            objc_setAssociatedObject(`class`, SampleKey1, 14, .OBJC_ASSOCIATION_RETAIN)
            objc_setAssociatedObject(`class`, SampleKey2, 42, .OBJC_ASSOCIATION_RETAIN)

            `class`.removeAllAssociations()
            XCTAssertNil(objc_getAssociatedObject(`class`, SampleKey1),
                         "All associations should be cleared")
            XCTAssertNil(objc_getAssociatedObject(`class`, SampleKey2),
                         "All associations should be cleared")

            objc_removeAssociatedObjects(`class`)
        }
    }

}
