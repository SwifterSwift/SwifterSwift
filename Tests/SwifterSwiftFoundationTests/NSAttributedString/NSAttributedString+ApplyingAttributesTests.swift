// NSAttributedString+ApplyingAttributesTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct NSAttributedStringApplyingAttributesTests {
    private static let color = NSAttributedString.Key("SwifterSwift.color")
    private static let weight = NSAttributedString.Key("SwifterSwift.weight")

    @Test
    func addsTheAttributesToTheWholeString() {
        let text = NSAttributedString(string: "Hello, world")
        let result = text.applying(attributes: [Self.color: "red", Self.weight: 700])
        var range = NSRange()
        let attributes = result.attributes(at: 0, longestEffectiveRange: &range, in: NSRange(location: 0, length: 12))
        #expect(range == NSRange(location: 0, length: 12))
        #expect(attributes[Self.color] as? String == "red")
        #expect(attributes[Self.weight] as? Int == 700)
        #expect(result.string == "Hello, world")
    }

    @Test
    func keepsOtherAttributesAndReplacesMatchingOnes() {
        let text = NSMutableAttributedString(string: "Hello", attributes: [Self.weight: 400])
        text.append(NSAttributedString(string: " world", attributes: [Self.color: "blue"]))
        let result = text.applying(attributes: [Self.color: "red"])

        let first = result.attributes(at: 0, effectiveRange: nil)
        #expect(first[Self.weight] as? Int == 400)
        #expect(first[Self.color] as? String == "red")
        let second = result.attributes(at: 6, effectiveRange: nil)
        #expect(second[Self.weight] == nil)
        #expect(second[Self.color] as? String == "red")
    }

    @Test
    func doesNotModifyTheOriginal() {
        let text = NSMutableAttributedString(string: "Hello", attributes: [Self.weight: 400])
        let result = text.applying(attributes: [Self.weight: 700])
        #expect(text.attribute(Self.weight, at: 0, effectiveRange: nil) as? Int == 400)
        #expect(result.attribute(Self.weight, at: 0, effectiveRange: nil) as? Int == 700)
        #expect(result !== text)
    }

    @Test
    func returnsAnEqualCopyForNoAttributes() {
        let text = NSAttributedString(string: "Hello", attributes: [Self.weight: 400])
        #expect(text.applying(attributes: [:]).isEqual(to: text))
    }

    @Test
    func handlesAnEmptyString() {
        let result = NSAttributedString(string: "").applying(attributes: [Self.color: "red"])
        #expect(result.length == 0)
        #expect(result.string.isEmpty)
    }

    @Test
    func coversCharactersOutsideTheBasicMultilingualPlane() {
        let text = NSAttributedString(string: "🧑‍💻 🇯🇵 e\u{301}")
        let result = text.applying(attributes: [Self.color: "red"])
        var range = NSRange()
        _ = result.attribute(
            Self.color, at: 0, longestEffectiveRange: &range, in: NSRange(location: 0, length: result.length))
        #expect(range == NSRange(location: 0, length: (text.string as NSString).length))
    }
}
#endif
