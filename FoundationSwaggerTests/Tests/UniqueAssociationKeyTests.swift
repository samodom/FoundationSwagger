//
//  UniqueAssociationKeyTests.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 4/24/17.
//  Copyright © 2017 Swagger Soft. All rights reserved.
//

import XCTest
import FoundationSwagger

class UniqueAssociationKeyTests: XCTestCase {

    func testUUIDKeyStringKeyUniqueness() {
        let stringKeys = (1...100).map { _ in
            UUIDKeyString()
        }

        let keyPointers = stringKeys.map { ObjectAssociationKey($0) }
        let uniquePointers = Set(keyPointers)

        XCTAssertEqual(uniquePointers.count, keyPointers.count, "Each pointer should be unique")
    }

}
