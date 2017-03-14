//
//  MethodSwizzling.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 10/24/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//


/// Well-known name for an empty-input function that doesn't return anything
public typealias NullaryVoidClosure = () -> Void


public extension MethodSurrogate {

    /// Swizzles the original and alternate methods of the surrogate so that the
    /// alternate method is used when the original selector is called.
    public func useAlternateImplementation() {
        guard !isSwizzled else { return }
        swapImplementations()
    }


    /// Swizzles the original and alternate methods of the surrogate so that the
    /// alternate method is used when the original selector is called.
    /// - parameter context: Closure to execute while the alternate method implementation is being used.
    public func withAlternateImplementation(context: NullaryVoidClosure) {
        guard !isSwizzled else { return }
        useAlternateImplementation()
        context()
        useOriginalImplementation()
    }


    /// Swizzles the original and alternate methods of the surrogate so that the
    /// original method is used when the original selector is called.
    public func useOriginalImplementation() {
        guard isSwizzled else { return }
        swapImplementations()
    }


    /// Swizzles the original and alternate methods of the surrogate so that the
    /// original method is used when the original selector is called.
    /// - parameter context: Closure to execute while the original method implementation is being used.
    public func withOriginalImplementation(context: NullaryVoidClosure) {
        guard isSwizzled else { return }
        useOriginalImplementation()
        context()
        useAlternateImplementation()
    }

}


fileprivate extension MethodSurrogate {

    func swapImplementations() {
        method_exchangeImplementations(
            methodForSelector(originalSelector),
            methodForSelector(alternateSelector)
        )

        isSwizzled = !isSwizzled
    }

    func methodForSelector(_ selector: Selector) -> Method {
        switch methodType {
        case .class:
            return class_getClassMethod(owningClass, selector)

        case .instance:
            return class_getInstanceMethod(owningClass, selector)
        }
    }

}
