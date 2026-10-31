// String+HasSuffixTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct StringHasSuffixTests {
    @Test(arguments: [
        ("Hello, World!", "WORLD!"),
        ("Hello, World!", "hello, world!"),
        ("photo.JPG", ".jpg"),
        ("Hauptstraße", "STRASSE"),
        ("CAFÉ", "é"),
        ("ΣΊΣΥΦΟΣ", "φος"),
        ("Hi 👋🏽", "👋🏽")
    ])
    func matchesCaseInsensitively(_ string: String, _ suffix: String) {
        #expect(string.hasSuffix(suffix, caseSensitive: false))
    }

    @Test(arguments: [
        ("Hello, World!", "Hello"),
        ("World!", "Hello, World!"),
        ("café", "e"),
        ("cafe\u{301}", "e"),
        ("", "a"),
        ("Hi 👋🏽", "🏽")
    ])
    func rejectsMissingSuffixCaseInsensitively(_ string: String, _ suffix: String) {
        #expect(!string.hasSuffix(suffix, caseSensitive: false))
    }

    @Test
    func matchesExactlyWhenCaseSensitive() {
        #expect("Hello, World!".hasSuffix("World!", caseSensitive: true))
        #expect(!"Hello, World!".hasSuffix("WORLD!", caseSensitive: true))
        #expect(!"photo.JPG".hasSuffix(".jpg", caseSensitive: true))
    }

    @Test
    func matchesCanonicallyEquivalentCharacters() {
        #expect("caf\u{E9}".hasSuffix("e\u{301}", caseSensitive: true))
        #expect("CAF\u{C9}".hasSuffix("e\u{301}", caseSensitive: false))
    }

    @Test(arguments: [true, false])
    func acceptsEmptySuffix(_ caseSensitive: Bool) {
        #expect("Hello".hasSuffix("", caseSensitive: caseSensitive))
        #expect("".hasSuffix("", caseSensitive: caseSensitive))
    }
}
#endif
