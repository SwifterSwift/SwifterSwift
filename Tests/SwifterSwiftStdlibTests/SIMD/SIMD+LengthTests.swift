// SIMD+LengthTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

#if canImport(simd)
import simd
#endif

struct SIMDLengthTests {
    @Test
    func returnsTheEuclideanLength() {
        #expect(SIMD2<Double>(3, 4).length == 5)
        #expect(SIMD3<Float>(1, 2, 2).length == 3)
        #expect(SIMD4<Double>(1, 1, 1, 1).length == 2)
        #expect(SIMD2<Double>(-3, -4).length == 5)
        #expect(SIMD3<Double>(0, -7, 0).length == 7)
        #expect(SIMD2<Float>(1, 1).length == Float(2).squareRoot())
    }

    @Test
    func worksForWiderVectors() {
        #expect(SIMD8<Double>(repeating: 1).length == Double(8).squareRoot())
        #expect(SIMD16<Float>(repeating: -0.5).length == 2)
        #expect(SIMD64<Double>(repeating: 3).length == 24)
    }

    @Test
    func returnsZeroForTheZeroVector() {
        #expect(SIMD3<Double>.zero.length == 0)
        #expect(SIMD2<Float>(-0.0, 0.0).length == 0)
    }

    @Test
    func doesNotOverflowForHugeScalars() {
        // Squaring these scalars overflows to infinity.
        #expect(Self.isClose(SIMD2<Float>(3e30, 4e30).length, to: 5e30))
        #expect(Self.isClose(SIMD2<Double>(3e200, 4e200).length, to: 5e200))
        #expect(SIMD2<Float>(.greatestFiniteMagnitude, 0).length == .greatestFiniteMagnitude)
        #expect(SIMD3<Double>(0, -.greatestFiniteMagnitude, 0).length == .greatestFiniteMagnitude)
    }

    @Test
    func doesNotUnderflowForTinyScalars() {
        // Squaring these scalars underflows to zero or to a subnormal number.
        #expect(Self.isClose(SIMD2<Float>(3e-30, 4e-30).length, to: 5e-30))
        #expect(Self.isClose(SIMD2<Double>(3e-200, 4e-200).length, to: 5e-200))
        #expect(SIMD2<Float>(.leastNonzeroMagnitude, 0).length == .leastNonzeroMagnitude)
        #expect(SIMD2<Double>(0, .leastNormalMagnitude).length == .leastNormalMagnitude)
    }

    @Test
    func returnsInfinityWhenTheLengthIsTooLargeToRepresent() {
        #expect(SIMD2<Float>(repeating: .greatestFiniteMagnitude).length == .infinity)
    }

    @Test
    func returnsInfinityForAnInfiniteScalar() {
        #expect(SIMD2<Double>(.infinity, 1).length == .infinity)
        #expect(SIMD3<Float>(0, -.infinity, 0).length == .infinity)
        #expect(SIMD2<Double>(.infinity, -.infinity).length == .infinity)
    }

    @Test
    func returnsNaNForANaNScalar() {
        #expect(SIMD2<Double>(.nan, 1).length.isNaN)
        #expect(SIMD3<Float>(0, 0, .nan).length.isNaN)
        #expect(SIMD2<Double>(.nan, .infinity).length.isNaN)
    }

    #if canImport(simd)
    @Test
    func matchesSimdLengthWithTheSimdModuleImported() {
        let vectors: [SIMD3<Float>] = [[1, 2, 3], [-0.25, 8, 1e-3], [1e10, 1, -1], [0.1, 0.2, 0.3]]
        for vector in vectors {
            #expect(Self.isClose(vector.length, to: simd_length(vector)))
            #expect(Self.isClose(vector.length, to: length(vector)))
        }
    }
    #endif

    private static func isClose<T: FloatingPoint>(_ value: T, to expected: T) -> Bool {
        (value - expected).magnitude <= expected.magnitude * T.ulpOfOne * 4
    }
}
