//
//  UITextViewExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 2/15/17.
//  Copyright © 2017 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if os(iOS) || os(tvOS)
final class UITextViewExtensionsTests: XCTestCase {
	
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
		let text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation."
		textView.text = text
		textView.scrollToBottom()
		XCTAssertNotEqual(textView.contentOffset.y, 0.0)
		#if os(iOS)
			XCTAssertEqual(textView.contentOffset.y, 87.0)
		#elseif os(tvOS)
			XCTAssertEqual(textView.contentOffset.y, 3370.0)
		#endif
			
		textView.scrollToTop()
		XCTAssertNotEqual(textView.contentOffset.y, 0.0)
		
	}
	
}
#endif
