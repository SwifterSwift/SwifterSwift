// String+FirstCharacterUppercasedTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct StringFirstCharacterUppercasedTests {
    @Test(arguments: [
        ("hello world", "Hello world"),
        ("Hello world", "Hello world"),
        ("h", "H"),
        ("iPhone", "IPhone"),
        ("élan", "Élan"),
        ("e\u{301}lan", "E\u{301}lan"),
        ("ßtadt", "Sstadt"),
        ("ǆemal", "ǅemal"),
        ("ωmega", "Ωmega"),
        ("hELLO", "HELLO")
    ])
    func capitalizesOnlyTheFirstCharacter(_ string: String, _ expected: String) {
        #expect(string.firstCharacterUppercased() == expected)
    }

    @Test(arguments: ["", "1abc", "😀 smile", " leading space", "日本"])
    func returnsStringUnchangedWhenFirstCharacterHasNoCase(_ string: String) {
        #expect(string.firstCharacterUppercased() == string)
    }
}
