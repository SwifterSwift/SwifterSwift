// NSAttributedString+AppendingTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct NSAttributedStringAppendingTests {
    private static let color = NSAttributedString.Key("SwifterSwift.color")
    private static let weight = NSAttributedString.Key("SwifterSwift.weight")

    /// Returns the attributes at `location` and the full range they cover.
    static func run(of text: NSAttributedString, at location: Int) -> (
        attributes: [NSAttributedString.Key: Any], range: NSRange
    ) {
        var range = NSRange()
        let attributes = text.attributes(
            at: location, longestEffectiveRange: &range, in: NSRange(location: 0, length: text.length))
        return (attributes, range)
    }

    // MARK: - Appending an attributed string

    @Test
    func appendsAnAttributedStringKeepingEachPartsAttributes() {
        let hello = NSAttributedString(string: "Hello, ", attributes: [Self.weight: 400])
        let world = NSAttributedString(string: "world", attributes: [Self.color: "red"])
        let result = hello.appending(world)
        #expect(result.string == "Hello, world")

        let first = Self.run(of: result, at: 0)
        #expect(first.range == NSRange(location: 0, length: 7))
        #expect(first.attributes[Self.weight] as? Int == 400)
        #expect(first.attributes[Self.color] == nil)

        let second = Self.run(of: result, at: 7)
        #expect(second.range == NSRange(location: 7, length: 5))
        #expect(second.attributes[Self.color] as? String == "red")
        #expect(second.attributes[Self.weight] == nil)
    }

    @Test
    func mergesRunsWithTheSameAttributes() {
        let bold = NSAttributedString(string: "Hello", attributes: [Self.weight: 700])
        let result = bold.appending(NSAttributedString(string: " world", attributes: [Self.weight: 700]))
        #expect(Self.run(of: result, at: 0).range == NSRange(location: 0, length: 11))
    }

    @Test
    func doesNotModifyEitherString() {
        let hello = NSMutableAttributedString(string: "Hello", attributes: [Self.weight: 400])
        let world = NSMutableAttributedString(string: " world", attributes: [Self.color: "red"])
        let result = hello.appending(world)
        #expect(hello.string == "Hello")
        #expect(world.string == " world")
        #expect(result !== hello)

        hello.append(NSAttributedString(string: "!"))
        world.addAttribute(Self.weight, value: 900, range: NSRange(location: 0, length: world.length))
        #expect(result.string == "Hello world")
        #expect(result.attribute(Self.weight, at: 6, effectiveRange: nil) == nil)
    }

    @Test
    func appendsEmptyStrings() {
        let hello = NSAttributedString(string: "Hello", attributes: [Self.weight: 400])
        #expect(hello.appending(NSAttributedString()).isEqual(to: hello))
        #expect(NSAttributedString().appending(hello).isEqual(to: hello))
        #expect(NSAttributedString().appending(NSAttributedString()).length == 0)
    }

    @Test
    func appendsTheStringToItself() {
        let hello = NSAttributedString(string: "Hi", attributes: [Self.weight: 400])
        let result = hello.appending(hello)
        #expect(result.string == "HiHi")
        #expect(Self.run(of: result, at: 0).range == NSRange(location: 0, length: 4))
    }

    @Test
    func countsCharactersOutsideTheBasicMultilingualPlane() {
        let emoji = NSAttributedString(string: "🧑‍💻", attributes: [Self.weight: 400])
        let flags = NSAttributedString(string: "🇯🇵e\u{301}", attributes: [Self.color: "red"])
        let result = emoji.appending(flags)
        #expect(result.string == "🧑‍💻🇯🇵e\u{301}")
        let emojiLength = ("🧑‍💻" as NSString).length
        #expect(Self.run(of: result, at: 0).range == NSRange(location: 0, length: emojiLength))
        #expect(Self.run(of: result, at: emojiLength).range == NSRange(location: emojiLength, length: flags.length))
    }

    // MARK: - Appending a string

    @Test
    func appendedTextTakesTheAttributesOfTheLastCharacter() {
        let text = NSMutableAttributedString(string: "Hello", attributes: [Self.weight: 400])
        text.append(NSAttributedString(string: " world", attributes: [Self.color: "red"]))
        let result = text.appending("!")
        #expect(result.string == "Hello world!")

        let last = Self.run(of: result, at: result.length - 1)
        #expect(last.range == NSRange(location: 5, length: 7))
        #expect(last.attributes[Self.color] as? String == "red")
        #expect(last.attributes[Self.weight] == nil)
        #expect(result.attribute(Self.weight, at: 0, effectiveRange: nil) as? Int == 400)
    }

    @Test
    func appendedTextHasNoAttributesWhenTheStringIsEmpty() {
        let result = NSAttributedString().appending("Hello")
        #expect(result.string == "Hello")
        #expect(result.attributes(at: 0, effectiveRange: nil).isEmpty)
    }

    @Test
    func appendedTextHasNoAttributesWhenTheEndHasNone() {
        let text = NSMutableAttributedString(string: "Hello", attributes: [Self.weight: 400])
        text.append(NSAttributedString(string: " "))
        let result = text.appending("world")
        #expect(Self.run(of: result, at: 6).attributes.isEmpty)
        #expect(Self.run(of: result, at: 6).range == NSRange(location: 5, length: 6))
    }

    @Test
    func appendingAnEmptyStringGivesAnEqualCopy() {
        let text = NSAttributedString(string: "Hello", attributes: [Self.weight: 400])
        let result = text.appending("")
        #expect(result.isEqual(to: text))
        #expect(result !== text)
        #expect(NSAttributedString().appending("").length == 0)
    }

    @Test
    func appendingAStringDoesNotModifyTheOriginal() {
        let text = NSMutableAttributedString(string: "Hello", attributes: [Self.weight: 400])
        let result = text.appending(", world")
        #expect(text.string == "Hello")
        text.addAttribute(Self.color, value: "red", range: NSRange(location: 0, length: text.length))
        #expect(result.attribute(Self.color, at: 0, effectiveRange: nil) == nil)
    }

    @Test
    func appendedUnicodeTextIsStyledAsAWhole() {
        let text = NSAttributedString(string: "e\u{301}", attributes: [Self.color: "red"])
        let result = text.appending(" 🧑‍💻 🇯🇵 👍🏽")
        #expect(result.string == "e\u{301} 🧑‍💻 🇯🇵 👍🏽")
        #expect(Self.run(of: result, at: 0).range == NSRange(location: 0, length: result.length))
    }

    @Test
    func differsFromAppendingAnUnstyledAttributedString() {
        let text = NSAttributedString(string: "Hello", attributes: [Self.weight: 700])
        let styled = text.appending("!")
        let plain = text.appending(NSAttributedString(string: "!"))
        #expect(styled.string == plain.string)
        #expect(styled.attribute(Self.weight, at: 5, effectiveRange: nil) as? Int == 700)
        #expect(plain.attribute(Self.weight, at: 5, effectiveRange: nil) == nil)
    }
}
#endif
