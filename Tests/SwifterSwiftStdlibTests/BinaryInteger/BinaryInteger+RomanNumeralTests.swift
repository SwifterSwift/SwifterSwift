// BinaryInteger+RomanNumeralTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct BinaryIntegerRomanNumeralTests {
    @Test(arguments: [
        (1, "I"), (3, "III"), (4, "IV"), (5, "V"), (9, "IX"), (10, "X"), (14, "XIV"), (40, "XL"), (49, "XLIX"),
        (90, "XC"), (400, "CD"), (444, "CDXLIV"), (900, "CM"), (1994, "MCMXCIV"), (2026, "MMXXVI"),
        (2784, "MMDCCLXXXIV"), (3888, "MMMDCCCLXXXVIII"), (3999, "MMMCMXCIX")
    ])
    func returnsTheStandardNumeral(value: Int, expected: String) {
        #expect(value.romanNumeral() == expected)
    }

    @Test(arguments: [0, -1, -3999, 4000, 1_000_000, Int.max, Int.min])
    func returnsNilOutsideOneToThreeThousandNineHundredNinetyNine(value: Int) {
        #expect(value.romanNumeral() == nil)
    }

    @Test
    func worksWithOtherIntegerTypes() {
        #expect(UInt8(255).romanNumeral() == "CCLV")
        #expect(Int8.max.romanNumeral() == "CXXVII")
        #expect(Int8.min.romanNumeral() == nil)
        #expect(UInt64.max.romanNumeral() == nil)
        #expect(Int16(3999).romanNumeral() == "MMMCMXCIX")
    }

    @Test
    func producesValidNumeralsForTheWholeRange() throws {
        let values: [Character: Int] = ["I": 1, "V": 5, "X": 10, "L": 50, "C": 100, "D": 500, "M": 1000]
        for number in 1...3999 {
            let numeral = try #require(number.romanNumeral())
            // Read the numeral back: a symbol smaller than the next one is subtracted.
            let symbols = numeral.compactMap { values[$0] }
            #expect(symbols.count == numeral.count)
            var total = 0
            for (index, value) in symbols.enumerated() {
                let next = index + 1 < symbols.count ? symbols[index + 1] : 0
                total += value < next ? -value : value
            }
            #expect(total == number)
            #expect(!numeral.contains("IIII") && !numeral.contains("XXXX") && !numeral.contains("CCCC"))
        }
    }
}
