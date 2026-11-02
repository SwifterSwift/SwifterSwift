// FloatingPoint+DegreesToRadiansTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct FloatingPointDegreesToRadiansTests {
    static let multiplesOfFortyFive: [(degrees: Double, radians: Double)] = [
        (0, 0),
        (45, Double.pi / 4),
        (90, Double.pi / 2),
        (135, Double.pi * 3 / 4),
        (180, Double.pi),
        (270, Double.pi * 3 / 2),
        (360, Double.pi * 2),
        (-45, -Double.pi / 4),
        (-180, -Double.pi),
        (720, Double.pi * 4)
    ]

    @Test(arguments: multiplesOfFortyFive)
    func convertsMultiplesOfFortyFiveDegreesExactly(degrees: Double, radians: Double) {
        #expect(degrees.degreesToRadians == radians)
    }

    @Test
    func convertsOtherAngles() {
        #expect(30.0.degreesToRadians == .pi / 6)
        #expect(60.0.degreesToRadians == .pi / 3)
        #expect(abs(1.0.degreesToRadians - 0.017_453_292_519_943_295) < 1e-17)
    }

    @Test
    func convertsFloats() {
        #expect(Float(180).degreesToRadians == .pi)
        #expect(Float(90).degreesToRadians == .pi / 2)
        #expect(Float(-360).degreesToRadians == -.pi * 2)
    }

    @Test
    func doesNotOverflowForLargeValues() {
        let radians = Double.greatestFiniteMagnitude.degreesToRadians
        #expect(radians.isFinite)
        #expect(radians < .greatestFiniteMagnitude)
        #expect(Float.greatestFiniteMagnitude.degreesToRadians.isFinite)
    }

    @Test
    func keepsSpecialValues() {
        #expect(Double.nan.degreesToRadians.isNaN)
        #expect(Double.infinity.degreesToRadians == .infinity)
        #expect((-Double.infinity).degreesToRadians == -.infinity)
        #expect((-0.0).degreesToRadians.sign == .minus)
    }

    @Test(arguments: [-720.0, -1, 0.5, 1, 33.3, 123.456, 1e10])
    func roundTripsThroughRadiansToDegrees(degrees: Double) {
        let roundTripped = degrees.degreesToRadians.radiansToDegrees
        #expect(abs(roundTripped - degrees) <= degrees.magnitude.ulp * 4)
    }
}
