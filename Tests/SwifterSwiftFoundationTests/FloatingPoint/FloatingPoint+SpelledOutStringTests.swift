// FloatingPoint+SpelledOutStringTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct FloatingPointSpelledOutStringTests {
    let english = Locale(identifier: "en_US")

    @Test(arguments: [
        (0.0, "zero"), (1, "one"), (12.32, "twelve point three two"), (100.25, "one hundred point two five"),
        (-0.5, "minus zero point five"), (0.1, "zero point one")
    ])
    func spellsOutEnglishNumbers(value: Double, expected: String) {
        #expect(value.spelledOutString(locale: english) == expected)
    }

    @Test
    func spellsTheDigitsTheValuePrintsAs() {
        #expect(Float(2.3).spelledOutString(locale: english) == "two point three")
        #expect(Float(12.32).spelledOutString(locale: english) == "twelve point three two")
        #if canImport(Darwin)
        // 0.1 + 0.2 prints as 0.30000000000000004. Foundation outside Apple platforms spells the last digit differently.
        let sum: Double = 0.1 + 0.2
        let zeros: String = Array(repeating: "zero", count: 15).joined(separator: " ")
        let expected: String = "zero point three \(zeros) four"
        #expect(sum.spelledOutString(locale: english) == expected)
        #endif
    }

    @Test(arguments: [
        ("de_DE", "zwölf Komma drei zwei"), ("fr_FR", "douze virgule trois deux"), ("es_ES", "doce coma tres dos"),
        ("ja_JP", "十二・三二")
    ])
    func usesTheGivenLocale(identifier: String, expected: String) {
        #expect(12.32.spelledOutString(locale: Locale(identifier: identifier)) == expected)
    }

    @Test
    func spellsOutTheLimits() {
        let largest =
            "nine quadrillion seven trillion one hundred ninety-nine billion two hundred fifty-four million "
            + "seven hundred forty thousand nine hundred ninety-two"
        #expect(9_007_199_254_740_992.0.spelledOutString(locale: english) == largest)
        #expect(
            1e-20.spelledOutString(locale: english)
                == "zero point " + Array(repeating: "zero", count: 19).joined(separator: " ") + " one"
        )
    }

    @Test(arguments: [9_007_199_254_740_994.0, 1e17, 1e20, -1e20, .greatestFiniteMagnitude])
    func returnsNilForLargeValues(value: Double) {
        // NumberFormatter spells 1e17 and above as "eighteen quadrillion fourteen trillion…" in English.
        #expect(value.spelledOutString(locale: english) == nil)
    }

    @Test(arguments: [1.5e-20, 1e-21, 1e-300, .leastNonzeroMagnitude])
    func returnsNilForMoreThanTwentyFractionDigits(value: Double) {
        // NumberFormatter cuts fractions after 20 digits, so 1.5e-20 would end in "two" and 1e-300 would be zero.
        #expect(value.spelledOutString(locale: english) == nil)
    }

    @Test(arguments: [Double.nan, .infinity, -.infinity])
    func returnsNilForNonFiniteValues(value: Double) {
        #expect(value.spelledOutString(locale: english) == nil)
    }
}
#endif
