// String+SlugifiedTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct StringSlugifiedTests {
    @Test(arguments: [
        ("Swift is amazing", "swift-is-amazing"),
        ("  A nice & hög _ Str    ", "a-nice-hog-str"),
        ("  Crème Brûlée & Café!  ", "creme-brulee-cafe"),
        ("a   b", "a-b"),
        ("a - b", "a-b"),
        ("--a--b--", "a-b"),
        ("Don't stop me now", "dont-stop-me-now"),
        ("It’s 2026", "its-2026"),
        ("Straße", "strasse"),
        ("ＦＵＬＬ　Width", "full-width"),
        ("Ærøskøbing", "ærøskøbing"),
        ("Привет, мир", "привет-мир"),
        ("İstanbul", "istanbul"),
        ("e\u{301}clair", "eclair"),
        ("Version 9.0.0", "version-9-0-0"),
        ("snake_case_name", "snake-case-name"),
        ("camelCaseName", "camelcasename"),
        ("emoji 🚀 rocket", "emoji-rocket"),
        ("already-a-slug", "already-a-slug")
    ])
    func convertsToSlug(_ string: String, _ expected: String) {
        #expect(string.slugified() == expected)
    }

    @Test(arguments: ["", " ", "---", "& ! ?", "🚀🎉", "'"])
    func returnsEmptyStringWithoutLettersOrNumbers(_ string: String) {
        #expect(string.slugified().isEmpty)
    }

    @Test
    func isIdempotent() {
        let slug = "  Crème Brûlée & Café!  ".slugified()
        #expect(slug.slugified() == slug)
    }
}
#endif
