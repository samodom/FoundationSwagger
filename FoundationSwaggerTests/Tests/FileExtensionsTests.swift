//
//  FileExtensionsTests.swift
//  FoundationSwagger
//
//  Created by Sam Odom on 11/9/14.
//  Copyright (c) 2014 Swagger Soft. All rights reserved.
//

import XCTest

class FileExtensionsTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testDocumentsDirectoryPath() {
        let expectedPath = PathToDocumentsDirectory()
        let path = DocumentsDirectoryPath
        XCTAssertEqual(path, expectedPath, "The default file manager should be used to provide the path to the 'Documents' directory on the device")
    }

    func testFileManagerHasDocumentsDirectoryURL() {
        let expectedURL = NSURL(fileURLWithPath: PathToDocumentsDirectory(), isDirectory: true)!
        let URL = DocumentsDirectoryURL
        XCTAssertEqual(URL, expectedURL, "The default file manager should be used to provide a URL to the 'Documents' directory on the device")
    }

}

private func PathToDocumentsDirectory() -> String {
    let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as [String]
    return paths[0]
}
