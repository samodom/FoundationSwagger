//
//  UniqueKey.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 4/24/17.
//  Copyright © 2017 Swagger Soft. All rights reserved.
//

/// Function that provides unique content that can be used to create object association keys.
/// - returns: A C-string representing a universally unique identifier.
public func UUIDKeyString() -> [CChar] {
    return NSUUID().uuidString.cString(using: .utf8)!
}
