//
//  BinaryIntegerExtensionsTests.swift
//  SwifterSwift
//
//  Created by Guy Kogus on 11/04/2018.
//  Copyright © 2018 SwifterSwift
//

import XCTest
@testable import SwifterSwift

final class BinaryIntegerExtensionsTests: XCTestCase {

	func testRandomIntegers() {
		var values = Set<Int>()
		for _ in 0..<10000 {
			let random = Int.random(lowerBound: -50, upperBound: 50)
			XCTAssert(random >= -50 && random < 50)
			values.insert(random)
		}
		XCTAssertEqual(values.count, 100)
	}

	func testRandomUInt32s() {
		var values = Set<UInt32>()
		for _ in 0..<10000 {
			let random = UInt32.random(upperBound: 100)
			XCTAssert(random >= 0 && random < 100)
			values.insert(random)
		}
		XCTAssertEqual(values.count, 100)
	}

}
