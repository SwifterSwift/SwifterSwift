//
//  UIFontExtensionsTest.swift
//  SwifterSwift
//
//  Created by Benjamin Meyer on 9/16/17.
//
#if os(iOS) || os(tvOS) || os(watchOS)
import XCTest
@testable import SwifterSwift
class UIFontExtension: XCTestCase {
    func testMonospacedDigitFont() {
        let font = UIFont.preferredFont(forTextStyle: .body)
        let monoFont = font.asMonospacedDigitFont()
        let attributes: [[String: Int]] =  monoFont.fontDescriptor.fontAttributes[UIFontDescriptorFeatureSettingsAttribute] as! [[String: Int]]
        XCTAssertEqual(attributes[0][UIFontFeatureTypeIdentifierKey], kNumberSpacingType)
        XCTAssertEqual(attributes[0][UIFontFeatureSelectorIdentifierKey], kMonospacedNumbersSelector)
        XCTAssertEqual(font.fontName, monoFont.fontName)
        XCTAssertEqual(font.familyName, monoFont.familyName)
        XCTAssertEqual(font.lineHeight, monoFont.lineHeight)
    }
}

#endif

