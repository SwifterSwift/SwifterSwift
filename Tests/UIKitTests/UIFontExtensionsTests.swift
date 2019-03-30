//
//  UIFontExtensionsTests.swift
//  SwifterSwift
//
//  Created by Benjamin Meyer on 9/16/17.
//  Copyright © 2016 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if canImport(UIKit)
import UIKit

final class UIFontExtension: XCTestCase {

    func testBold() {
        let font = UIFont.preferredFont(forTextStyle: .body)
        let boldFont = font.bold
        XCTAssert(boldFont.fontDescriptor.symbolicTraits.contains(.traitBold))
    }

    func testItalic() {
        let font = UIFont.preferredFont(forTextStyle: .body)
        let italicFont = font.italic
        XCTAssert(italicFont.fontDescriptor.symbolicTraits.contains(.traitItalic))
    }

    func testMonospacedDigitFont() {
        let font = UIFont.preferredFont(forTextStyle: .body)
        let monoFont = font.monospaced

        let attributes = monoFont.fontDescriptor.fontAttributes
        let fontKey: UIFontDescriptor.AttributeName = UIFontDescriptor.AttributeName.featureSettings
        guard let settings = attributes[fontKey] as? [[UIFontDescriptor.AttributeName: Int]] else {
            XCTFail("Unable to get settings from font")
            return
        }

        guard let selector = settings.first?[UIFontDescriptor.AttributeName(rawValue: "CTFeatureSelectorIdentifier")] else {
            XCTFail("Unable to get selector from font")
            return
        }

        guard let space = settings.first?[UIFontDescriptor.AttributeName(rawValue: "CTFeatureTypeIdentifier")] else {
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
