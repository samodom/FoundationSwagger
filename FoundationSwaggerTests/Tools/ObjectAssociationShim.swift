//
//  ObjectAssociationShim.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 2/12/15.
//  Copyright (c) 2015 Swagger Soft. All rights reserved.
//

import Foundation

internal var lastAssociatedObject: AnyObject?
internal var lastAssociationPolicy: ObjectAssociationPolicy?

internal var removeAssociatedObjectsCalled = false
internal var removeAssociatedObjectsObject: AnyObject?

internal func objc_setAssociatedObject(object: AnyObject!, key: UnsafePointer<Void>, value: AnyObject!, policy: objc_AssociationPolicy) {
    lastAssociatedObject = value
    lastAssociationPolicy = ObjectAssociationPolicy(rawValue: policy)
    Foundation.objc_setAssociatedObject(object, key, value, policy)
}

internal func objc_removeAssociatedObjects(object: AnyObject!) {
    removeAssociatedObjectsCalled = true
    removeAssociatedObjectsObject = object
    Foundation.objc_removeAssociatedObjects(object)
}
