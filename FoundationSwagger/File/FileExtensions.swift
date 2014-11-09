//
//  FileExtensions.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 11/9/14.
//  Copyright (c) 2014 Swagger Soft. All rights reserved.
//

import Foundation

/**
  Path to the 'Documents' directory
*/
public let DocumentsDirectoryPath: String = {
    let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as [String]
    return paths[0]
    }()

/**
  URL to the 'Documents' directory
*/
public let DocumentsDirectoryURL: NSURL = { NSURL(fileURLWithPath:DocumentsDirectoryPath, isDirectory: true)! }()
