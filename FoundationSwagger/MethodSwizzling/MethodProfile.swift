//
//  MethodProfile.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 10/23/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

internal protocol MethodProfile {
    var `class`: AnyClass { get }
    var selector: Selector { get }
    var method: Method { get }
    var implementation: IMP { get }
}


internal struct ClassMethodProfile: MethodProfile {

    let `class`: AnyClass
    let selector: Selector
    let method: Method
    let implementation: IMP

    internal init(class: AnyClass, selector: Selector) {
        self.class = `class`
        self.selector = selector

        method = class_getClassMethod(`class`, selector)
        implementation = method_getImplementation(method)
    }

}


internal struct InstanceMethodProfile: MethodProfile {

    let `class`: AnyClass
    let selector: Selector
    let method: Method
    let implementation: IMP

    internal init(class: AnyClass, selector: Selector) {
        self.class = `class`
        self.selector = selector

        method = class_getInstanceMethod(`class`, selector)
        implementation = method_getImplementation(method)
    }
    
}
