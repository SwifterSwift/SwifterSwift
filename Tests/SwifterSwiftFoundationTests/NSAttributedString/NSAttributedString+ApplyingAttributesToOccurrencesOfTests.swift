// NSAttributedString+ApplyingAttributesToOccurrencesOfTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct NSAttributedStringApplyingAttributesToOccurrencesOfTests {
    private static let mark = NSAttributedString.Key("SwifterSwift.mark")

    /// The ranges, in UTF-16 offsets, of the runs that carry the mark attribute.
    private static func markedRanges(of text: NSAttributedString) -> [NSRange] {
        var ranges: [NSRange] = []
        text.enumerateAttribute(mark, in: NSRange(location: 0, length: text.length), options: []) { value, range, _ in
            if value != nil {
                ranges.append(range)
            }
        }
        return ranges
    }

    @Test
    func appliesTheAttributesToEveryOccurrence() {
        let text = NSAttributedString(string: "Hello, Steve Wozniak. Bye, Steve Wozniak.")
        let result = text.applying(attributes: [Self.mark: true], toOccurrencesOf: "Steve Wozniak")
        #expect(Self.markedRanges(of: result) == [NSRange(location: 7, length: 13), NSRange(location: 27, length: 13)])
        #expect(result.string == text.string)
    }

    @Test
    func matchesCaseSensitively() {
        let text = NSAttributedString(string: "Swift swift SWIFT")
        let result = text.applying(attributes: [Self.mark: true], toOccurrencesOf: "swift")
        #expect(Self.markedRanges(of: result) == [NSRange(location: 6, length: 5)])
    }

    @Test(arguments: [#"\E"#, #"a\Eb"#, ".", "a.b", "(", "[x]", "$1", "*"])
    func treatsTheTargetLiterally(_ target: String) {
        // The targets include regular expression syntax, such as `\E`, which ends a `\Q…\E` quoted pattern.
        let text = NSAttributedString(string: "axb ab " + target)
        let result = text.applying(attributes: [Self.mark: true], toOccurrencesOf: target)
        let length = (target as NSString).length
        #expect(Self.markedRanges(of: result) == [NSRange(location: 7, length: length)])
    }

    @Test
    func findsOccurrencesThatDontOverlap() {
        let text = NSAttributedString(string: "aaaa")
        let result = text.applying(attributes: [Self.mark: true], toOccurrencesOf: "aa")
        // Adjacent runs with equal values merge, so the marked range covers all four characters.
        #expect(Self.markedRanges(of: result) == [NSRange(location: 0, length: 4)])

        let spaced = NSAttributedString(string: "aaa")
        let spacedResult = spaced.applying(attributes: [Self.mark: true], toOccurrencesOf: "aa")
        #expect(Self.markedRanges(of: spacedResult) == [NSRange(location: 0, length: 2)])
    }

    @Test
    func matchesWholeCharactersOnly() {
        let flags = NSAttributedString(string: "🇺🇸🇫🇷")
        #expect(Self.markedRanges(of: flags.applying(attributes: [Self.mark: true], toOccurrencesOf: "🇸🇫")).isEmpty)
        #expect(
            Self.markedRanges(of: flags.applying(attributes: [Self.mark: true], toOccurrencesOf: "🇫🇷"))
                == [NSRange(location: 4, length: 4)]
        )

        let accent = NSAttributedString(string: "cafe\u{301}")
        #expect(Self.markedRanges(of: accent.applying(attributes: [Self.mark: true], toOccurrencesOf: "e")).isEmpty)
        // A precomposed "é" is canonically equivalent to "e" followed by a combining accent.
        #expect(
            Self.markedRanges(of: accent.applying(attributes: [Self.mark: true], toOccurrencesOf: "é"))
                == [NSRange(location: 3, length: 2)]
        )
    }

    @Test
    func acceptsSubstrings() {
        let text = NSAttributedString(string: "one two one")
        let source = "say one"
        let target = source[source.index(source.startIndex, offsetBy: 4)...]
        let result = text.applying(attributes: [Self.mark: true], toOccurrencesOf: target)
        #expect(Self.markedRanges(of: result) == [NSRange(location: 0, length: 3), NSRange(location: 8, length: 3)])
    }

    @Test
    func returnsAnEqualCopyForAnEmptyOrMissingTarget() {
        let text = NSAttributedString(string: "Hello", attributes: [Self.mark: false])
        #expect(text.applying(attributes: [Self.mark: true], toOccurrencesOf: "").isEqual(to: text))
        #expect(text.applying(attributes: [Self.mark: true], toOccurrencesOf: "world").isEqual(to: text))
        #expect(
            NSAttributedString(string: "").applying(attributes: [Self.mark: true], toOccurrencesOf: "a").length == 0)
    }

    @Test
    func doesNotModifyTheOriginal() {
        let text = NSMutableAttributedString(string: "abc")
        _ = text.applying(attributes: [Self.mark: true], toOccurrencesOf: "b")
        #expect(Self.markedRanges(of: text).isEmpty)
    }
}
#endif
