//
//  ObjectAssociationTestCase.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 2/7/15.
//  Copyright (c) 2015 Swagger Soft. All rights reserved.
//

import XCTest
import FoundationSwagger
import SampleTypes


fileprivate let SampleKeyString1 = NSUUID().uuidString.cString(using: .utf8)!
let SampleKey1 = ObjectAssociationKey(SampleKeyString1)

fileprivate let SampleKeyString2 = NSUUID().uuidString.cString(using: .utf8)!
let SampleKey2 = ObjectAssociationKey(SampleKeyString2)


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

    let association1: AssociationTestPair = (
        association: SampleObjectiveCClass(42),
        isEqual: { $0 as! SampleObjectiveCClass == $1 as! SampleObjectiveCClass }
    )
    let association2: AssociationTestPair = (
        association: SampleObjectiveCStructure(value: 14),
        isEqual: { SampleObjectiveCStructuresEqual($0 as! SampleObjectiveCStructure, $1 as! SampleObjectiveCStructure) }
    )
    let association3: AssociationTestPair = (
        association: SampleObjectiveCEnumerationAlpha,
        isEqual: { $0 as! SampleObjectiveCEnumeration == $1 as! SampleObjectiveCEnumeration }
    )
    let association4: AssociationTestPair = (
        association: SampleSwiftClass(42),
        isEqual: { $0 as! SampleSwiftClass == $1 as! SampleSwiftClass }
    )
    let association5: AssociationTestPair = (
        association: SampleSwiftStructure(value: 14),
        isEqual: { $0 as! SampleSwiftStructure == $1 as! SampleSwiftStructure }
    )
    let association6: AssociationTestPair = (
        association: SampleSwiftEnumeration.only(14),
        isEqual: { $0 as! SampleSwiftEnumeration == $1 as! SampleSwiftEnumeration }
    )


    var associations: [AssociationTestPair]!
    var nonObjectAssociations: [AssociationTestPair]!
    var objectAssociations: [InitializerTestPair] = [
        (
            create: { SampleObjectiveCClass(42) },
            isEqual: { $0 as! SampleObjectiveCClass == $1 as! SampleObjectiveCClass }
        ),
        (
            create: { SampleSwiftClass(42) },
            isEqual: { $0 as! SampleSwiftClass == $1 as! SampleSwiftClass }
        )
    ]

    weak var weakReference: AnyObject?

    override func setUp() {
        super.setUp()

        associations = [
            association1, association2, association3,
            association4, association5, association6
        ]

        nonObjectAssociations = [
            association2, association3,
            association5, association6
        ]

        assert(nonObjectAssociations.count == 4)
        assert(objectAssociations.count == 2)
        assert(associations.count == 6)
    }

}
