// String+LatinizedTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct StringLatinizedTests {
    @Test(arguments: [
        ("Привет, мир", "Privet, mir"),
        ("Αθήνα", "Athena"),
        ("Ελληνικά", "Ellenika"),
        ("مرحبا", "mrhba"),
        ("שלום", "slwm"),
        ("北京", "bei jing"),
        ("こんにちは", "kon'nichiha"),
        ("안녕하세요", "annyeonghaseyo"),
        ("हिन्दी", "hindi")
    ])
    func transliteratesOtherScripts(_ string: String, _ expected: String) {
        #expect(string.latinized == expected)
    }

    @Test(arguments: [
        ("Ångström", "Angstrom"),
        ("Hèllö Wórld!", "Hello World!"),
        ("Crème Brûlée", "Creme Brulee"),
        ("Tiếng Việt", "Tieng Viet"),
        ("Łódź", "Łodz"),
        ("e\u{301}", "e"),
        ("ÉCOLE", "ECOLE")
    ])
    func removesDiacritics(_ string: String, _ expected: String) {
        #expect(string.latinized == expected)
    }

    @Test(arguments: ["Straße", "Æsir", "Øresund", "đ", "SwifterSwift 9", "", "  ", "a-b_c.d!?"])
    func keepsLatinTextWithoutMarks(_ string: String) {
        #expect(string.latinized == string)
    }

    @Test(arguments: ["🧑‍💻", "🇯🇵", "👍🏽", "❤️", "1️⃣", "🏳️‍⚧️"])
    func keepsEmojiIntact(_ emoji: String) {
        #expect(emoji.latinized == emoji)
        #expect("Привет \(emoji)".latinized == "Privet \(emoji)")
    }

    @Test
    func keepsCase() {
        #expect("ПРИВЕТ".latinized == "PRIVET")
        #expect("привет".latinized == "privet")
    }

    @Test
    func handlesMixedScripts() {
        #expect("Café Москва 2026".latinized == "Cafe Moskva 2026")
    }

    @Test
    func isIdempotent() {
        let once = "Ἀθῆναι, Москва, 東京".latinized
        #expect(once.latinized == once)
    }
}
#endif
