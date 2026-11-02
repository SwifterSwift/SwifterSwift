// Measurement+DegreesTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct MeasurementDegreesTests {
    @Test(arguments: [0, 45, 90, -90, 360, 720.5, -1e300, Double.greatestFiniteMagnitude, .infinity, -.infinity])
    func keepsTheValueAsGiven(_ value: Double) {
        let angle = Measurement<UnitAngle>.degrees(value)
        #expect(angle.value == value)
        #expect(angle.unit == .degrees)
        #expect(angle == Measurement(value: value, unit: UnitAngle.degrees))
    }

    @Test
    func keepsNaN() {
        let angle = Measurement<UnitAngle>.degrees(.nan)
        #expect(angle.value.isNaN)
        #expect(angle.unit == .degrees)
    }

    @Test
    func worksAsAnImplicitMember() {
        let angle: Measurement<UnitAngle> = .degrees(90)
        #expect(angle.value == 90)
        let angles: [Measurement<UnitAngle>] = [.degrees(-0.0), .degrees(180)]
        #expect(angles.map(\.value) == [0, 180])
    }

    @Test(arguments: [(0.0, 0.0), (90, Double.pi / 2), (180, .pi), (-45, -Double.pi / 4), (360, 2 * .pi)])
    func convertsToRadians(_ degrees: Double, _ radians: Double) {
        let converted = Measurement<UnitAngle>.degrees(degrees).converted(to: .radians)
        #expect(abs(converted.value - radians) < 1e-12)
        #expect(converted.unit == .radians)
    }

    @Test
    func convertsToOtherAngleUnits() {
        #expect(abs(Measurement<UnitAngle>.degrees(360).converted(to: .revolutions).value - 1) < 1e-12)
        #expect(abs(Measurement<UnitAngle>.degrees(90).converted(to: .gradians).value - 100) < 1e-9)
    }
}
#endif
