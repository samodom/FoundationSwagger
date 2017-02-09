//
//  FilePermissions.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 2/8/17.
//  Copyright © 2017 Swagger Soft. All rights reserved.
//


/// Type representing a simple POSIX set of file permissions.
public struct FilePermissions {

    /// Permissions for the user class.
    public let user: ClassPermissions


    /// Permissions for the group class.
    public let group: ClassPermissions


    /// Permissions for the others class.
    public let others: ClassPermissions


    /// Constructs file permissions with permissions for each class.
    public init(
        user: ClassPermissions = .none,
        group: ClassPermissions = .none,
        others: ClassPermissions = .none
        ) {

        self.user = user
        self.group = group
        self.others = others
    }


    /// Bit mask representation of the file permissions.
    public var mask: UInt16 {
        return user.mask << 6 +
            group.mask << 3 +
            others.mask
    }

}
