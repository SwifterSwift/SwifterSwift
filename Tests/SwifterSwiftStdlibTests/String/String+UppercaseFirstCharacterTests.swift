// String+UppercaseFirstCharacterTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct StringUppercaseFirstCharacterTests {
    @Test(arguments: [
        ("hello world", "Hello world"),
        ("Hello world", "Hello world"),
        ("h", "H"),
        ("iPhone", "IPhone"),
        ("élan", "Élan"),
        ("e\u{301}lan", "E\u{301}lan"),
        ("ß", "Ss"),
        ("ßtadt", "Sstadt"),
        ("ǆemal", "ǅemal"),
        ("ǳ", "ǲ"),
        ("ﬁsh", "Fish"),
        ("ωmega", "Ωmega"),
        ("hELLO", "HELLO")
    ])
    func capitalizesOnlyTheFirstCharacterInPlace(_ string: String, _ expected: String) {
        var string = string
        string.uppercaseFirstCharacter()
        #expect(string == expected)
    }

    @Test(arguments: ["", "1abc", "😀 smile", "🧑‍💻 dev", "🇸🇾 flag", " leading space", "\u{301}accent", "日本"])
    func leavesStringUnchangedWhenFirstCharacterHasNoCase(_ string: String) {
        var changed = string
        changed.uppercaseFirstCharacter()
        #expect(changed == string)
    }

    @Test(arguments: ["hello", "Hello", "ßtadt", "e\u{301}lan", "ﬁsh", "", "😀 smile"])
    func matchesTheNonMutatingForm(_ string: String) {
        var changed = string
        changed.uppercaseFirstCharacter()
        #expect(changed == string.firstCharacterUppercased())
    }

    @Test
    func keepsTheRestOfTheStringUnchanged() {
        var sentence = "hello, wORLD 🧑‍💻 ß"
        sentence.uppercaseFirstCharacter()
        #expect(sentence == "Hello, wORLD 🧑‍💻 ß")
        #expect(sentence.count == 16)
    }

    @Test
    func changesTheCharacterCountWhenTheTitleCaseIsLonger() {
        var word = "ßa"
        word.uppercaseFirstCharacter()
        #expect(word == "Ssa")
        #expect(word.count == 3)
    }
}
