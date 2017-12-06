//
//  UIFontExtensionsTest.swift
//  SwifterSwift
//
//  Created by Benjamin Meyer on 9/16/17.
//  Copyright © 2016 SwifterSwift
//

#if os(iOS) || os(tvOS) || os(watchOS)
import XCTest
@testable import SwifterSwift

final class UIFontExtension: XCTestCase {
	
	func testMonospacedDigitFont() {
		let font = UIFont.preferredFont(forTextStyle: .body)
		let monoFont = font.monospaced
	
		let attributes = monoFont.fontDescriptor.fontAttributes
		guard let settings = attributes[UIFontDescriptor.AttributeName.featureSettings] as? [[UIFontDescriptor.AttributeName: Int]] else {
			XCTFail("Unable to get settings from font")
			return
		}
		
		guard let selector = settings.first?[.init("CTFeatureSelectorIdentifier")] else {
			XCTFail("Unable to get selector from font")
			return
		}
		
		guard let space = settings.first?[.init("CTFeatureTypeIdentifier")] else {
			XCTFail("Unable to get space from font")
			return
		}
		
		XCTAssertEqual(selector, kMonospacedNumbersSelector)
		XCTAssertEqual(space, kNumberSpacingType)
		XCTAssertEqual(font.fontName, monoFont.fontName)
		XCTAssertEqual(font.familyName, monoFont.familyName)
		XCTAssertEqual(font.lineHeight, monoFont.lineHeight)
	}
}
#endif
