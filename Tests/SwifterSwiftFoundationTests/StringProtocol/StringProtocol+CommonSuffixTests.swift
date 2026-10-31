// StringProtocol+CommonSuffixTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct StringProtocolCommonSuffixTests {
    let string = "Hello world!"

    @Test
    func returnsLongestCommonSuffix() {
        #expect(string.commonSuffix(with: "It's cold!") == "ld!")
        #expect(string.commonSuffix(with: "ld!") == "ld!")
        #expect(string.commonSuffix(with: "Hello world!") == "Hello world!")
        #expect(string.commonSuffix(with: "Say hello world!") == "ello world!")
    }

    @Test
    func returnsEmptyStringWithoutCommonSuffix() {
        #expect(string.commonSuffix(with: "Not Common").isEmpty)
        #expect(string.commonSuffix(with: "你好世界").isEmpty)
        #expect("".commonSuffix(with: "It's cold!").isEmpty)
        #expect(string.commonSuffix(with: "").isEmpty)
        #expect("".commonSuffix(with: "").isEmpty)
    }

    @Test
    func comparesCaseSensitivelyByDefault() {
        #expect(string.commonSuffix(with: "It's colD!") == "!")
        #expect(string.commonSuffix(with: "It's colD!", options: .caseInsensitive) == "ld!")
    }

    @Test
    func returnsTheReceiversCharacters() {
        #expect("HELLO".commonSuffix(with: "jello", options: .caseInsensitive) == "ELLO")
        #expect("Pelé".commonSuffix(with: "rele", options: .diacriticInsensitive) == "elé")
        #expect("Pelé".commonSuffix(with: "rele").isEmpty)
    }

    @Test
    func matchesCanonicallyEquivalentCharactersUnlessLiteral() {
        #expect("huea\u{308}hue".commonSuffix(with: "hue\u{E4}hue") == "huea\u{308}hue")
        #expect("hue\u{308}hue".commonSuffix(with: "hue\u{E4}hue", options: .literal) == "hue")
        #expect("hue\u{308}hue".commonSuffix(with: "hue\u{E4}hUe", options: [.caseInsensitive, .literal]) == "hue")
    }

    @Test
    func comparesWholeCharacters() {
        #expect("Hi 👋🏽".commonSuffix(with: "Bye 👋🏿") == "")
        #expect("Hi 👋🏽".commonSuffix(with: "Bye 👋🏽") == " 👋🏽")
        #expect("🇸🇾🇫🇷".commonSuffix(with: "🇯🇵🇫🇷") == "🇫🇷")
    }

    @Test
    func worksWithSubstrings() {
        let substring = "xxHello world!xx".dropFirst(2).dropLast(2)
        #expect(substring.commonSuffix(with: "cold!".dropFirst()) == "ld!")
    }
}
#endif
