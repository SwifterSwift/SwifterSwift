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
