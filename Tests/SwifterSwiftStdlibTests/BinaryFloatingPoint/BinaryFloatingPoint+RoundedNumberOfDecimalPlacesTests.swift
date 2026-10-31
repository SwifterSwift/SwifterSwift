// BinaryFloatingPoint+RoundedNumberOfDecimalPlacesTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct BinaryFloatingPointRoundedNumberOfDecimalPlacesTests {
    static let allRules: [FloatingPointRoundingRule] = [
        .toNearestOrAwayFromZero, .toNearestOrEven, .up, .down, .towardZero, .awayFromZero
    ]

    static let ruleCases: [(value: Double, places: Int, rule: FloatingPointRoundingRule, expected: Double)] = [
        (3.1415927, 2, .toNearestOrAwayFromZero, 3.14),
        (3.1415927, 3, .up, 3.142),
        (3.1415927, 3, .down, 3.141),
        (3.1415927, 2, .awayFromZero, 3.15),
        (3.1415927, 4, .towardZero, 3.1415),
        (-3.1415927, 2, .up, -3.14),
        (-3.1415927, 2, .down, -3.15),
        (-3.1415927, 2, .towardZero, -3.14),
        (-3.1415927, 2, .awayFromZero, -3.15)
    ]

    static let decimalTies: [(value: Double, rule: FloatingPointRoundingRule, expected: Double)] = [
        (1.005, .toNearestOrAwayFromZero, 1.01),
        (1.005, .toNearestOrEven, 1.0),
        (1.015, .toNearestOrAwayFromZero, 1.02),
        (1.015, .toNearestOrEven, 1.02),
        (2.675, .toNearestOrAwayFromZero, 2.68),
        (8.345, .toNearestOrEven, 8.34),
        (-1.005, .toNearestOrAwayFromZero, -1.01),
        (-1.005, .toNearestOrEven, -1.0)
    ]

    @Test(arguments: ruleCases)
    func roundsWithTheGivenRule(value: Double, places: Int, rule: FloatingPointRoundingRule, expected: Double) {
        #expect(value.rounded(numberOfDecimalPlaces: places, rule: rule) == expected)
    }

    @Test
    func defaultsToSchoolbookRounding() {
        #expect(2.345.rounded(numberOfDecimalPlaces: 2) == 2.35)
        #expect(2.344.rounded(numberOfDecimalPlaces: 2) == 2.34)
        #expect((-2.345).rounded(numberOfDecimalPlaces: 2) == -2.35)
    }

    @Test(arguments: decimalTies)
    func roundsDecimalTiesThatBinaryCannotRepresent(value: Double, rule: FloatingPointRoundingRule, expected: Double) {
        // 1.005 is stored as 1.00499999999999989..., which `(x * 100).rounded() / 100` rounds down to 1.0.
        #expect(value.rounded(numberOfDecimalPlaces: 2, rule: rule) == expected)
    }

    @Test(arguments: allRules)
    func keepsValuesThatAlreadyHaveFewerDecimals(rule: FloatingPointRoundingRule) {
        // `1.1 * 10` is 11.000000000000002 and `0.29 * 100` is 28.999999999999996.
        #expect(1.1.rounded(numberOfDecimalPlaces: 1, rule: rule) == 1.1)
        #expect(0.29.rounded(numberOfDecimalPlaces: 2, rule: rule) == 0.29)
        #expect(4.35.rounded(numberOfDecimalPlaces: 2, rule: rule) == 4.35)
        #expect((-0.07).rounded(numberOfDecimalPlaces: 2, rule: rule) == -0.07)
        #expect(12.0.rounded(numberOfDecimalPlaces: 3, rule: rule) == 12)
    }

    @Test
    func roundsValuesJustBelowADecimalStep() {
        // `0.8999999999999999 * 10` rounds up to exactly 9, but the value is still below 0.9.
        let value = 0.8999999999999999
        #expect(value.rounded(numberOfDecimalPlaces: 1, rule: .down) == 0.8)
        #expect(value.rounded(numberOfDecimalPlaces: 1, rule: .towardZero) == 0.8)
        #expect(value.rounded(numberOfDecimalPlaces: 1, rule: .up) == 0.9)
        #expect(value.rounded(numberOfDecimalPlaces: 1) == 0.9)
        #expect((-value).rounded(numberOfDecimalPlaces: 1, rule: .up) == -0.8)
        let float: Float = 1.6999999
        #expect(float.rounded(numberOfDecimalPlaces: 1, rule: .down) == 1.6)
    }

    @Test(arguments: allRules)
    func matchesExactDecimalRoundingForDoubles(rule: FloatingPointRoundingRule) {
        // Every value with three decimals in [-5, 5], rounded to 0, 1 and 2 places, compared with the result of
        // rounding the exact integer ratio.
        for thousandths in -5000...5000 {
            let value = Double(thousandths) / 1000
            for places in 0...2 {
                var factor = 1
                for _ in places..<3 { factor *= 10 }
                var scale = 1.0
                for _ in 0..<places { scale *= 10 }
                let expected = (Double(thousandths) / Double(factor)).rounded(rule) / scale
                #expect(value.rounded(numberOfDecimalPlaces: places, rule: rule) == expected)
            }
        }
    }

    @Test(arguments: allRules)
    func matchesExactDecimalRoundingForFloats(rule: FloatingPointRoundingRule) {
        for hundredths in -2000...2000 {
            let value = Float(hundredths) / 100
            let expected = (Float(hundredths) / 10).rounded(rule) / 10
            #expect(value.rounded(numberOfDecimalPlaces: 1, rule: rule) == expected)
        }
    }

    @Test
    func roundsFloats() {
        let value: Float = 3.1415927
        #expect(value.rounded(numberOfDecimalPlaces: 4, rule: .towardZero) == 3.1415)
        #expect(value.rounded(numberOfDecimalPlaces: 2) == 3.14)
        #expect(Float(1.005).rounded(numberOfDecimalPlaces: 2) == 1.01)
    }

    @Test(arguments: [0, -1, -100, Int.min])
    func roundsToAWholeNumberForZeroOrNegativePlaces(places: Int) {
        #expect(3.5.rounded(numberOfDecimalPlaces: places) == 4)
        #expect(2.5.rounded(numberOfDecimalPlaces: places, rule: .toNearestOrEven) == 2)
        #expect((-2.5).rounded(numberOfDecimalPlaces: places) == -3)
        #expect(Float(3.1415927).rounded(numberOfDecimalPlaces: places, rule: .toNearestOrEven) == 3)
    }

    @Test(arguments: [1, 2, 300, Int.max])
    func returnsSpecialValuesUnchanged(places: Int) {
        #expect(Double.nan.rounded(numberOfDecimalPlaces: places).isNaN)
        #expect(Double.infinity.rounded(numberOfDecimalPlaces: places) == .infinity)
        #expect((-Double.infinity).rounded(numberOfDecimalPlaces: places) == -.infinity)
        #expect(Double.zero.rounded(numberOfDecimalPlaces: places) == 0)
        #expect((-0.0).rounded(numberOfDecimalPlaces: places).sign == .minus)
    }

    @Test
    func returnsValuesBeyondThePrecisionOfTheTypeUnchanged() {
        #expect(Double.greatestFiniteMagnitude.rounded(numberOfDecimalPlaces: 2) == .greatestFiniteMagnitude)
        #expect((-Double.greatestFiniteMagnitude).rounded(numberOfDecimalPlaces: 2) == -.greatestFiniteMagnitude)
        #expect(Double.leastNonzeroMagnitude.rounded(numberOfDecimalPlaces: Int.max) == .leastNonzeroMagnitude)
        #expect(0.1.rounded(numberOfDecimalPlaces: Int.max) == 0.1)
        #expect(Float.greatestFiniteMagnitude.rounded(numberOfDecimalPlaces: 1) == .greatestFiniteMagnitude)
        #expect(123_456_789.123_456_78.rounded(numberOfDecimalPlaces: 8) == 123_456_789.123_456_78)
    }

    @Test(arguments: [
        Double.leastNonzeroMagnitude, .leastNonzeroMagnitude * 2024, .leastNormalMagnitude, -.leastNormalMagnitude / 2
    ])
    func neverReturnsNaNForTinyValuesWithManyPlaces(value: Double) {
        for places in 300...330 {
            for rule in Self.allRules {
                let rounded = value.rounded(numberOfDecimalPlaces: places, rule: rule)
                #expect(!rounded.isNaN)
                #expect(rounded.magnitude <= 1e-299)
            }
        }
    }

    @Test
    func roundsTinyValuesToZeroOrToTheFirstDecimalStep() {
        #expect(1e-300.rounded(numberOfDecimalPlaces: 2) == 0)
        #expect(1e-300.rounded(numberOfDecimalPlaces: 2, rule: .up) == 0.01)
        #expect((-1e-300).rounded(numberOfDecimalPlaces: 2, rule: .down) == -0.01)
    }

    @Test
    func keepsTheSignOfNegativeValuesThatRoundToZero() {
        let rounded = (-0.001).rounded(numberOfDecimalPlaces: 2)
        #expect(rounded == 0)
        #expect(rounded.sign == .minus)
    }
}
