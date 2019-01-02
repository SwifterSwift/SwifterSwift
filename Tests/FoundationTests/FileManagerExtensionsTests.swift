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

    func testDecode() {
        let point = CGPoint(x: 1, y: 2) //CGPoint conforms to Encodable
        do {
            let temporaryDirectoryURL = FileManager.default.temporaryDirectory
            let temporaryFilename = ProcessInfo().globallyUniqueString
            let temporaryFileURL = temporaryDirectoryURL.appendingPathComponent(temporaryFilename)

            let encodedPoint = try JSONEncoder().encode(point)
            let fileManager = FileManager.default
            XCTAssert(fileManager.createFile(atPath: temporaryFileURL.path, contents: encodedPoint, attributes: nil))

            XCTAssert(fileManager.fileExists(atPath: temporaryFileURL.path))

            let data2 = (fileManager.contents(atPath: temporaryFileURL.path))
            XCTAssertNotNil(data2)

            let decodedPoint = try fileManager.decodeJSON(as: CGPoint.self, from: temporaryFileURL)
            XCTAssertEqual(point, decodedPoint)

            try fileManager.removeItem(at: temporaryFileURL)
            XCTAssertFalse(fileManager.fileExists(atPath: temporaryFileURL.path))
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

}

#endif
