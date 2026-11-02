// Measurement+RadiansTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct MeasurementRadiansTests {
    @Test(arguments: [
        0, Double.pi, -Double.pi / 2, 4 * .pi, -1e300, Double.greatestFiniteMagnitude, .infinity, -.infinity
    ])
    func keepsTheValueAsGiven(_ value: Double) {
        let angle = Measurement<UnitAngle>.radians(value)
        #expect(angle.value == value)
        #expect(angle.unit == .radians)
        #expect(angle == Measurement(value: value, unit: UnitAngle.radians))
    }

    @Test
    func keepsNaN() {
        let angle = Measurement<UnitAngle>.radians(.nan)
        #expect(angle.value.isNaN)
        #expect(angle.unit == .radians)
    }

    @Test
    func worksAsAnImplicitMember() {
        let angle: Measurement<UnitAngle> = .radians(.pi)
        #expect(angle.value == .pi)
        let angles: [Measurement<UnitAngle>] = [.radians(-0.0), .radians(1)]
        #expect(angles.map(\.value) == [0, 1])
    }

    @Test(arguments: [(0.0, 0.0), (Double.pi / 2, 90.0), (.pi, 180), (-Double.pi / 4, -45), (2 * .pi, 360)])
    func convertsToDegrees(_ radians: Double, _ degrees: Double) {
        let converted = Measurement<UnitAngle>.radians(radians).converted(to: .degrees)
        #expect(abs(converted.value - degrees) < 1e-9)
        #expect(converted.unit == .degrees)
    }

    @Test
    func equalsTheSameAngleInDegrees() {
        // Measurements of the same dimension compare by their value in the base unit.
        #expect(Measurement<UnitAngle>.radians(.pi) == Measurement(value: 180, unit: UnitAngle.degrees))
        #expect(Measurement<UnitAngle>.radians(0) == Measurement(value: 0, unit: UnitAngle.degrees))
    }
}
#endif
