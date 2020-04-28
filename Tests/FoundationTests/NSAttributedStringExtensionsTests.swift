//
//  NSAttributedStringTests.swift
//  SwifterSwift
//
//  Created by Ewelina on 26/01/2017.
//  Copyright © 2017 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if canImport(Foundation)
import Foundation

// swiftlint:disable:next type_body_length
final class NSAttributedStringExtensionsTests: XCTestCase {

    func testBolded() {
        #if os(iOS)
        let string = NSAttributedString(string: "Bolded")
        let out = string.bolded
        let attributes = out.attributes(at: 0, effectiveRange: nil)

        let filterClosure: (NSAttributedString.Key, Any) -> Bool = {key, value in
            return (key == NSAttributedString.Key.font && ((value as? UIFont) == .boldSystemFont(ofSize: UIFont.systemFontSize)))
        }

        let filteredAttributes = attributes.filter { filterClosure($0, $1) }
        XCTAssertEqual(filteredAttributes.count, 1)
        #endif
    }

    func testUnderlined() {
        #if !os(Linux)
        let string = NSAttributedString(string: "Underlined")
        let out = string.underlined
        let attributes = out.attributes(at: 0, effectiveRange: nil)
        let filteredAttributes = attributes.filter { (key, value) -> Bool in
            return (key == NSAttributedString.Key.underlineStyle &&
                (value as? NSUnderlineStyle.RawValue) == NSUnderlineStyle.single.rawValue)
        }

        XCTAssertEqual(filteredAttributes.count, 1)
        #endif
    }

    func testItalicized() {
        #if os(iOS)
        let string = NSAttributedString(string: "Italicized")
        let out = string.italicized
        let attributes = out.attributes(at: 0, effectiveRange: nil)
        let filteredAttributes = attributes.filter { (key, value) -> Bool in
            return (key == NSAttributedString.Key.font && (value as? UIFont) == .italicSystemFont(ofSize: UIFont.systemFontSize))
        }

        XCTAssertEqual(filteredAttributes.count, 1)
        #endif
    }

    func testStruckthrough() {
        #if !os(macOS) && !os(Linux)
        let string = NSAttributedString(string: "Struck through")
        let out = string.struckthrough
        let attributes = out.attributes(at: 0, effectiveRange: nil)
        let filteredAttributes = attributes.filter { (key, value) -> Bool in
            return (key == NSAttributedString.Key.strikethroughStyle && (value as? NSUnderlineStyle.RawValue) == NSUnderlineStyle.single.rawValue)
        }

        XCTAssertEqual(filteredAttributes.count, 1)
        #endif
    }

    // MARK: - Methods
    func testApplying() {
        #if canImport(AppKit) || canImport(UIKit)
        let string = NSAttributedString(string: "Applying")
        var out = string.applying(attributes: [:])
        var attributes = out.attributes(at: 0, effectiveRange: nil)
        XCTAssertTrue(attributes.isEmpty)

        out = string.applying(attributes: [
            .strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue),
            .foregroundColor: Color.red
        ])
        attributes = out.attributes(at: 0, effectiveRange: nil)
        XCTAssertEqual(attributes.count, 2)
        XCTAssertEqual(attributes[.strikethroughStyle] as! NSNumber, NSNumber(value: NSUnderlineStyle.single.rawValue)) // swiftlint:disable:this force_cast
        XCTAssertEqual(attributes[.foregroundColor] as! Color, .red) // swiftlint:disable:this force_cast
        #endif
    }

    func testColored() {
        #if canImport(AppKit) || canImport(UIKit)
        let string = NSAttributedString(string: "Colored")
        var out = string.colored(with: .red)
        var attributes = out.attributes(at: 0, effectiveRange: nil)
        let filteredAttributes = attributes.filter { (key, value) -> Bool in
            return (key == NSAttributedString.Key.foregroundColor && (value as? Color) == .red)
        }

        XCTAssertEqual(filteredAttributes.count, 1)

        out = out.colored(with: .blue)
        attributes = out.attributes(at: 0, effectiveRange: nil)
        XCTAssertEqual(attributes[NSAttributedString.Key.foregroundColor] as? Color, .blue)
        XCTAssertNotEqual(attributes[NSAttributedString.Key.foregroundColor] as? Color, .red)
        #endif
    }

    func testApplyingToRegex() {
        #if canImport(UIKit) && os(iOS)
        let email = "sTeVe.jObS@apple.com"
        let testString = NSAttributedString(string: "Your email is \(email)!").bolded
        let attributes: [NSAttributedString.Key: Any] = [.underlineStyle: NSUnderlineStyle.single.rawValue, .foregroundColor: UIColor.blue]
        let casePattern = "Steve\\.Jobs"

        // Case sensitive
        caseSensitiveRegexTest(testString, attributes: attributes, pattern: casePattern)
        // Common
        commonRegexTest(stringToTest: testString, attributes: attributes, email)
        #endif
    }

    #if canImport(UIKit) && os(iOS)
    private func caseSensitiveRegexTest(_ stringToTest: NSAttributedString, attributes: [NSAttributedString.Key: Any], pattern: String) {
        let stringRange = NSRange(0..<stringToTest.length)

        // Apply case insensitive option for success attributes applying
        let caseInsensitiveAttrString = stringToTest.applying(attributes: attributes, toRangesMatching: pattern, options: [.caseInsensitive])
        var caseInsensitiveUnderlineIndicator: Int?
        var caseInsensitiveTextColor: UIColor?
        caseInsensitiveAttrString.enumerateAttribute(.underlineStyle, in: stringRange) { value, range, stop in
            guard let value = value as? Int else { return }
            // Save found values and stop enumeration
            caseInsensitiveUnderlineIndicator = value
            caseInsensitiveTextColor = caseInsensitiveAttrString.attribute(.foregroundColor, at: range.location, effectiveRange: nil) as? UIColor
            stop.pointee = true
        }
        XCTAssertEqual(caseInsensitiveUnderlineIndicator, 1)
        XCTAssertEqual(caseInsensitiveTextColor, .blue)

        // Apply no options for failure attributes applying
        let caseSensitiveAttrString = stringToTest.applying(attributes: attributes, toRangesMatching: pattern)
        var caseSensitiveUnderlineIndicator: Int?
        var caseSensitiveTextColor: UIColor?
        caseSensitiveAttrString.enumerateAttribute(.underlineStyle, in: stringRange) { value, range, stop in
            guard let value = value as? Int else { return }
            // Save found values and stop enumeration
            caseSensitiveUnderlineIndicator = value
            caseSensitiveTextColor = caseInsensitiveAttrString.attribute(.foregroundColor, at: range.location, effectiveRange: nil) as? UIColor
            stop.pointee = true
        }
        XCTAssertNotEqual(caseSensitiveUnderlineIndicator, 1)
        XCTAssertNotEqual(caseSensitiveTextColor, .blue)
    }
    #endif

    #if canImport(UIKit) && os(iOS)
    private func commonRegexTest(stringToTest: NSAttributedString, attributes: [NSAttributedString.Key: Any], _ email: String) {
        let stringRange = NSRange(0..<stringToTest.length)
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let attrTestString = stringToTest.applying(attributes: attributes, toRangesMatching: pattern)

        let attrAtBeginning = attrTestString.attributes(at: 0, effectiveRange: nil)
        XCTAssert(attrAtBeginning.count == 1)

        var passed = false
        // iterate through each range of attributes
        attrTestString.enumerateAttributes(in: stringRange, options: .longestEffectiveRangeNotRequired) { attrs, range, _ in

            // exit if there are not more attributes for the subsequence than what was there originally
            guard attrs.count > attrAtBeginning.count else { return }

            let emailFromRange = attrTestString.attributedSubstring(from: range).string
            // confirm that the string with the applied attributes is the email
            XCTAssertEqual(emailFromRange, email)

            // the range contains the email, check to make sure the attributes are there and correct
            for attr in attrs {
                if attr.key == .underlineStyle {
                    XCTAssertEqual(attr.value as? NSUnderlineStyle.RawValue, NSUnderlineStyle.single.rawValue)
                    passed = true
                } else if attr.key == .foregroundColor {
                    XCTAssertEqual(attr.value as? UIColor, UIColor.blue)
                    passed = true
                } else if attr.key == .font {
                    XCTAssertEqual((attr.value as? UIFont), .boldSystemFont(ofSize: UIFont.systemFontSize))
                } else {
                    passed = false
                }
            }

            XCTAssert(passed)
        }
    }
    #endif

    func testApplyingToOccurrences() {
        #if canImport(UIKit) && os(iOS)
        let name = "Steve Wozniak"
        let greeting = "Hello, \(name)."
        let attrGreeting = NSAttributedString(string: greeting).italicized.applying(
            attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue,
                         .foregroundColor: UIColor.red], toOccurrencesOf: name)

        let attrAtBeginning = attrGreeting.attributes(at: 0, effectiveRange: nil)
        // assert that there is only one attribute at beginning from italics
        XCTAssertEqual(attrAtBeginning.count, 1)

        var passed = false
        // iterate through each range of attributes
        attrGreeting.enumerateAttributes(in: NSRange(0..<attrGreeting.length), options: .longestEffectiveRangeNotRequired) { attrs, range, _ in
            // exit if there are not more attributes for the subsequence than what was there originally
            guard attrs.count > attrAtBeginning.count else { return }

            // confirm that the attributed string is the name
            let stringAtRange = attrGreeting.attributedSubstring(from: range).string
            XCTAssertEqual(stringAtRange, name)

            for attr in attrs {
                if attr.key == .underlineStyle {
                    XCTAssertEqual(attr.value as? NSUnderlineStyle.RawValue, NSUnderlineStyle.single.rawValue)
                    passed = true
                } else if attr.key == .foregroundColor {
                    XCTAssertEqual(attr.value as? UIColor, UIColor.red)
                    passed = true
                } else if attr.key == .font {
                    XCTAssertEqual((attr.value as? UIFont), .italicSystemFont(ofSize: UIFont.systemFontSize))
                } else {
                    passed = false
                }
            }
        }

        XCTAssert(passed)
        #endif
    }

    func testAppending() {
        #if os(iOS)
        var string = NSAttributedString(string: "Test").italicized.underlined.struckthrough
        string += NSAttributedString(string: " Appending").bolded

        XCTAssertEqual(string.string, "Test Appending")

        var attributes = string.attributes(at: 0, effectiveRange: nil)
        var filteredAttributes = attributes.filter { (key, value) -> Bool in
            var valid = false
            if key == NSAttributedString.Key.font, let value = value as? UIFont, value == .italicSystemFont(ofSize: UIFont.systemFontSize) {
                valid = true
            }
            if key == NSAttributedString.Key.underlineStyle, let value = value as? NSUnderlineStyle.RawValue, value == NSUnderlineStyle.single.rawValue {
                valid = true
            }
            if key == NSAttributedString.Key.strikethroughStyle, let value = value as? NSUnderlineStyle.RawValue, value == NSUnderlineStyle.single.rawValue {
                valid = true
            }

            return valid
        }

        XCTAssertEqual(filteredAttributes.count, 3)

        attributes = string.attributes(at: 5, effectiveRange: nil)
        filteredAttributes = attributes.filter { (key, value) -> Bool in
            return (key == NSAttributedString.Key.font && (value as? UIFont) == .boldSystemFont(ofSize: UIFont.systemFontSize))
        }

        XCTAssertEqual(filteredAttributes.count, 1)
        #endif
    }

    func testAttributes() {
        #if os(iOS)
        let emptyString = NSAttributedString(string: "").bolded.struckthrough.underlined.colored(with: UIColor.blue)
        let emptyStringAttributes = emptyString.attributes
        XCTAssert(emptyStringAttributes.isEmpty)

        let attrString = NSAttributedString(string: "Test String").bolded.struckthrough.underlined.colored(with: UIColor.blue)
        let attributes = attrString.attributes

        XCTAssertEqual(attributes.count, 4)

        let filteredAttributes = attributes.filter { (key, value) -> Bool in
            switch key {
            case NSAttributedString.Key.underlineStyle:
                return (value as? NSUnderlineStyle.RawValue) == NSUnderlineStyle.single.rawValue
            case NSAttributedString.Key.strikethroughStyle:
                return (value as? NSUnderlineStyle.RawValue) == NSUnderlineStyle.single.rawValue
            case NSAttributedString.Key.font:
                return (value as? UIFont) == .boldSystemFont(ofSize: UIFont.systemFontSize)
            case NSAttributedString.Key.foregroundColor:
                return (value as? UIColor) == .blue
            default:
                return false
            }
        }

        XCTAssertEqual(filteredAttributes.count, 4)
        #endif
    }

    // MARK: - Operators
    func testOperators() {
        #if os(iOS)
        var string1 = NSAttributedString(string: "Test").italicized.underlined.struckthrough
        let string2 = NSAttributedString(string: " Appending").bolded
        XCTAssertEqual((string1 + string2).string, "Test Appending")
        XCTAssertEqual((string1 + string2.string).string, "Test Appending")

        string1 += string2.string
        XCTAssertEqual(string1.string, "Test Appending")
        #endif
    }

}

#endif
