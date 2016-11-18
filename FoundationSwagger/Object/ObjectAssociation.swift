 //
//  ObjectAssociation.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 2/7/15.
//  Copyright (c) 2015 Swagger Soft. All rights reserved.
//

import Foundation

/// Common protocol for object association with pure Swift classes or `NSObject` (and its subclasses).
public protocol ObjectAssociating: class {}

extension ObjectAssociating {

    /// Creates an association between the implementing and provided objects using the specified key and policy.
    /// - parameter value: The object or value to associate with `self`.
    /// - parameter key: The identifying key to use for the association.
    /// - parameter policy: The association policy to use for the association.
    public func associate(
        _ value: Any,
        withKey key: UnsafeRawPointer,
        usingPolicy policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN
        ) {

        objc_setAssociatedObject(self, key, value, policy)
    }


    /// Retrieves the object associated with `self` using the specified key, if any.
    /// - parameter key: The key identifying the association to retrieve.
    /// - returns: The object or value associated with `self` using the specified key, if such an association exist.
    public func associationForKey(_ key: UnsafeRawPointer) -> Any? {
        return objc_getAssociatedObject(self, key)
    }


    /// Clears an object association for the specified key.
    /// - parameter key: The key identifying the association to clear.
    public func removeAssociationForKey(_ key: UnsafeRawPointer) {
        objc_setAssociatedObject(self, key, nil, .OBJC_ASSOCIATION_ASSIGN)
    }


    /// Clears all object associations on `self`.
    public func removeAllAssociations() {
        objc_removeAssociatedObjects(self)
    }

}

/// Makes all Objective-C objects object associating
extension NSObject: ObjectAssociating {}
