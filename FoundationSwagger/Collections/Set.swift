//
//  Set.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 9/23/14.
//  Copyright (c) 2014 Swagger Soft. All rights reserved.
//

import Foundation

public struct Set<T: Hashable>: SequenceType {
    private var members = [T:Bool]()
    public var cardinality: Int {
        get {
            return members.count
        }
    }

    public init(_ member: T) {
        addMember(member)
    }

    public init(_ members: T...) {
        addMembers(fromArray: members)
    }

    public mutating func addMember(member: T) {
        members[member] = true
    }

    public mutating func addMembers(members: T...) {
        addMembers(fromArray: members)
    }

    public mutating func addMembers(fromArray array: [T]) {
        for member in array {
            addMember(member)
        }
    }

    public mutating func union(setToJoin: Set<T>) {
        for newMember in setToJoin.members.keys {
            addMember(newMember)
        }
    }

    public mutating func removeMember(memberToRemove: T) {
        members[memberToRemove] = nil
    }

    public mutating func removeMembers(membersToRemove: T...) {
        for oldMember in membersToRemove {
            removeMember(oldMember)
        }
    }

    public func isMember(member: T) -> Bool {
        return members[member] ?? false
    }

    public func generate() -> SetGenerator<T> {
        let dictionaryGenerator = members.generate()
        return SetGenerator<T>(dictionaryGenerator)
    }
}

public struct SetGenerator<T: Hashable>: GeneratorType {
    var backingDictionaryGenerator: DictionaryGenerator<T, Bool>
    public init(_ dictionaryGenerator: DictionaryGenerator<T, Bool>) {
        backingDictionaryGenerator = dictionaryGenerator
    }

    public mutating func next() -> (T)? {
        let nextElement = backingDictionaryGenerator.next()
        switch (nextElement) {
        case let Optional<(T, Bool)>.None:
            return Optional<T>.None

        case let Optional<(T, Bool)>.Some(item, _):
            return Optional<T>.Some(item)
        }
    }
}
