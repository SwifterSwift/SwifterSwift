// String+HasPrefixTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct StringHasPrefixTests {
    @Test(arguments: [
        ("Hello, World!", "hello"),
        ("Hello, World!", "HELLO, WORLD!"),
        ("hello World", "H"),
        ("Straße 5", "STRASSE"),
        ("STRASSE 5", "straße"),
        ("ÉCOLE", "école"),
        ("ΣΊΣΥΦΟΣ", "σίσυφος"),
        ("ISTANBUL", "istanbul"),
        ("👋🏽 Hi", "👋🏽")
    ])
    func matchesCaseInsensitively(_ string: String, _ prefix: String) {
        #expect(string.hasPrefix(prefix, caseSensitive: false))
    }

    @Test(arguments: [
        ("Hello, World!", "World"),
        ("Hello", "Hello, World!"),
        ("é", "e"),
        ("e\u{301}x", "e"),
        ("", "a"),
        ("👋🏽 Hi", "👋")
    ])
    func rejectsMissingPrefixCaseInsensitively(_ string: String, _ prefix: String) {
        #expect(!string.hasPrefix(prefix, caseSensitive: false))
    }

    @Test
    func matchesExactlyWhenCaseSensitive() {
        #expect("Hello, World!".hasPrefix("Hello", caseSensitive: true))
        #expect(!"Hello, World!".hasPrefix("hello", caseSensitive: true))
        #expect(!"Straße".hasPrefix("STRASSE", caseSensitive: true))
    }

    @Test
    func matchesCanonicallyEquivalentCharacters() {
        #expect("\u{E9}cole".hasPrefix("e\u{301}", caseSensitive: true))
        #expect("\u{E9}cole".hasPrefix("E\u{301}", caseSensitive: false))
    }

    @Test(arguments: [true, false])
    func acceptsEmptyPrefix(_ caseSensitive: Bool) {
        #expect("Hello".hasPrefix("", caseSensitive: caseSensitive))
        #expect("".hasPrefix("", caseSensitive: caseSensitive))
    }
}
#endif
