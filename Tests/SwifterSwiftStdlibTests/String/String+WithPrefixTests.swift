// String+WithPrefixTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct StringWithPrefixTests {
    @Test
    func addsMissingPrefix() {
        #expect("www.apple.com".withPrefix("https://") == "https://www.apple.com")
        #expect("".withPrefix("prefix") == "prefix")
        #expect("🙂".withPrefix("👋🏽 ") == "👋🏽 🙂")
    }

    @Test
    func keepsExistingPrefix() {
        #expect("https://www.apple.com".withPrefix("https://") == "https://www.apple.com")
        #expect("prefix".withPrefix("prefix") == "prefix")
        #expect("\u{E9}t\u{E9}".withPrefix("e\u{301}") == "\u{E9}t\u{E9}")
    }

    @Test
    func matchesCaseSensitively() {
        #expect("HTTPS://apple.com".withPrefix("https://") == "https://HTTPS://apple.com")
    }

    @Test
    func doesNotMatchPartOfACharacter() {
        #expect("e\u{301}".withPrefix("e") == "ee\u{301}")
    }

    @Test(arguments: ["", "text"])
    func returnsStringUnchangedForEmptyPrefix(_ string: String) {
        #expect(string.withPrefix("") == string)
    }
}
