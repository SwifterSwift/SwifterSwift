//
//  CharacterExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/27/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

//
//  CharacterExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/27/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import XCTest
@testable import SwifterSwift

class CharacterExtensionsTests: XCTestCase {
	
	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	func testOperators() {
		let s = Character("s")
		XCTAssertEqual(s * 5, "sssss")
	}
	
	func testIsEmoji() {
		XCTAssertTrue(Character("😂").isEmoji)
		XCTAssertFalse(Character("j").isEmoji)
	}
	
	func testIsNumber() {
		XCTAssertTrue(Character("1").isNumber)
		XCTAssertFalse(Character("s").isNumber)
	}
	
	func testInt() {
		XCTAssertNotNil(Character("1").int)
		XCTAssertEqual(Character("1").int!, 1)
		XCTAssertNil(Character("s").int)
	}
	
	func testString() {
		XCTAssertEqual(Character("s").string, String("s"))
	}
}
