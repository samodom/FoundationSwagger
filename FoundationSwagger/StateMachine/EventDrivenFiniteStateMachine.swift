//
//  EventDrivenFiniteStateMachine.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 1/18/15.
//  Copyright (c) 2015 Swagger Soft. All rights reserved.
//

import Foundation

public protocol EventDrivenFiniteStateMachine {

    typealias StateType
    typealias EventType

    var currentState: StateType { get }
    init(initialState: StateType)
    func handleEvent(event: EventType)

}
