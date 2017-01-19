//
//  CGSizeExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/27/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import XCTest
@testable import SwifterSwift

class CGSizeExtensionsTests: XCTestCase {
	
	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	#if !os(macOS)
	func testAspectFit() {
		let rect = CGSize(width: 40, height: 80)
		let parentRect  = CGSize(width: 100, height: 50)
		let newRect = rect.aspectFit(to: parentRect)
		XCTAssertEqual(newRect.width, 25)
		XCTAssertEqual(newRect.height, 50)
	}
	#endif
}
