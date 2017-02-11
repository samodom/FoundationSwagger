//
//  ClassPermissions.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 2/8/17.
//  Copyright © 2017 Swagger Soft. All rights reserved.
//


/// Type representing any combination of read, write and execute permissions on a file.
public struct ClassPermissions: OptionSet {

    /// Bitmask representation of a class's permissions on a file.
    public let rawValue: UInt8

    private static let readablePermission: UInt8 = 1 << 2
    private static let writablePermission: UInt8 = 1 << 1
    private static let executablePermission: UInt8 = 1 << 0


    /// The readable-only class permission.
    public static let readable = ClassPermissions(rawValue: readablePermission)


    /// The writable-only class permission.
    public static let writable = ClassPermissions(rawValue: writablePermission)


    /// The executable-only class permission.
    public static let executable = ClassPermissions(rawValue: executablePermission)


    /// No class permissions.
    public static let none: ClassPermissions = []


    /// All class permissions.
    public static let all: ClassPermissions = [readable, writable, executable]


    /// Produces only valid class permissions based on raw values of 1 through 7.
    /// Any values provided outside of that range produce empty class permission sets.
    public init(rawValue: UInt8) {
        self.rawValue = rawValue % 8
    }


    /// Indicates whether these class permissions include the readable permission.
    public var isReadable: Bool { return contains(.readable) }


    /// Indicates whether these class permissions include the writable permission.
    public var isWritable: Bool { return contains(.writable) }


    /// Indicates whether these class permissions include the executable permission.
    public var isExecutable: Bool { return contains(.executable) }

}
