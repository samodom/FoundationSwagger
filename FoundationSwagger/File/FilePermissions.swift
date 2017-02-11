//
//  FilePermissions.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 2/8/17.
//  Copyright © 2017 Swagger Soft. All rights reserved.
//


/// Alias for 16-bit unsigned integers used as file permissions masks.
public typealias FilePermissionsMask = UInt16


/// Type representing a simple POSIX set of file permissions.
public struct FilePermissions {

    /// Permissions for the user class.
    public let user: ClassPermissions


    /// Permissions for the group class.
    public let group: ClassPermissions


    /// Permissions for the others class.
    public let others: ClassPermissions


    private let extraBits: FilePermissionsMask


    /// Constructs file permissions with permissions for each class.
    public init(
        user: ClassPermissions = .none,
        group: ClassPermissions = .none,
        others: ClassPermissions = .none
        ) {

        self.user = user
        self.group = group
        self.others = others
        extraBits = 0
    }


    /// Constructs file permissions based on a mask value.
    public init(mask: FilePermissionsMask) {
        let userMask = mask & FilePermissions.maskComponent(for: .user)
        user = ClassPermissions(rawValue: UInt8(userMask >> 6))

        let groupMask = mask & FilePermissions.maskComponent(for: .group)
        group = ClassPermissions(rawValue: UInt8(groupMask >> 3))

        let othersMask = mask & FilePermissions.maskComponent(for: .others)
        others = ClassPermissions(rawValue: UInt8(othersMask))

        extraBits = mask - userMask - groupMask - othersMask
    }

    /// Bit mask representation of the file permissions.
    public var mask: FilePermissionsMask {
        let userMask = FilePermissionsMask(user.rawValue) << 6
        let groupMask = FilePermissionsMask(group.rawValue) << 3
        let othersMask = FilePermissionsMask(others.rawValue)

        return extraBits + userMask + groupMask + othersMask
    }

}


fileprivate enum PermissionsClass {
    case user, group, others
}


fileprivate extension FilePermissions {

    static func maskComponent(for permissionsClass: PermissionsClass) -> FilePermissionsMask {
        switch permissionsClass {
        case .user:
            return 0b00000001_11000000

        case .group:
            return 0b00000000_00111000

        case .others:
            return 0b00000000_00000111
        }
    }
    
}
