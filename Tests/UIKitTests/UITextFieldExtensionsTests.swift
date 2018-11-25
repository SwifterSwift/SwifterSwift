//
//  UITextFieldExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 2/15/17.
//  Copyright © 2017 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

final class UITextFieldExtensionsTests: XCTestCase {

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

    func testTextType() {
        let tf1 = UITextField(frame: .zero)
        tf1.textType = .emailAddress
        XCTAssertEqual(tf1.textType, .emailAddress)
        XCTAssertEqual(tf1.keyboardType, .emailAddress)
        XCTAssertEqual(tf1.autocorrectionType, .no)
        XCTAssertEqual(tf1.autocapitalizationType, .none)
        XCTAssertFalse(tf1.isSecureTextEntry)
        XCTAssertEqual(tf1.placeholder, "Email Address")

        let tf2 = UITextField(frame: .zero)
        tf2.textType = .password
        XCTAssertEqual(tf2.textType, .password)
        XCTAssertEqual(tf2.keyboardType, .asciiCapable)
        XCTAssertEqual(tf2.autocorrectionType, .no)
        XCTAssertEqual(tf2.autocapitalizationType, .none)
        XCTAssert(tf2.isSecureTextEntry)
        XCTAssertEqual(tf2.placeholder, "Password")

        let tf3 = UITextField(frame: .zero)
        tf3.textType = .generic
        XCTAssertEqual(tf3.textType, .generic)
        XCTAssertFalse(tf3.isSecureTextEntry)

    }

    func testHasValidEmail() {
        let textField = UITextField(frame: .zero)
        textField.text = "john@doe.com"
        XCTAssert(textField.hasValidEmail)
        textField.text = "swifterswift"
        XCTAssertFalse(textField.hasValidEmail)
        textField.text = nil
        XCTAssertFalse(textField.hasValidEmail)
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
        let color = textField.attributedPlaceholder?.attribute(.foregroundColor, at: 0, effectiveRange: nil) as? UIColor
        XCTAssertEqual(color, .blue)

        textField.placeholder = nil
        textField.setPlaceHolderTextColor(.yellow)
        let emptyColor = textField.attributedPlaceholder?.attribute(.foregroundColor, at: 0, effectiveRange: nil) as? UIColor
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

}
#endif
