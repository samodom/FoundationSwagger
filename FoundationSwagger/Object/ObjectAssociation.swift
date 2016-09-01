//
//  ObjectAssociation.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 2/7/15.
//  Copyright (c) 2015 Swagger Soft. All rights reserved.
//

import Foundation

/**
    Common protocol for object association with pure Swift classes or `NSObject` (and its subclasses).
*/
public protocol ObjectAssociable: class {

    /**
        The implementation of this method should use the Foundation function `objc_setAssociatedObject` to create an association between the implementing and provided objects using the specified key and policy.
        @param      key The identifying key to use for the association.
        @param      withObject The object to associate with `self`.
        @param      policy The association policy to use for the association.
    */
    func associate(key: UnsafePointer<Void>, withObject: AnyObject, policy: objc_AssociationPolicy)

    /**
        The implementation of this method should use the Foundation function `objc_getAssociatedObject` to retrieve any object associated with `self` using the specified key, if any.
        @param      key The key identifying the association to retrieve.
        @return     The object associated with `self` using the specified key, if such an association exist.
    */
    func association(forKey key: UnsafePointer<Void>) -> AnyObject?

    /**
        The implementation of this method should use the Foundation function `objc_setAssociatedObject` to clear an association for the specified key.
        @param      key The key identifying the association to clear.
    */
    func clearAssociation(forKey key: UnsafePointer<Void>)

    /**
        The implementation of this method should use the Foundation function `objc_removeAssociatedObjects` to clear all object associations on `self`.
    */
    func clearAllAssociations()

}


/**
    Conformance to `ObjectAssociable` for `NSObject`.
*/
extension NSObject: ObjectAssociable {

    public func associate(key: UnsafePointer<Void>, withObject association: AnyObject, policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_ASSIGN) {
        objc_setAssociatedObject(self, key, association, policy)
    }

    public func association(forKey key: UnsafePointer<Void>) -> AnyObject? {
        return objc_getAssociatedObject(self, key)
    }

    public func clearAssociation(forKey key: UnsafePointer<Void>) {
        objc_setAssociatedObject(self, key, nil, .OBJC_ASSOCIATION_ASSIGN)
    }

    public func clearAllAssociations() {
        objc_removeAssociatedObjects(self)
    }

}

