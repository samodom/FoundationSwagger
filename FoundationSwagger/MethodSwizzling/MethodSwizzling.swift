//
//  MethodSwizzling.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 10/24/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//


public typealias NullaryVoidClosure = () -> Void


public extension MethodAssociation {

    /// Swizzles the original and alternate methods of the association so that the
    /// alternate method is used when the original selector is called.
    /// - parameter context: Closure to execute while the alternate method implementation is being used.
    public func useAlternateImplementation(context: NullaryVoidClosure? = nil) {
        guard !isSwizzled else { return }

        swapImplementations()
        context?()
    }

    /// Swizzles the original and alternate methods of the association so that the
    /// original method is used when the original selector is called.
    /// - parameter context: Closure to execute while the original method implementation is being used.
    public func useOriginalImplementation(context: NullaryVoidClosure? = nil) {
        guard isSwizzled else { return }

        swapImplementations()
        context?()
    }

    private func swapImplementations() {
        method_exchangeImplementations(
            methodForSelector(originalSelector),
            methodForSelector(alternateSelector)
        )

        isSwizzled = !isSwizzled
    }

    private func methodForSelector(_ selector: Selector) -> Method {
        switch methodType {
        case .class:
            return class_getClassMethod(owningClass, selector)

        case .instance:
            return class_getInstanceMethod(owningClass, selector)
        }
    }

}
