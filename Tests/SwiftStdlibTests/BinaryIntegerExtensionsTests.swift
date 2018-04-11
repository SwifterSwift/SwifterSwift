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

	func testRandomDoubles() {
		var values = Set<Double>()
		for _ in 0..<10000 {
			let random = Double.random(lowerBound: -1, upperBound: 1)
			XCTAssert(random >= -1 && random <= 1)
			values.insert(random)
		}
		XCTAssertEqual(values.count, 10000)
	}

	func testRandomFloat80s() {
		var values = Set<Float80>()
		for _ in 0..<10000 {
			let random = Float80.random(lowerBound: -1, upperBound: 1)
			XCTAssert(random >= -1 && random <= 1)
			values.insert(random)
		}
		XCTAssertEqual(values.count, 10000)
	}

}
