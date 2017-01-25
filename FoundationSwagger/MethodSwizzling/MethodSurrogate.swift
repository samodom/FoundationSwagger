//
//  MethodSurrogate.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 10/24/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

import Foundation

/// Enumerated type representing the two basic types of methods that a class can define.
public enum MethodType {
    case `class`, instance
}


/// An association of two swappable (swizzlable) methods of a class
public class MethodSurrogate {

    /// The class implementing the class or instance methods designated
    /// by the original and alternate selectors.
    public let owningClass: AnyClass


    /// They type of methods designated by the original and alternate selectors.
    public let methodType: MethodType


    /// The original selector whose implementation is replaced by the implementation
    /// of the method desginated by the alternate selector.
    public let originalSelector: Selector


    /// The alternate selector whose implementation is replaced by the implementation
    /// of the method desginated by the original selector.
    public let alternateSelector: Selector


    /// Creates a method surrogate for the provided class and methods
    /// - parameter forClass: The class implementing both the original and alternate methods.
    /// - parameter ofType: The type of method: class or instance.
    /// - parameter originalSelector: The selector designating the original method to replace.
    /// - parameter alternateSelector: The selector designating the alternate method to use.
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


    var isSwizzled = false

}
