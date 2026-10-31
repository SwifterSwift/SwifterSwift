// String+IsNumericTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct StringIsNumericTests {
    static let unitedStates = Locale(identifier: "en_US")
    static let germany = Locale(identifier: "de_DE")
    static let france = Locale(identifier: "fr_FR")

    @Test(arguments: [
        "0",
        "123",
        "000123.456",
        "123.4",
        "-123.4",
        "1,234",
        "1,234,567.89",
        "123,456.78",
        ".5",
        "5.",
        "1e5",
        "1E5",
        "1.25e2",
        "1.25e-2",
        "-1.5e3",
        " 42 ",
        "\n42\t",
        "99999999999999999999999999999"
    ])
    func acceptsNumbersInUnitedStatesFormat(_ string: String) {
        #expect(string.isNumeric(locale: Self.unitedStates))
    }

    @Test(arguments: ["1,3", "123.456,78", "1,2,3", "1,0000", "12-", "+-1", "1 000"])
    func rejectsOtherFormatsInUnitedStates(_ string: String) {
        #expect(!string.isNumeric(locale: Self.unitedStates))
    }

    @Test(arguments: ["1,3", "123.456,78", "-0,5", "1.234"])
    func acceptsNumbersInGermanFormat(_ string: String) {
        #expect(string.isNumeric(locale: Self.germany))
    }

    @Test(arguments: ["123,456.78", "1.25e-2", ".5"])
    func rejectsOtherFormatsInGermany(_ string: String) {
        #expect(!string.isNumeric(locale: Self.germany))
    }

    @Test
    func acceptsDigitsFromOtherScripts() {
        #expect("١٢٣".isNumeric(locale: Self.unitedStates))
        #expect("١٢٣".isNumeric(locale: Locale(identifier: "ar_EG")))
    }

    @Test
    func acceptsFrenchGroupingWithSpaces() {
        #expect("1 000,5".isNumeric(locale: Self.france))
        #expect(!"1 000,5".isNumeric(locale: Self.unitedStates))
    }

    @Test(arguments: [
        "",
        " ",
        "abc",
        "123abc",
        "abc123",
        "123.@.",
        "1,3x",
        "-",
        ".",
        "e5",
        "1e",
        "0x1p3",
        "0x10",
        "nan",
        "NaN",
        "inf",
        "infinity",
        "∞",
        "-∞",
        "1e999",
        "1\u{301}"
    ])
    func rejectsTextThatIsNotAFiniteNumber(_ string: String) {
        #expect(!string.isNumeric(locale: Self.unitedStates))
        #expect(!string.isNumeric(locale: Self.germany))
    }
}
#endif
