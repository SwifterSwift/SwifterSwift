// String+CountOfTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct StringCountOfTests {
    @Test(arguments: [
        ("Hello World!", "o", 2),
        ("Hello World!", "l", 3),
        ("Hello World!", "L", 0),
        ("Hello World!", "Hello World!", 1),
        ("Hello", "Hello World!", 0),
        ("abcabc", "abc", 2),
        ("aaaa", "aa", 2),
        ("aaa", "aa", 1),
        ("", "a", 0)
    ])
    func countsExactOccurrencesWhenCaseSensitive(_ string: String, _ substring: String, _ expected: Int) {
        #expect(string.count(of: substring, caseSensitive: true) == expected)
    }

    @Test(arguments: [
        ("Hello World!", "L", 3),
        ("Hello World!", "hello", 1),
        ("abAB aB", "ab", 3),
        ("ÉCOLE école", "école", 2),
        ("ΣΊΣΥΦΟΣ σίσυφος", "σ", 5),
        ("ǆ ǅ Ǆ", "ǆ", 3),
        ("aAaA", "aa", 2),
        ("", "a", 0)
    ])
    func countsOccurrencesIgnoringCase(_ string: String, _ substring: String, _ expected: Int) {
        #expect(string.count(of: substring, caseSensitive: false) == expected)
    }

    @Test(arguments: [true, false])
    func returnsZeroForEmptySubstring(_ caseSensitive: Bool) {
        #expect("abc".count(of: "", caseSensitive: caseSensitive) == 0)
        #expect("".count(of: "", caseSensitive: caseSensitive) == 0)
    }

    @Test(arguments: [true, false])
    func comparesWholeCharacters(_ caseSensitive: Bool) {
        // "e" followed by a combining accent is one `Character`, so a plain "e" doesn't occur inside it.
        #expect("e\u{301}x e".count(of: "e", caseSensitive: caseSensitive) == 1)
        #expect("ab\r\ncd\n".count(of: "\n", caseSensitive: caseSensitive) == 1)
        #expect("👍🏽👍👍".count(of: "👍", caseSensitive: caseSensitive) == 2)
        #expect("🧑‍💻🧑".count(of: "🧑", caseSensitive: caseSensitive) == 1)
        // The regional indicators of "🇺🇸🇸🇾" don't form "🇸🇸", because they pair up as two flags.
        #expect("🇺🇸🇸🇾".count(of: "🇸🇸", caseSensitive: caseSensitive) == 0)
        #expect("🇸🇾🇸🇾".count(of: "🇸🇾", caseSensitive: caseSensitive) == 2)
    }

    @Test(arguments: [true, false])
    func matchesCanonicallyEquivalentCharacters(_ caseSensitive: Bool) {
        // "é" as one scalar and as "e" plus a combining accent are the same character.
        #expect("caf\u{E9} cafe\u{301}".count(of: "cafe\u{301}", caseSensitive: caseSensitive) == 2)
        #expect("caf\u{E9} cafe\u{301}".count(of: "caf\u{E9}", caseSensitive: caseSensitive) == 2)
    }

    @Test
    func matchesCanonicallyEquivalentCharactersIgnoringCase() {
        #expect("caf\u{E9} cafe\u{301}".count(of: "CAF\u{C9}", caseSensitive: false) == 2)
        #expect("caf\u{E9} cafe\u{301}".count(of: "CAFE\u{301}", caseSensitive: false) == 2)
    }

    @Test(arguments: [true, false])
    func treatsRegexMetacharactersLiterally(_ caseSensitive: Bool) {
        #expect("a.b.c".count(of: ".", caseSensitive: caseSensitive) == 2)
        #expect("a*b".count(of: ".*", caseSensitive: caseSensitive) == 0)
        #expect("(1) (2)".count(of: "(", caseSensitive: caseSensitive) == 2)
        #expect("12 \\d".count(of: "\\d", caseSensitive: caseSensitive) == 1)
        #expect("$5 and $6".count(of: "$", caseSensitive: caseSensitive) == 2)
        #expect("a|b".count(of: "a|b", caseSensitive: caseSensitive) == 1)
    }

    @Test
    func comparesLowercaseFormsOneCharacterAtATime() {
        // Full case folding would match "ß" with "SS" and the "ﬁ" ligature with "fi"; this comparison doesn't.
        #expect("Straße STRASSE strasse".count(of: "SS", caseSensitive: false) == 2)
        #expect("Straße STRASSE strasse".count(of: "ß", caseSensitive: false) == 1)
        #expect("ﬁ fi FI".count(of: "fi", caseSensitive: false) == 2)
    }

    @Test
    func doesNotDependOnTheLocale() {
        // In a Turkish locale "I" lowercases to "ı", but the comparison always uses the default mapping.
        #expect("ISTANBUL istanbul".count(of: "i", caseSensitive: false) == 2)
        #expect("ISTANBUL istanbul".count(of: "ı", caseSensitive: false) == 0)
    }
}
