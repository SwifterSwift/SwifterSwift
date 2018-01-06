//
//  CGSizeExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/27/16.
//  Copyright © 2016 SwifterSwift
//

import XCTest
@testable import SwifterSwift

final class CGSizeExtensionsTests: XCTestCase {
	
	func testAspectFit() {
		let rect = CGSize(width: 120, height: 80)
		let parentRect  = CGSize(width: 100, height: 50)
		let newRect = rect.aspectFit(to: parentRect)
		XCTAssertEqual(newRect.width, 75)
		XCTAssertEqual(newRect.height, 50)
	}
	
	func testAspectFill() {
		let rect = CGSize(width: 20, height: 120)
		let parentRect  = CGSize(width: 100, height: 60)
		let newRect = rect.aspectFill(to: parentRect)
		XCTAssertEqual(newRect.width, 100)
		XCTAssertEqual(newRect.height, 60)
	}
	
}
