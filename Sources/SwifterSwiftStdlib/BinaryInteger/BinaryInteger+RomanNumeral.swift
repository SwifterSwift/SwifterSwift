// BinaryInteger+RomanNumeral.swift - Copyright 2026 SwifterSwift

public extension BinaryInteger {
    /// SwifterSwift: Returns the integer written as a Roman numeral.
    ///
    /// The numeral uses the standard subtractive form (`IV`, `IX`, `XL`, `XC`, `CD`, `CM`) in uppercase ASCII
    /// letters. Roman numerals have no zero or negative numbers, and the standard form stops at 3999 (`MMMCMXCIX`),
    /// so any other value returns `nil` instead of a long run of `M`s.
    ///
    /// ```swift
    /// 2026.romanNumeral()  // "MMXXVI"
    /// 1994.romanNumeral()  // "MCMXCIV"
    /// 0.romanNumeral()  // nil
    /// 4000.romanNumeral()  // nil
    /// ```
    ///
    /// - Returns: The Roman numeral for the integer, or `nil` if the integer isn't between 1 and 3999.
    /// - Complexity: O(1); the numeral has at most 15 letters.
    func romanNumeral() -> String? {
        guard self > 0, self <= 3999 as Int else { return nil }
        let symbols = [
            (1000, "M"), (900, "CM"), (500, "D"), (400, "CD"), (100, "C"), (90, "XC"),
            (50, "L"), (40, "XL"), (10, "X"), (9, "IX"), (5, "V"), (4, "IV"), (1, "I")
        ]
        var remaining = Int(self)
        var numeral = ""
        for (value, symbol) in symbols {
            while remaining >= value {
                numeral += symbol
                remaining -= value
            }
        }
        return numeral
    }
}
