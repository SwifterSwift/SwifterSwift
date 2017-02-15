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
		
		override func setUp() {
			super.setUp()
			// Put setup code here. This method is called before the invocation of each test method in the class.
		}
		
		override func tearDown() {
			// Put teardown code here. This method is called after the invocation of each test method in the class.
			super.tearDown()
		}
		
		func testClear() {
			let frame = CGRect(x: 0, y: 0, width: 100, height: 30)
			let textView = UITextView(frame: frame)
			textView.text = "Hello"
			textView.clear()
			XCTAssertEqual(textView.text!, "")
			XCTAssertEqual(textView.attributedText!.string, "")
		}
		
	}
#endif
