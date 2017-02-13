//
//  CollectionExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 09/02/2017.
//  Copyright © 2017 omaralbeik. All rights reserved.
//

import XCTest
@testable import SwifterSwift

class CollectionExtensionsTests: XCTestCase {
	
	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	func testForEachInParallel() {
		let collection = [1, 2, 3, 4, 5]
		collection.forEachInParallel { item in
			XCTAssert(collection.contains(item))
		}
	}
	
	func testSafeSubscript() {
		let collection = [1, 2, 3, 4, 5]
		XCTAssertNotNil(collection[safe: 2])
		XCTAssertEqual(collection[safe: 2], 3)
		XCTAssertNil(collection[safe: 10])
	}
	
	
}
