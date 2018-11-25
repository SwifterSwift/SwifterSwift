//
//  DataExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 09/02/2017.
//  Copyright © 2017 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if canImport(Foundation)
import Foundation

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

    func testJsonObject() {
        let invalidData = "hello".data(using: .utf8)
        XCTAssertThrowsError(try invalidData?.jsonObject())
        XCTAssertThrowsError(try invalidData?.jsonObject(options: [.allowFragments]))

        let stringData = "\"hello\"".data(using: .utf8)
        XCTAssertThrowsError(try stringData?.jsonObject())
        XCTAssertEqual((try? stringData?.jsonObject(options: [.allowFragments])) as? String, "hello")

        let objectData = "{\"message\": \"hello\"}".data(using: .utf8)
        let object = (try? objectData?.jsonObject()) as? [String: String]
        XCTAssertNotNil(object)
        XCTAssertEqual(object?["message"], "hello")

        let arrayData = "[\"hello\"]".data(using: .utf8)
        let array = (try? arrayData?.jsonObject()) as? [String]
        XCTAssertNotNil(array)
        XCTAssertEqual(array?.first, "hello")
    }

}

#endif
