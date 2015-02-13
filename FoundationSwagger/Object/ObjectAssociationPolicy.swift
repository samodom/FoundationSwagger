//
//  ObjectAssociationPolicy.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 2/8/15.
//  Copyright (c) 2015 Swagger Soft. All rights reserved.
//

import Foundation

/**
    Convenience enumeration for object association policies.
*/
public enum ObjectAssociationPolicy: UInt {
    case Assign
    case AtomicRetain
    case NonatomicRetain
    case AtomicCopy
    case NonatomicCopy

    public init?(rawValue: UInt) {
        switch rawValue {
        case UInt(OBJC_ASSOCIATION_ASSIGN):
            self = .Assign

        case UInt(OBJC_ASSOCIATION_RETAIN):
            self = .AtomicRetain

        case UInt(OBJC_ASSOCIATION_RETAIN_NONATOMIC):
            self = .NonatomicRetain

        case UInt(OBJC_ASSOCIATION_COPY):
            self = .AtomicCopy

        case UInt(OBJC_ASSOCIATION_COPY_NONATOMIC):
            self = .NonatomicCopy

        default:
            return nil
        }
    }

    public var rawValue: UInt {
        switch self {
        case .Assign:
            return UInt(OBJC_ASSOCIATION_ASSIGN)

        case .AtomicRetain:
            return UInt(OBJC_ASSOCIATION_RETAIN)

        case .NonatomicRetain:
            return UInt(OBJC_ASSOCIATION_RETAIN_NONATOMIC)

        case .AtomicCopy:
            return UInt(OBJC_ASSOCIATION_COPY)

        case .NonatomicCopy:
            return UInt(OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }

}
