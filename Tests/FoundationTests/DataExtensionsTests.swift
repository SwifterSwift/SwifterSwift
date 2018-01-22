//
//  DataExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 09/02/2017.
//  Copyright © 2017 SwifterSwift
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
    
    func testHexString() {
        let dataFromString = "0123".data(using: .utf8)
        let hexString = dataFromString?.hexString
        XCTAssertNotNil(hexString)
        // hex value of an int i in [0...9] = 0x30 + i
        XCTAssert(hexString == "30313233")
    }
	
    func testBytes() {
        let dataFromString = "hello".data(using: .utf8)
        let bytes = dataFromString?.bytes
        XCTAssertNotNil(bytes)
        XCTAssertEqual(bytes?.count, 5)
    }
}
