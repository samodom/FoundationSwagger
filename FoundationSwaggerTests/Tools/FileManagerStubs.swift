//
//  FileManagerStubs.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 2/10/17.
//  Copyright © 2017 Swagger Soft. All rights reserved.
//

import FoundationSwagger

extension FileManager {

    func createAttributesForItemStubSurrogate() -> MethodSurrogate {
        return MethodSurrogate(
            forClass: FileManager.self,
            ofType: .instance,
            originalSelector: #selector(FileManager.attributesOfItem(atPath:)),
            alternateSelector: #selector(FileManager.stub_attributesOfItem(atPath:))
        )
    }

    dynamic func stub_attributesOfItem(atPath: String) throws -> [FileAttributeKey: Any] {
        return [:]
    }

}
