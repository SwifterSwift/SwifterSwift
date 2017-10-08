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

final class CharacterExtensionsTests: XCTestCase {
	
	func testOperators() {
		let s = Character("s")
		XCTAssertEqual(s * 5, "sssss")
		XCTAssertEqual(5 * s, "sssss")
		
		XCTAssertEqual(s * 0, "")
		XCTAssertEqual(0 * s, "")
		
		XCTAssertEqual(s * -5, "")
		XCTAssertEqual(-5 * s, "")
	}
	
	func testIsEmoji() {
		XCTAssert(Character("😂").isEmoji)
		XCTAssertFalse(Character("j").isEmoji)
	}
	
	func testIsNumber() {
		XCTAssert(Character("1").isNumber)
		XCTAssertFalse(Character("s").isNumber)
	}
	
    func testIsLetter() {
        XCTAssertTrue(Character("a").isLetter)
        XCTAssertTrue(Character("B").isLetter)
        XCTAssertFalse(Character("3").isLetter)
        XCTAssertFalse(Character("-").isLetter)
    }
    
    func testIsWhiteSpace() {
        XCTAssertTrue(Character(" ").isWhiteSpace)
        XCTAssertFalse(Character("-").isWhiteSpace)

    }
    
	func testInt() {
		XCTAssertNotNil(Character("1").int)
		XCTAssertEqual(Character("1").int, 1)
		XCTAssertNil(Character("s").int)
	}
	
	func testString() {
		XCTAssertEqual(Character("s").string, String("s"))
	}
	
	func testIsUpercased() {
		XCTAssert(Character("S").isUppercased)
		XCTAssertFalse(Character("s").isUppercased)
	}
	
	func testIsLowercased() {
		XCTAssert(Character("s").isLowercased)
		XCTAssertFalse(Character("S").isLowercased)
	}
	
    func testUppercased() {
        XCTAssertEqual(Character("s").uppercased, Character("S"))
    }
    
    func testLowercased() {
        XCTAssertEqual(Character("S").lowercased, Character("s"))

    }
}
