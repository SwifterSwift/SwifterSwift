// FloatingPoint+RadiansToDegreesTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct FloatingPointRadiansToDegreesTests {
    static let commonAngles: [(radians: Double, degrees: Double)] = [
        (0, 0),
        (Double.pi / 6, 30),
        (Double.pi / 4, 45),
        (Double.pi / 3, 60),
        (Double.pi / 2, 90),
        (Double.pi, 180),
        (Double.pi * 2, 360),
        (-Double.pi, -180),
        (-Double.pi / 2, -90)
    ]

    @Test(arguments: commonAngles)
    func convertsCommonAnglesExactly(radians: Double, degrees: Double) {
        #expect(radians.radiansToDegrees == degrees)
    }

    @Test
    func convertsOneRadian() {
        #expect(abs(1.0.radiansToDegrees - 57.295_779_513_082_32) < 1e-13)
    }

    @Test
    func convertsFloats() {
        #expect(Float.pi.radiansToDegrees == 180)
        #expect((Float.pi / 2).radiansToDegrees == 90)
        #expect((-Float.pi).radiansToDegrees == -180)
    }

    @Test
    func doesNotOverflowWhileComputing() {
        // `x * 180 / .pi` overflows to infinity for x above greatestFiniteMagnitude / 180.
        let radians = Double.greatestFiniteMagnitude / 100
        #expect(radians.radiansToDegrees.isFinite)
        #expect(Float(3e36).radiansToDegrees.isFinite)
    }

    @Test
    func keepsSpecialValues() {
        #expect(Double.nan.radiansToDegrees.isNaN)
        #expect(Double.infinity.radiansToDegrees == .infinity)
        #expect((-Double.infinity).radiansToDegrees == -.infinity)
        #expect((-0.0).radiansToDegrees.sign == .minus)
    }
}
