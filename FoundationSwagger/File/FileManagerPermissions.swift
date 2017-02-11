//
//  FileManagerPermissions.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 2/10/17.
//  Copyright © 2017 Swagger Soft. All rights reserved.
//

import Foundation

public extension FileManager {

    /// Retrieves the file permissions of the file or directory at the provided path, if it exists.
    /// - parameter atPath: Path of file or directory whose permissions are to be retrieved.
    /// - returns: Retrieved file permissions of specified file, if it exists. 
    public func permissionsOfItem(atPath path: String) throws -> FilePermissions? {
        let attributes = try attributesOfItem(atPath: path)
        guard let posixPermissions = attributes[FileAttributeKey.posixPermissions] as? FilePermissionsMask else {
            return nil
        }

        return FilePermissions(mask: posixPermissions)
    }


    /// Sets file permissions of the file or directory at the provided path, if it exists.
    /// - parameter permissions: New file permissions to set on the specified file or directory.
    /// - parameter atPath: Path of file or directory whose permissions should be set.
    /// - throws: Any error thrown by the `FileManager.setAttributes(_:ofItemAtPath:)` method.
    public func setPermissions(_ permissions: FilePermissions, ofItemAtPath path: String) throws {
        try setAttributes(
            [FileAttributeKey.posixPermissions: permissions.mask],
            ofItemAtPath: path
        )
    }

}
