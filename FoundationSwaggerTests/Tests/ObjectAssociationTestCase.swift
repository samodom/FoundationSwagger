//
//  ObjectAssociationTestCase.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 2/7/15.
//  Copyright (c) 2015 Swagger Soft. All rights reserved.
//

import XCTest
import SampleTypes


typealias AnyIsEqual = (Any, Any) -> Bool

typealias AssociationTestPair = (
    association: Any,
    isEqual: AnyIsEqual
)

typealias InitializerTestPair = (
    create: () -> Any,
    isEqual: AnyIsEqual
)


class ObjectAssociationTestCase: XCTestCase {

    let objectiveCObjectAssociation: AssociationTestPair = (
        association: SampleObjectiveCClass(),
        isEqual: { $0 as! SampleObjectiveCClass == $1 as! SampleObjectiveCClass }
    )
    let objectiveCStructAssociation: AssociationTestPair = (
        association: SampleObjectiveCStructure(value: 14),
        isEqual: { SampleObjectiveCStructuresEqual($0 as! SampleObjectiveCStructure, $1 as! SampleObjectiveCStructure) }
    )
    let objectiveCEnumAssociation: AssociationTestPair = (
        association: SampleObjectiveCEnumerationAlpha,
        isEqual: { $0 as! SampleObjectiveCEnumeration == $1 as! SampleObjectiveCEnumeration }
    )
    let swiftObjectAssociation: AssociationTestPair = (
        association: SampleSwiftClass(),
        isEqual: { $0 as! SampleSwiftClass == $1 as! SampleSwiftClass }
    )
    let swiftStructAssociation: AssociationTestPair = (
        association: SampleSwiftStructure(value: 14),
        isEqual: { $0 as! SampleSwiftStructure == $1 as! SampleSwiftStructure }
    )
    let swiftEnumAssociation: AssociationTestPair = (
        association: SampleSwiftEnumeration.only(14),
        isEqual: { $0 as! SampleSwiftEnumeration == $1 as! SampleSwiftEnumeration }
    )


    var associations: [AssociationTestPair]!
    var nonObjectAssociations: [AssociationTestPair]!

    var objectAssociations: [InitializerTestPair] = [
        (create: { SampleObjectiveCClass() },
         isEqual: { $0 as! SampleObjectiveCClass == $1 as! SampleObjectiveCClass } ),
        (create: { SampleSwiftClass() },
         isEqual: { $0 as! SampleSwiftClass == $1 as! SampleSwiftClass } )
    ]

    weak var weakReference: AnyObject?


    override func setUp() {
        super.setUp()

        associations = [
            objectiveCObjectAssociation, objectiveCStructAssociation, objectiveCEnumAssociation,
            swiftObjectAssociation, swiftStructAssociation, swiftEnumAssociation
        ]

        nonObjectAssociations = [
            objectiveCStructAssociation, objectiveCEnumAssociation,
            swiftStructAssociation, swiftEnumAssociation
        ]
    }

}
