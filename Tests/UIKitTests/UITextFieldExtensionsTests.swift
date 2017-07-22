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
		
		textField.leftView = nil
		XCTAssertNil(textField.leftViewTintColor)
		
		textField.leftViewTintColor = .yellow
		XCTAssertNil(textField.leftViewTintColor)

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
		
		textField.rightView = nil
		XCTAssertNil(textField.rightViewTintColor)
		
		textField.rightViewTintColor = .yellow
		XCTAssertNil(textField.rightViewTintColor)
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
		
		textField.placeholder = nil
		textField.setPlaceHolderTextColor(.yellow)
		let emptyColor = textField.attributedPlaceholder?.attribute(NSForegroundColorAttributeName, at: 0, effectiveRange: nil) as? UIColor
		XCTAssertNil(emptyColor)
	}
  
  func testAddPaddingLeft() {
    let textfield = UITextField()
    textfield.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
    textfield.addPaddingLeft(40)
    XCTAssertEqual(textfield.leftView?.frame.width, 40)
  }
    
    func testAddPaddingImageIcon() {
        let textfield = UITextField()
        textfield.frame = CGRect(x: 0, y: 0, width: 100, height: 44)
        
        let bundle = Bundle.init(for: UIImageExtensionsTests.self)
        let image = UIImage(named: "TestImage", in: bundle, compatibleWith: nil)!
        textfield.addPaddingLeftIcon(image, padding: 5)
        XCTAssertEqual(textfield.leftView?.frame.width, image.size.width + 5)
    }
    
    func testlimit() {
        let textfield = UITextField()
        textfield.frame = CGRect(x: 0, y: 0, width: 200, height: 30)
        textfield.text = "xxxxxxxxxxxxxxxxxxx"
        textfield.limit(16)
        NotificationCenter.default.post(name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
        XCTAssertEqual(textfield.text?.length, 16)
    }
}
#endif
