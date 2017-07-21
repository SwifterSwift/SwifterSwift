//
//  UITextViewExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 2/15/17.
//  Copyright © 2017 omaralbeik. All rights reserved.
//

import XCTest
@testable import SwifterSwift

#if os(iOS) || os(tvOS)
class UITextViewExtensionsTests: XCTestCase {
	
	var textView = UITextView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
	
	override func setUp() {
		super.setUp()
	}
	
	func testClear() {
		textView.text = "Hello"
		textView.clear()
		XCTAssertEqual(textView.text, "")
		XCTAssertEqual(textView.attributedText?.string, "")
	}
	
	func testScroll() {
		let text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
		textView.text = text
		textView.scrollToBottom()
		XCTAssertNotEqual(textView.contentOffset.y, 0.0)
		XCTAssertEqual(textView.contentOffset.y, 336.0)
		
		textView.scrollToTop()
		XCTAssertNotEqual(textView.contentOffset.y, 0.0)
		
	}
	
}
#endif
