// NSAttributedString+ApplyingAttributesToRangesMatchingOptionsTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct NSAttributedStringApplyingAttributesToRangesMatchingOptionsTests {
    private static let mark = NSAttributedString.Key("SwifterSwift.mark")

    /// The substrings that carry the mark attribute, in order.
    private static func markedSubstrings(of text: NSAttributedString) -> [String] {
        var substrings: [String] = []
        text.enumerateAttribute(mark, in: NSRange(location: 0, length: text.length), options: []) { value, range, _ in
            if value != nil {
                substrings.append(text.attributedSubstring(from: range).string)
            }
        }
        return substrings
    }

    @Test
    func appliesTheAttributesToEveryMatch() throws {
        let text = NSAttributedString(string: "Call 555-0100 or 555-0199 today")
        let result = try text.applying(attributes: [Self.mark: true], toRangesMatching: #"\d{3}-\d{4}"#)
        #expect(Self.markedSubstrings(of: result) == ["555-0100", "555-0199"])
        #expect(result.string == text.string)
    }

    @Test
    func usesTheOptions() throws {
        let text = NSAttributedString(string: "Your email is sTeVe.jObS@apple.com!")
        let caseSensitive = try text.applying(attributes: [Self.mark: true], toRangesMatching: #"steve\.jobs"#)
        #expect(Self.markedSubstrings(of: caseSensitive).isEmpty)

        let caseInsensitive = try text.applying(
            attributes: [Self.mark: true],
            toRangesMatching: #"steve\.jobs"#,
            options: .caseInsensitive
        )
        #expect(Self.markedSubstrings(of: caseInsensitive) == ["sTeVe.jObS"])
    }

    @Test
    func throwsForAnInvalidPattern() {
        let text = NSAttributedString(string: "Hello")
        #expect(throws: (any Error).self) {
            try text.applying(attributes: [Self.mark: true], toRangesMatching: "(unclosed")
        }
        #expect(throws: (any Error).self) {
            try text.applying(attributes: [Self.mark: true], toRangesMatching: "[")
        }
    }

    @Test
    func returnsAnEqualCopyWhenNothingMatches() throws {
        let text = NSAttributedString(string: "Hello", attributes: [Self.mark: false])
        let result = try text.applying(attributes: [Self.mark: true], toRangesMatching: #"\d+"#)
        #expect(result.isEqual(to: text))
    }

    @Test
    func skipsEmptyMatches() throws {
        let text = NSAttributedString(string: "abc")
        let result = try text.applying(attributes: [Self.mark: true], toRangesMatching: "x*")
        #expect(Self.markedSubstrings(of: result).isEmpty)
    }

    @Test
    func usesUTF16RangesForEmojiAndCombiningMarks() throws {
        let text = NSAttributedString(string: "👋🏽 café 🇫🇷 cafe\u{301}")
        let result = try text.applying(attributes: [Self.mark: true], toRangesMatching: "caf(é|e\u{301})")
        #expect(Self.markedSubstrings(of: result) == ["café", "cafe\u{301}"])
    }

    @Test
    func handlesAnEmptyString() throws {
        let result = try NSAttributedString(string: "").applying(attributes: [Self.mark: true], toRangesMatching: ".*")
        #expect(result.length == 0)
    }

    @Test
    func doesNotModifyTheOriginal() throws {
        let text = NSMutableAttributedString(string: "abc")
        _ = try text.applying(attributes: [Self.mark: true], toRangesMatching: "b")
        #expect(Self.markedSubstrings(of: text).isEmpty)
    }
}
#endif
