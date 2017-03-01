//
//  UITextFieldExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 2/15/17.
//  Copyright © 2017 omaralbeik. All rights reserved.
//

import XCTest
@testable import SwifterSwift

#if os(iOS) || os(tvOS)
	class UITextFieldExtensionsTests: XCTestCase {
		
		override func setUp() {
			super.setUp()
			// Put setup code here. This method is called before the invocation of each test method in the class.
		}
		
		override func tearDown() {
			// Put teardown code here. This method is called after the invocation of each test method in the class.
			super.tearDown()
		}
		
		func testIsEmpty() {
			let textField = UITextField()
			XCTAssert(textField.isEmpty)
			textField.text = "Hello"
			XCTAssertFalse(textField.isEmpty)
			textField.text = nil
			XCTAssert(textField.isEmpty)
		}
		
		func testTrimmedText() {
			let frame = CGRect(x: 0, y: 0, width: 100, height: 30)
			let textField = UITextField(frame: frame)
			textField.text = "Hello \n    \n"
			XCTAssertNotNil(textField.trimmedText)
			XCTAssertEqual(textField.trimmedText!, "Hello")
		}
        
        func testLeftViewTintColor() {
            let frame = CGRect(x: 0, y: 0, width: 100, height: 30)
            let textField = UITextField(frame: frame)
            
            let imageView = UIImageView()
            imageView.tintColor = .red
            
            textField.leftView = imageView
            XCTAssertEqual(textField.leftViewTintColor, .red)
            
            textField.leftViewTintColor = .blue
            XCTAssertEqual(textField.leftViewTintColor, .blue)
        }
        
        func testRightViewTintColor() {
            
            let frame = CGRect(x: 0, y: 0, width: 100, height: 30)
            let textField = UITextField(frame: frame)
            
            let imageView = UIImageView()
            imageView.tintColor = .red
            
            textField.rightView = imageView
            XCTAssertEqual(textField.rightViewTintColor, .red)
            
            textField.rightViewTintColor = .blue
            XCTAssertEqual(textField.rightViewTintColor, .blue)
        }
        
		
		func testClear() {
			let frame = CGRect(x: 0, y: 0, width: 100, height: 30)
			let textField = UITextField(frame: frame)
			textField.text = "Hello"
			textField.clear()
			XCTAssertEqual(textField.text!, "")
		}
        
        func testSetPlaceHolderTextColor() {
            let textField = UITextField()
            textField.attributedPlaceholder = NSAttributedString(string: "Attributed Placeholder")
            textField.setPlaceHolderTextColor(.blue)
            let color = textField.attributedPlaceholder?.attribute(NSForegroundColorAttributeName, at: 0, effectiveRange: nil) as? UIColor
            XCTAssertEqual(color, .blue)
        }
	}
#endif
