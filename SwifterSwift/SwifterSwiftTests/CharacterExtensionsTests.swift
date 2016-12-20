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
		XCTAssert(s * 5 == "sssss", "Couldn't get correct value for \(#function)")
	}
	
	func testIsEmoji() {
		XCTAssert(Character("😂").isEmoji == true, "Couldn't get correct value for \(#function)")
		XCTAssert(Character("j").isEmoji == false, "Couldn't get correct value for \(#function)")
	}
	
	func testIsNumber() {
		XCTAssert(Character("1").isNumber == true, "Couldn't get correct value for \(#function)")
		XCTAssert(Character("s").isNumber == false, "Couldn't get correct value for \(#function)")
	}
	
	func testToInt() {
		XCTAssert(Character("1").int! == 1, "Couldn't get correct value for \(#function)")
		XCTAssert(Character("s").int == nil, "Couldn't get correct value for \(#function)")
	}
	
	func testToString() {
		XCTAssert(Character("s").string == String("s"), "Couldn't get correct value for \(#function)")
	}
}
