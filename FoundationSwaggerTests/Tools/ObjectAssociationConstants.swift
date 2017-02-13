//
//  ObjectAssociationConstants.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 2/13/17.
//  Copyright © 2017 Swagger Soft. All rights reserved.
//

import FoundationSwagger

fileprivate let SampleKeyString1 = NSUUID().uuidString.cString(using: .utf8)!
let SampleKey1 = ObjectAssociationKey(SampleKeyString1)

fileprivate let SampleKeyString2 = NSUUID().uuidString.cString(using: .utf8)!
let SampleKey2 = ObjectAssociationKey(SampleKeyString2)
