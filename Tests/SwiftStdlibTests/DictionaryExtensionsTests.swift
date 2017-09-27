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
    
	func testHasKey() {
		XCTAssert(testDict.has(key: "testKey"))
		XCTAssertFalse(testDict.has(key: "anotherKey"))
	}
	
    func testRemoveAll() {
        var dict: [String : String] = ["key1": "value1", "key2": "value2", "key3": "value3"]
		dict.removeAll(keys: ["key1", "key2"])
        XCTAssertTrue(dict.keys.contains("key3"))
        XCTAssertFalse(dict.keys.contains("key1"))
        XCTAssertFalse(dict.keys.contains("key2"))
    }
    
	func testJsonString() {
		XCTAssertNotNil(testDict.jsonString())
		XCTAssertEqual(testDict.jsonString()?.contains("\"testArrayKey\":[1,2,3,4,5]"), true)
		XCTAssertEqual(testDict.jsonString()?.contains("\"testKey\":\"testValue\""), true)
		
		XCTAssertEqual(testDict.jsonString(prettify: true)?.contains("[\n    1,\n    2,\n    3,\n    4,\n    5\n  ]"), true)
		
		XCTAssertNil(["key": NSObject()].jsonString())
		XCTAssertNil([1: 2].jsonString())
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
		XCTAssertNil([1: 2].jsonData())
	}
	
	func testLowercaseAllKeys() {
		var dict = ["tEstKeY": "value"]
		dict.lowercaseAllKeys()
		XCTAssertEqual(dict, ["testkey": "value"])
	}
    
    func testCountFiltered() {
        let dict: [String: String] = ["key1": "value", "key2": "value", "key3": "value3"]
        let count = dict.count { (tuple) -> Bool in
            return tuple.0 == "key1" || tuple.1 == "value"
        }
        XCTAssertEqual(count, 2)
    }
    
    // MARK: - Test Operators
    func testOperatorPlus() {
        let dict: [String: String] = ["key1": "value1"]
        let dict2: [String: String] = ["key2": "value2"]
        let result = dict + dict2
        XCTAssertTrue(result.keys.contains("key1"))
        XCTAssertTrue(result.keys.contains("key2"))

    }
    
    func testOperatorMinus() {
        let dict: [String: String] = ["key1": "value1", "key2": "value2", "key3": "value3"]
        let result = dict-["key1", "key2"]
        XCTAssertTrue(result.keys.contains("key3"))
        XCTAssertFalse(result.keys.contains("key1"))
        XCTAssertFalse(result.keys.contains("key2"))
    }
    
    func testOperatorPlusEqual() {
        var dict: [String: String] = ["key1": "value1"]
        let dict2: [String: String] = ["key2": "value2"]
        dict += dict2
        XCTAssertTrue(dict.keys.contains("key1"))
        XCTAssertTrue(dict.keys.contains("key2"))
    }
    
    func testOperatorRemoveKeys() {
        var dict: [String: String] = ["key1": "value1", "key2": "value2", "key3": "value3"]
        dict-=["key1", "key2"]
        XCTAssertTrue(dict.keys.contains("key3"))
        XCTAssertFalse(dict.keys.contains("key1"))
        XCTAssertFalse(dict.keys.contains("key2"))
    }
	
}
