//
//  OptionalExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 3/3/17.
//  Copyright © 2017 omaralbeik. All rights reserved.
//

import XCTest
@testable import SwifterSwift

class OptionalExtensionsTests: XCTestCase {
	
	func testUnwrappedOrDefault() {
		var str: String? = nil
		
		XCTAssertEqual(str.unwrapped(or: "swift"), "swift")
		
		str = "swifterswift"
		XCTAssertEqual(str.unwrapped(or: "swift"), "swifterswift")
	}
	
	func testRunBlock() {
		var str: String? = nil
		var didRun = false
		str.run { _ in
			didRun = true
		}
		XCTAssertFalse(didRun)
		str = "swift"
		str.run { s in
			didRun = true
			XCTAssert(didRun)
			XCTAssertEqual(s, "swift")
		}
	}
	
}
