// FileManagerExtensionsTests.swift - Copyright 2025 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(Foundation)
import Foundation

final class FileManagerExtensionsTests: XCTestCase {
    func testJSONFromFileAtPath() {
        #if !os(Linux) && !os(Android)
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
                    XCTAssertEqual(string, "Test")
                    XCTAssertEqual(itemId, 1)
                } else {
                    XCTFail("Does not contain the correct content.")
                }
            } else {
                XCTFail("Opening of file returned nil.")
            }
        } catch {
            XCTFail("Error encountered during opening of file. \(error.localizedDescription)")
        }
        #endif
    }

    func testJSONFromFileWithFilename() {
        #if !os(Linux) && !os(Android)
        do {
            var filename = "test.json" // With extension
            var json = try FileManager.default.jsonFromFile(withFilename: filename, at: FileManagerExtensionsTests.self)

            XCTAssertNotNil(json)

            filename = "test" // Without extension
            json = try FileManager.default.jsonFromFile(withFilename: filename, at: FileManagerExtensionsTests.self)

            XCTAssertNotNil(json)

            // Check contents
            if let dict = json {
                if let string = dict["title"] as? String, let itemId = dict["id"] as? Int {
                    XCTAssertEqual(string, "Test")
                    XCTAssertEqual(itemId, 1)
                } else {
                    XCTFail("Does not contain the correct content.")
                }
            } else {
                XCTFail("Opening of file returned nil.")
            }
        } catch {
            XCTFail("Error encountered during opening of file. \(error.localizedDescription)")
        }
        #endif
    }

    func testJSONObjectFromFileAtPath() throws {
        let bundle = Bundle(for: FileManagerExtensionsTests.self)

        // Test dictionary JSON
        guard let dictPath = bundle.path(forResource: "test", ofType: "json") else {
            XCTFail("File path undefined.")
            return
        }

        let dictJSON = try FileManager.default.jsonObjectFromFile(atPath: dictPath)
        let dict = try XCTUnwrap(dictJSON as? [String: Any])
        XCTAssertEqual(dict["title"] as? String, "Test")
        XCTAssertEqual(dict["id"] as? Int, 1)

        // Test array JSON
        guard let arrayPath = bundle.path(forResource: "test_array", ofType: "json") else {
            XCTFail("Array JSON file path undefined.")
            return
        }

        let arrayJSON = try FileManager.default.jsonObjectFromFile(atPath: arrayPath)
        let array = try XCTUnwrap(arrayJSON as? [[String: Any]])
        XCTAssertEqual(array.count, 2)
        XCTAssertEqual(array[0]["title"] as? String, "First")
        XCTAssertEqual(array[1]["id"] as? Int, 2)
    }

    #if !os(Linux) && !os(Android)
    func testJSONObjectFromFileWithFilename() throws {
        // Test dictionary JSON
        let dictJSON = try FileManager.default.jsonObjectFromFile(
            withFilename: "test.json",
            at: FileManagerExtensionsTests.self)
        let dict = try XCTUnwrap(dictJSON as? [String: Any])
        XCTAssertEqual(dict["title"] as? String, "Test")
        XCTAssertEqual(dict["id"] as? Int, 1)

        // Test array JSON with extension
        let arrayJSON = try FileManager.default.jsonObjectFromFile(
            withFilename: "test_array.json",
            at: FileManagerExtensionsTests.self)
        let array = try XCTUnwrap(arrayJSON as? [[String: Any]])
        XCTAssertEqual(array.count, 2)
        XCTAssertEqual(array[0]["id"] as? Int, 1)
        XCTAssertEqual(array[1]["title"] as? String, "Second")
    }
    #endif

    func testInvalidFile() {
        #if !os(Linux) && !os(Android)
        let filename = "another_test.not_json"
        do {
            let json = try FileManager.default.jsonFromFile(withFilename: filename, at: FileManagerExtensionsTests.self)
            XCTAssertNil(json)
        } catch {}
        #endif
    }

    func testCreateTemporaryDirectory() throws {
        let fileManager = FileManager.default
        let tempDirectory = try fileManager.createTemporaryDirectory()
        XCTAssertFalse(tempDirectory.path.isEmpty)

        var isDirectory = ObjCBool(false)
        XCTAssert(fileManager.fileExists(atPath: tempDirectory.path, isDirectory: &isDirectory))
        XCTAssertTrue(isDirectory.boolValue)
        XCTAssert(try fileManager.contentsOfDirectory(atPath: tempDirectory.path).isEmpty)

        let tempFile = tempDirectory.appendingPathComponent(ProcessInfo.processInfo.globallyUniqueString)
        XCTAssert(fileManager.createFile(atPath: tempFile.path, contents: Data(), attributes: nil))
        XCTAssertFalse(try fileManager.contentsOfDirectory(atPath: tempDirectory.path).isEmpty)
        XCTAssertNotNil(fileManager.contents(atPath: tempFile.path))

        try fileManager.removeItem(at: tempDirectory)
    }
}

#endif
