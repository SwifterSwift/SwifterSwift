// BinaryInteger+SpelledOutStringTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct BinaryIntegerSpelledOutStringTests {
    let english = Locale(identifier: "en_US")

    @Test(arguments: [
        (0, "zero"), (1, "one"), (12, "twelve"), (21, "twenty-one"), (92, "ninety-two"), (100, "one hundred"),
        (1000, "one thousand"), (1_000_001, "one million one")
    ])
    func spellsOutEnglishNumbers(value: Int, expected: String) {
        #expect(value.spelledOutString(locale: english) == expected)
    }

    @Test
    func spellsOutNegativeNumbers() {
        #expect((-5).spelledOutString(locale: english) == "minus five")
    }

    @Test(arguments: [
        ("fr_FR", 21, "vingt-et-un"), ("fr_FR", 92, "quatre-vingt-douze"), ("es_ES", 92, "noventa y dos"),
        ("de_DE", 12, "zwölf"), ("ja_JP", 92, "九十二")
    ])
    func usesTheGivenLocale(identifier: String, value: Int, expected: String) {
        #expect(value.spelledOutString(locale: Locale(identifier: identifier)) == expected)
    }

    @Test
    func worksWithOtherIntegerTypes() {
        #expect(UInt8.max.spelledOutString(locale: english) == "two hundred fifty-five")
        #expect(Int8.min.spelledOutString(locale: english) == "minus one hundred twenty-eight")
        #expect(UInt(7).spelledOutString(locale: english) == "seven")
    }

    @Test
    func spellsOutTheLargestExactValue() {
        let expected =
            "nine quadrillion seven trillion one hundred ninety-nine billion two hundred fifty-four million "
            + "seven hundred forty thousand nine hundred ninety-two"
        #expect((1 << 53).spelledOutString(locale: english) == expected)
        #expect((-(1 << 53)).spelledOutString(locale: english) == "minus " + expected)
    }

    @Test(arguments: [(1 << 53) + 1, -(1 << 53) - 1, Int.max, Int.min])
    func returnsNilBeyondTwoToTheFiftyThird(value: Int) {
        // NumberFormatter would spell 9,007,199,254,740,993 as "...nine hundred ninety-two", and give digits for
        // Int.max.
        #expect(value.spelledOutString(locale: english) == nil)
    }

    @Test
    func returnsNilForValuesOutsideInt64() {
        #expect(UInt64.max.spelledOutString(locale: english) == nil)
    }
}
#endif
