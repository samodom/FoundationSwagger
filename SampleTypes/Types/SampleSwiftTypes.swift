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

public class SampleSwiftClass: Equatable, NSCopying, AssociatingObject, AssociatingClass, SampleType {

    private final var _instanceProperty = OriginalPropertyValue
    dynamic public var instanceProperty: String {
        get {
            return _instanceProperty
        }
        set {
            _instanceProperty = newValue
        }
    }

    private static var _classProperty = OriginalPropertyValue
    dynamic public class var classProperty: String {
        get {
            return _classProperty
        }
        set {
            _classProperty = newValue
        }
    }

    public class func className() -> String {
        return NSStringFromClass(SampleSwiftClass.self)
    }


    //  MARK: - Lifecycle

    public init() {
        instanceProperty = OriginalPropertyValue
    }

    @objc public func copy() -> AnyObject {
        return self.copy(with: nil) as AnyObject
    }

    @objc public func copy(with zone: NSZone?) -> Any {
        let new = SampleSwiftClass()
        new.instanceProperty = instanceProperty
        return new
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


    //  MARK: - Property alternates

    dynamic public class func otherClassPropertyGetter() -> String {
        return AlternatePropertyValue
    }

    dynamic public class func otherClassPropertySetter(_ newValue: String) {
        _classProperty = newValue + newValue
    }

    dynamic public func otherInstancePropertyGetter() -> String {
        return AlternatePropertyValue
    }

    dynamic public func otherInstancePropertySetter(_ newValue: String) {
        _instanceProperty = newValue + newValue
    }

}


public func ==(lhs: SampleSwiftClass, rhs: SampleSwiftClass) -> Bool {
    return lhs.instanceProperty == rhs.instanceProperty
}
