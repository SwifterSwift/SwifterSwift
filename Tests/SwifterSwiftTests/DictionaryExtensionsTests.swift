//
//  DictionaryExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/27/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import XCTest
@testable import SwifterSwift

class DictionaryExtensionsTests: XCTestCase {
	
	var testDict: [String : Any] = ["testKey": "testValue", "testArrayKey": [1, 2, 3, 4, 5]]
	
	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	func testHasKey() {
		XCTAssert(testDict.has(key: "testKey"))
		XCTAssertFalse(testDict.has(key: "anotherKey"))
	}
	
	func testJsonString() {
		XCTAssertNotNil(testDict.jsonString())
		XCTAssert(testDict.jsonString()!.contain("\"testArrayKey\":[1,2,3,4,5]"))
		XCTAssert(testDict.jsonString()!.contain("\"testKey\":\"testValue\""))
		
		XCTAssert(testDict.jsonString(prettify: true)!.contain("[\n    1,\n    2,\n    3,\n    4,\n    5\n  ]"))
		
		XCTAssertNil(["key": NSObject()].jsonString())
		XCTAssertNil([1:2].jsonString())
	}
	
	func testJsonData() {
		let dict = ["key": "value"]
		
		let jsonString = "{\"key\":\"value\"}"
		let jsonData = jsonString.data(using: .utf8)
	
		let prettyJsonString = "{\n  \"key\" : \"value\"\n}"
		let prettyJsonData = prettyJsonString.data(using: .utf8)
		
		XCTAssertEqual(dict.jsonData(), jsonData)
		XCTAssertEqual(dict.jsonData(prettify: true), prettyJsonData)
		
		XCTAssertNil(["key": NSObject()].jsonData())
		XCTAssertNil([1:2].jsonData())
	}
	
	func testLowercaseAllKeys() {
		var dict = ["tEstKeY": "value"]
		dict.lowercaseAllKeys()
		XCTAssertEqual(dict, ["testkey": "value"])
	}
	
}
