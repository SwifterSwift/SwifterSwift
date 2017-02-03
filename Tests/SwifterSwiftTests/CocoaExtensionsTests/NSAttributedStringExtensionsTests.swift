//
//  NSAttributedStringTests.swift
//  SwifterSwift
//
//  Created by Ewelina on 26/01/2017.
//  Copyright © 2017 omaralbeik. All rights reserved.
//

import XCTest
@testable import SwifterSwift

class NSAttributedStringExtensionsTests: XCTestCase {
	
	#if !os(macOS) && !os(tvOS)
	func testBolded() {
		let string = NSAttributedString(string: "Bolded")
		let out = string.bolded
		let attributes = out.attributes(at: 0, effectiveRange: nil)

		let filterClosure: (String, Any) -> Bool = {key, value in
			return (key == NSFontAttributeName && ((value as? UIFont) == .boldSystemFont(ofSize: UIFont.systemFontSize)))
		}

		let filteredAttributes = attributes.filter { filterClosure($0, $1) }
		XCTAssertEqual(filteredAttributes.count, 1)
	}
	#endif

	#if !os(macOS)
	func testUnderlined() {
		let string = NSAttributedString(string: "Underlined")
		let out = string.underlined
		let attributes = out.attributes(at: 0, effectiveRange: nil)
		let filteredAttributes = attributes.filter { (key, value) -> Bool in
			return (key == NSUnderlineStyleAttributeName && (value as? NSUnderlineStyle.RawValue) == NSUnderlineStyle.styleSingle.rawValue)
		}

		XCTAssertEqual(filteredAttributes.count, 1)
	}
	#endif
	
	#if !os(macOS) && !os(tvOS)
	func testItalicized() {
		let string = NSAttributedString(string: "Italicized")
		let out = string.italicized
		let attributes = out.attributes(at: 0, effectiveRange: nil)
		let filteredAttributes = attributes.filter { (key, value) -> Bool in
			return (key == NSFontAttributeName && (value as? UIFont) == .italicSystemFont(ofSize: UIFont.systemFontSize))
		}

		XCTAssertEqual(filteredAttributes.count, 1)
	}
	#endif

	#if !os(macOS)
	func testStruckthrough() {
		let string = NSAttributedString(string: "Struck through")
		let out = string.struckthrough
		let attributes = out.attributes(at: 0, effectiveRange: nil)
		let filteredAttributes = attributes.filter { (key, value) -> Bool in
			return (key == NSStrikethroughStyleAttributeName && (value as? NSUnderlineStyle.RawValue) == NSUnderlineStyle.styleSingle.rawValue)
		}

		XCTAssertEqual(filteredAttributes.count, 1)
	}
	#endif

	#if !os(macOS)
	// MARK: - Methods
	func testColored() {
		let string = NSAttributedString(string: "Colored")
		var out = string.colored(with: .red)
		var attributes = out.attributes(at: 0, effectiveRange: nil)
		let filteredAttributes = attributes.filter { (key, value) -> Bool in
			return (key == NSForegroundColorAttributeName && (value as? UIColor) == .red)
		}

		XCTAssertEqual(filteredAttributes.count, 1)

		out = out.colored(with: .blue)
		attributes = out.attributes(at: 0, effectiveRange: nil)
		XCTAssertEqual(attributes[NSForegroundColorAttributeName] as? UIColor, UIColor.blue)
		XCTAssertNotEqual(attributes[NSForegroundColorAttributeName] as? UIColor, .red)
	}
	#endif

	#if !os(macOS) && !os(tvOS)
	// MARK: - Operators
	func testAppending() {
		var string = NSAttributedString(string: "Test").italicized.underlined.struckthrough
		string += NSAttributedString(string: " Appending").bolded

		XCTAssertEqual(string.string, "Test Appending")

		var attributes = string.attributes(at: 0, effectiveRange: nil)
		var filteredAttributes = attributes.filter { (key, value) -> Bool in
			var valid = false
			if key == NSFontAttributeName, let value = value as? UIFont, value == .italicSystemFont(ofSize: UIFont.systemFontSize) {
				valid = true
			}
			if key == NSUnderlineStyleAttributeName, let value = value as? NSUnderlineStyle.RawValue, value == NSUnderlineStyle.styleSingle.rawValue {
				valid = true
			}
			if key == NSStrikethroughStyleAttributeName, let value = value as? NSUnderlineStyle.RawValue, value == NSUnderlineStyle.styleSingle.rawValue {
				valid = true
			}

			return valid
		}

		XCTAssertEqual(filteredAttributes.count, 3)

		attributes = string.attributes(at: 5, effectiveRange: nil)
		filteredAttributes = attributes.filter { (key, value) -> Bool in
			return (key == NSFontAttributeName && (value as? UIFont) == .boldSystemFont(ofSize: UIFont.systemFontSize))
		}

		XCTAssertEqual(filteredAttributes.count, 1)
	}
	#endif
}
