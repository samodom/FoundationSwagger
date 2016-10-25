//
//  MethodAssociation.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 10/24/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

import Foundation

public struct MethodAssociation {

    public enum MethodType {
        case `class`, instance
    }

    public let owningClass: AnyClass
    public let methodType: MethodType
    public let originalSelector: Selector
    public let alternateSelector: Selector

    public init(
        forClass `class`: AnyClass,
        ofType type: MethodType,
        originalSelector: Selector,
        alternateSelector: Selector
        ) {

        owningClass = `class`
        methodType = type
        self.originalSelector = originalSelector
        self.alternateSelector = alternateSelector
    }
}
