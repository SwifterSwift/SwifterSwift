//
//  FileManagerExtensionsTests.swift
//  SwifterSwift
//
//  Created by Jason Jon E. Carreos on 05/02/2018.
//  Copyright © 2018 SwifterSwift
//

import XCTest
@testable import SwifterSwift

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
			XCTFail("Error encountered during opening of file.")
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
			XCTFail("Error encountered during opening of file.")
		}
	}

	func testInvalidFile() {
		let filename = "another_test.not_json"
		do {
			let json = try FileManager.default.jsonFromFile(withFilename: filename, at: FileManagerExtensionsTests.self)
			XCTAssertNil(json)
		} catch {}
	}

}
