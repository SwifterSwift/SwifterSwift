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
		XCTAssert(testDict.has(key: "testKey") == true && testDict.has(key: "anotherKey") == false, "Couldn't get correct value for \(#function)")
	}
	
	func testJsonData() {
		let jsonString = "{\"testKey\":\"testValue\",\"testArrayKey\":[1,2,3,4,5]}"
		XCTAssert(testDict.jsonString() == jsonString, "Couldn't get correct value for \(#function)")
	}
}
