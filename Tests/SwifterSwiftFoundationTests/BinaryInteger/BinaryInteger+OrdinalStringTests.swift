// BinaryInteger+OrdinalStringTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct BinaryIntegerOrdinalStringTests {
    let english = Locale(identifier: "en_US")

    @Test(arguments: [
        (0, "0th"), (1, "1st"), (2, "2nd"), (3, "3rd"), (4, "4th"), (11, "11th"), (12, "12th"), (13, "13th"),
        (21, "21st"), (22, "22nd"), (23, "23rd"), (92, "92nd"), (101, "101st"), (111, "111th"), (112, "112th"),
        (1_000_000, "1,000,000th")
    ])
    func formatsEnglishOrdinals(value: Int, expected: String) {
        #expect(value.ordinalString(locale: english) == expected)
    }

    @Test
    func formatsNegativeNumbers() {
        #expect((-1).ordinalString(locale: english) == "\u{2212}1st")
        #expect((-12).ordinalString(locale: english) == "\u{2212}12th")
    }

    @Test(arguments: [
        ("fr_FR", 1, "1er"), ("fr_FR", 2, "2e"), ("de_DE", 3, "3."), ("es_ES", 4, "4.º"), ("en_GB", 22, "22nd")
    ])
    func usesTheGivenLocale(identifier: String, value: Int, expected: String) {
        #expect(value.ordinalString(locale: Locale(identifier: identifier)) == expected)
    }

    @Test
    func worksWithOtherIntegerTypes() {
        #expect(UInt8.max.ordinalString(locale: english) == "255th")
        #expect(Int8.min.ordinalString(locale: english) == "\u{2212}128th")
        #expect(UInt64(42).ordinalString(locale: english) == "42nd")
    }

    @Test
    func formatsValuesUpToInt32Max() {
        #expect(2_147_483_641.ordinalString(locale: english) == "2,147,483,641st")
        #expect(Int32.max.ordinalString(locale: english) == "2,147,483,647th")
        #expect((-2_147_483_647).ordinalString(locale: english) == "\u{2212}2,147,483,647th")
    }

    // `Int64` rather than `Int`, because `Int` is 32 bits on Apple Watch hardware.
    @Test(arguments: [2_147_483_648, 2_147_483_651, -2_147_483_648, 1 << 53, Int64.max, Int64.min] as [Int64])
    func returnsNilBeyondInt32Max(value: Int64) {
        // NumberFormatter gets the suffix of 2,147,483,651 wrong, writes 1,099,511,627,777st, and turns
        // 9,007,199,254,740,993 into 9,007,199,254,740,992th.
        #expect(value.ordinalString(locale: english) == nil)
    }

    @Test
    func returnsNilForValuesOutsideInt64() {
        #expect(UInt64.max.ordinalString(locale: english) == nil)
    }
}
#endif
