//
//  SwiftSwiftTypes.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 10/22/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

import Foundation
import FoundationSwagger


//  MARK: - Swift Structure

internal struct SampleSwiftStructure: Equatable {
    let value: Int
}

internal func ==(lhs: SampleSwiftStructure, rhs: SampleSwiftStructure) -> Bool {
    return lhs.value == rhs.value
}


//  MARK: - Swift Enumeration

internal enum SampleSwiftEnumeration: Equatable {
    case only(Int)
}

internal func ==(lhs: SampleSwiftEnumeration, rhs: SampleSwiftEnumeration) -> Bool {
    switch (lhs, rhs) {
    case (.only(let leftValue), .only(let rightValue)):
        return leftValue == rightValue
    }
}


//  MARK: - Swift Class

internal class SampleSwiftClass: Equatable, NSCopying, ObjectAssociating {

    internal let value: Int

    internal init(_ value: Int) {
        self.value = value
    }

    @objc internal func copy() -> AnyObject {
        return self.copy(with: nil) as AnyObject
    }

    @objc internal func copy(with zone: NSZone?) -> Any {
        return SampleSwiftClass(value)
    }

    @objc internal func sampleInstanceMethod(_ input: String) -> Int {
        return 14
    }

    @objc internal class func sampleClassMethod(_ input: String) -> Int {
        return 14
    }

}

internal func ==(lhs: SampleSwiftClass, rhs: SampleSwiftClass) -> Bool {
    return lhs.value == rhs.value
}
