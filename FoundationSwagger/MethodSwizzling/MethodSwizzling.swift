//
//  MethodSwizzling.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 10/24/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//


public typealias NullaryVoidClosure = () -> Void


public extension MethodAssociation {

    public func useAlternateImplementation(_ trailingClosure: NullaryVoidClosure? = nil) {
        guard !isSwizzled else { return }

        swapImplementations()
    }

    public func useOriginalImplementation(_ trailingClosure: NullaryVoidClosure? = nil) {
        guard isSwizzled else { return }

        swapImplementations()
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
