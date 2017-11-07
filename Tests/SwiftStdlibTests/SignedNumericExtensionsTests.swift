//
//  SignedNumericExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 10/7/17.
//  Copyright © 2017 SwifterSwift
//

import XCTest
@testable import SwifterSwift

class SignedNumericExtensionsTests: XCTestCase {
	
	func testString() {
		let number: Double = -1.2
		XCTAssertEqual(number.string, "-1.2")
	}
	
	func testAsLocaleCurrency() {
		let number: Double = 3.2
		XCTAssertEqual(number.asLocaleCurrency, "$3.20")
	}
	
}
