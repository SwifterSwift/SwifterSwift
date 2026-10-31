// Sequence+JoinedTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct SequenceJoinedTests {
    private static let color = NSAttributedString.Key("SwifterSwift.color")
    private static let weight = NSAttributedString.Key("SwifterSwift.weight")

    private static var words: [NSAttributedString] {
        [
            NSAttributedString(string: "Hello", attributes: [color: "red"]),
            NSAttributedString(string: " "),
            NSAttributedString(string: "World", attributes: [weight: 700])
        ]
    }

    @Test
    func joinsWithAnAttributedSeparator() {
        let separator = NSAttributedString(string: " | ", attributes: [Self.color: "gray"])
        let result = Self.words.joined(separator: separator)

        let expected = NSMutableAttributedString()
        expected.append(NSAttributedString(string: "Hello", attributes: [Self.color: "red"]))
        expected.append(separator)
        expected.append(NSAttributedString(string: " "))
        expected.append(separator)
        expected.append(NSAttributedString(string: "World", attributes: [Self.weight: 700]))
        #expect(result.isEqual(to: expected))
        #expect(result.string == "Hello |   | World")
    }

    @Test
    func joinsWithAPlainSeparatorThatHasNoAttributes() {
        let result = Self.words.joined(separator: ", ")
        #expect(result.string == "Hello,  , World")
        #expect(result.attributes(at: 5, effectiveRange: nil).isEmpty)
        #expect(result.attribute(Self.color, at: 0, effectiveRange: nil) as? String == "red")
        #expect(result.attribute(Self.weight, at: result.length - 1, effectiveRange: nil) as? Int == 700)
    }

    @Test
    func joinsWithEmptySeparators() {
        let expected = NSMutableAttributedString()
        for word in Self.words {
            expected.append(word)
        }
        #expect(Self.words.joined(separator: "").isEqual(to: expected))
        #expect(Self.words.joined(separator: NSAttributedString()).isEqual(to: expected))
    }

    @Test
    func returnsAnEmptyStringForAnEmptySequence() {
        let empty: [NSAttributedString] = []
        #expect(empty.joined(separator: NSAttributedString(string: "Hello")).length == 0)
        #expect(empty.joined(separator: ", ").length == 0)
    }

    @Test
    func returnsACopyOfASingleElementWithoutTheSeparator() {
        let single = [NSAttributedString(string: "Hello", attributes: [Self.color: "red"])]
        #expect(single.joined(separator: ", ").isEqual(to: single[0]))
        #expect(single.joined(separator: NSAttributedString(string: ", ")).isEqual(to: single[0]))
    }

    @Test
    func worksWithAnySequenceAndSubclassElements() {
        let numbers = (1...3).lazy.map { NSMutableAttributedString(string: "\($0)") }
        #expect(numbers.joined(separator: "-").string == "1-2-3")
        #expect(numbers.joined(separator: NSAttributedString(string: "+")).string == "1+2+3")
    }

    @Test
    func keepsEmojiAndCombiningMarksIntact() {
        let parts = [NSAttributedString(string: "🇯🇵"), NSAttributedString(string: "e\u{301}")]
        let result = parts.joined(separator: "🧑‍💻")
        #expect(result.string == "🇯🇵🧑‍💻e\u{301}")
        #expect(result.string.count == 3)
    }
}
#endif
