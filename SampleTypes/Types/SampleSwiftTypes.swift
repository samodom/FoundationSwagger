//
//  SwiftSwiftTypes.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 10/22/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

import FoundationSwagger


//  MARK: - Swift Structure

public struct SampleSwiftStructure: Equatable {
    public let value: Int

    public init(value: Int) {
        self.value = value
    }
}

public func ==(lhs: SampleSwiftStructure, rhs: SampleSwiftStructure) -> Bool {
    return lhs.value == rhs.value
}


//  MARK: - Swift Enumeration

public enum SampleSwiftEnumeration: Equatable {
    case only(Int)
}

public func ==(lhs: SampleSwiftEnumeration, rhs: SampleSwiftEnumeration) -> Bool {
    switch (lhs, rhs) {
    case (.only(let leftValue), .only(let rightValue)):
        return leftValue == rightValue
    }
}


//  MARK: - Swift Class

public class SampleSwiftClass: Equatable, NSCopying, ObjectAssociating, SampleType {

    public let value: Int

    public class func className() -> String {
        return NSStringFromClass(SampleSwiftClass.self)
    }


    //  MARK: - Lifecycle

    public init() {
        value = 0
    }

    public init(_ value: Int) {
        self.value = value
    }

    @objc public func copy() -> AnyObject {
        return self.copy(with: nil) as AnyObject
    }

    @objc public func copy(with zone: NSZone?) -> Any {
        return SampleSwiftClass(value)
    }


    //  MARK: - Sample methods

    @objc public class func sampleClassMethod() -> Int {
        return OriginalMethodReturnValue
    }

    @objc public class func otherClassMethod() -> Int {
        return AlternateMethodReturnValue
    }

    @objc public func sampleInstanceMethod() -> Int {
        return OriginalMethodReturnValue
    }

    @objc public func otherInstanceMethod() -> Int {
        return AlternateMethodReturnValue
    }

}

public func ==(lhs: SampleSwiftClass, rhs: SampleSwiftClass) -> Bool {
    return lhs.value == rhs.value
}
