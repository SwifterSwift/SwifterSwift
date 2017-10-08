//
//  BoolExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 20/01/2017.
//  Copyright © 2017 omaralbeik. All rights reserved.
//

import XCTest
@testable import SwifterSwift

final class BoolExtensionsTests: XCTestCase {
	
	func testInt() {
		XCTAssertEqual(true.int, 1)
		XCTAssertEqual(false.int, 0)
	}
	
	func testString() {
		XCTAssertEqual(true.string, "true")
		XCTAssertEqual(false.string, "false")
	}
	
	func testToggled() {
		XCTAssertFalse(true.toggled)
		XCTAssert(false.toggled)
	}
    
    func testRandom() {
        var yes = 0, no = 0
        for _ in 1...10000 {
            if Bool.random {
                yes += 1
            } else {
                no += 1
            }
        }
        XCTAssert(yes >= 10 && no >= 10)
    }
	
	func testToggle() {
		var t = true
		t.toggle()
		XCTAssertFalse(t)
		t.toggle()
		XCTAssert(t)
	}
	
}
