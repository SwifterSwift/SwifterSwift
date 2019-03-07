//
//  FileManagerExtensionsTests.swift
//  SwifterSwift
//
//  Created by Jason Jon E. Carreos on 05/02/2018.
//  Copyright © 2018 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if canImport(Foundation)
import Foundation

final class FileManagerExtensionsTests: XCTestCase {

    func testJSONFromFileAtPath() {
        do {
            let bundle = Bundle(for: FileManagerExtensionsTests.self)
            let filePath = bundle.path(forResource: "test", ofType: "json")

            guard let path = filePath else {
                XCTFail("File path undefined.")
                return
            }

            let json = try FileManager.default.jsonFromFile(atPath: path)

            XCTAssertNotNil(json)

            // Check contents
            if let dict = json {
                if let string = dict["title"] as? String, let itemId = dict["id"] as? Int {
                    XCTAssert(string == "Test")
                    XCTAssert(itemId == 1)
                } else {
                    XCTFail("Does not contain the correct content.")
                }
            } else {
                XCTFail("Opening of file returned nil.")
            }
        } catch {
            XCTFail("Error encountered during opening of file. \(error.localizedDescription)")
        }
    }

    func testJSONFromFileWithFilename() {
        do {
            var filename = "test.json"  // With extension
            var json = try FileManager.default.jsonFromFile(withFilename: filename, at: FileManagerExtensionsTests.self)

            XCTAssertNotNil(json)

            filename = "test"  // Without extension
            json = try FileManager.default.jsonFromFile(withFilename: filename, at: FileManagerExtensionsTests.self)

            XCTAssertNotNil(json)

            // Check contents
            if let dict = json {
                if let string = dict["title"] as? String, let itemId = dict["id"] as? Int {
                    XCTAssert(string == "Test")
                    XCTAssert(itemId == 1)
                } else {
                    XCTFail("Does not contain the correct content.")
                }
            } else {
                XCTFail("Opening of file returned nil.")
            }
        } catch {
            XCTFail("Error encountered during opening of file. \(error.localizedDescription)")
        }
    }

    func testInvalidFile() {
        let filename = "another_test.not_json"
        do {
            let json = try FileManager.default.jsonFromFile(withFilename: filename, at: FileManagerExtensionsTests.self)
            XCTAssertNil(json)
        } catch {}
    }

    func testCreateTemporaryDirectory() {
        do {
            let fileManager = FileManager.default
            let tempDirectory = try fileManager.createTemporaryDirectory()
            XCTAssertFalse(tempDirectory.path.isEmpty)

            var isDirectory = ObjCBool(false)
            XCTAssert(fileManager.fileExists(atPath: tempDirectory.path, isDirectory: &isDirectory))
            XCTAssertTrue(isDirectory.boolValue)
            XCTAssert(try fileManager.contentsOfDirectory(atPath: tempDirectory.path).isEmpty)

            let tempFile = tempDirectory.appendingPathComponent(ProcessInfo().globallyUniqueString)
            XCTAssert(fileManager.createFile(atPath: tempFile.path, contents: Data(), attributes: nil))
            XCTAssertFalse(try fileManager.contentsOfDirectory(atPath: tempDirectory.path).isEmpty)
            XCTAssertNotNil(fileManager.contents(atPath: tempFile.path))

            try fileManager.removeItem(at: tempDirectory)
        } catch {
            XCTFail("\(error)")
        }
    }

}

#endif
