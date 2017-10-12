//
//  DataExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 09/02/2017.
//  Copyright © 2017 omaralbeik. All rights reserved.
//

import XCTest
@testable import SwifterSwift

final class DataExtensionsTests: XCTestCase {
	
	func testString() {
		let dataFromString = "hello".data(using: .utf8)
		XCTAssertNotNil(dataFromString)
		XCTAssertNotNil(dataFromString?.string(encoding: .utf8))
		XCTAssertEqual(dataFromString?.string(encoding: .utf8), "hello")
	}
	
    func testBytes() {
        let dataFromString = "hello".data(using: .utf8)
        let bytes = dataFromString?.bytes
        XCTAssertNotNil(bytes)
        XCTAssertEqual(bytes?.count, 5)
    }

    func testChunks() {
        let string = "This is a test, where we just want to create some sort of data."
        let data = string.data(using: .utf8)!

        let chunkSize = 10
        let size = data.count
        let chunks = data.chunks(of: chunkSize)
        let totalChunksSize = chunks.map { $0.count }.reduce(0, +)
        XCTAssertEqual(size, totalChunksSize)
        chunks.forEach { XCTAssertLessThanOrEqual($0.count, chunkSize) }

        // Test of the combined chunks again form the same string
        var newData = Data()
        chunks.forEach { newData.append($0) }
        XCTAssertEqual(string, String(data: newData, encoding: .utf8))
    }
}
