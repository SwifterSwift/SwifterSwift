//
//  UIBarButtonExtensionsTests.swift
//  SwifterSwift
//
//  Created by Steven on 2/14/17.
//  Copyright © 2017 omaralbeik. All rights reserved.
//

#if os(iOS) || os(tvOS)
	
	import XCTest
	@testable import SwifterSwift
	
	class UIBarButtonExtensionsTests: XCTestCase {
		
		override func setUp() {
			super.setUp()
			// Put setup code here. This method is called before the invocation of each test method in the class.
		}
		
		override func tearDown() {
			// Put teardown code here. This method is called after the invocation of each test method in the class.
			super.tearDown()
		}
		
		func testSelector() {}
		
		func testAddTargetForAction() {
			
			let barButton = UIBarButtonItem()
			let selector = #selector(testSelector)
			
			barButton.addTargetForAction(target: self, action: selector)
			
			let target = barButton.target as? UIBarButtonExtensionsTests
			
			XCTAssertEqual(target, self)
			XCTAssertEqual(barButton.action, selector)
		}
	}
#endif
