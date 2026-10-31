// SIMD+NormalizedTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

#if canImport(simd)
import simd
#endif

struct SIMDNormalizedTests {
    @Test
    func returnsTheUnitVectorInTheSameDirection() throws {
        #expect(SIMD2<Double>(3, 4).normalized() == SIMD2(0.6, 0.8))
        #expect(SIMD2<Float>(-3, 4).normalized() == SIMD2(-0.6, 0.8))
        #expect(SIMD3<Float>(0, 0, -5).normalized() == SIMD3(0, 0, -1))
        #expect(SIMD4<Double>(2, 2, 2, 2).normalized() == SIMD4(repeating: 0.5))
        let diagonal = try #require(SIMD2<Double>(1, 1).normalized())
        #expect(diagonal.x == diagonal.y)
        #expect(Self.isClose(diagonal.x, to: Double(0.5).squareRoot()))
    }

    @Test(arguments: [
        SIMD3<Double>(1, 2, 3),
        SIMD3<Double>(-0.25, 8, 1e-3),
        SIMD3<Double>(1e10, 1, -1),
        SIMD3<Double>(0.1, 0.2, 0.3),
        SIMD3<Double>(-1e-300, 0, 2e-300),
        SIMD3<Double>(1e300, -1e300, 1e300)
    ])
    func returnsAVectorOfLengthOne(_ vector: SIMD3<Double>) throws {
        let unit = try #require(vector.normalized())
        let length = ((unit * unit).sum()).squareRoot()
        #expect(Self.isClose(length, to: 1))
        // The direction is kept: the unit vector is a positive multiple of the original.
        let ratio = vector.x / unit.x
        #expect(ratio > 0)
        #expect(Self.isClose(vector.y, to: unit.y * ratio))
        #expect(Self.isClose(vector.z, to: unit.z * ratio))
    }

    @Test
    func returnsNilForTheZeroVector() {
        #expect(SIMD3<Float>.zero.normalized() == nil)
        #expect(SIMD2<Double>(-0.0, 0.0).normalized() == nil)
        #expect(SIMD16<Float>.zero.normalized() == nil)
    }

    @Test
    func returnsNilForNonFiniteScalars() {
        #expect(SIMD2<Double>(.nan, 1).normalized() == nil)
        #expect(SIMD3<Float>(0, .infinity, 0).normalized() == nil)
        #expect(SIMD2<Double>(-.infinity, .infinity).normalized() == nil)
        #expect(SIMD2<Float>(.nan, .infinity).normalized() == nil)
    }

    @Test
    func normalizesVectorsOfHugeScalars() throws {
        // Squaring these scalars overflows to infinity, and so does the length of the last vector.
        let unit = try #require(SIMD2<Float>(3e30, 4e30).normalized())
        #expect(Self.isClose(unit.x, to: 0.6))
        #expect(Self.isClose(unit.y, to: 0.8))
        #expect(SIMD2<Float>(.greatestFiniteMagnitude, 0).normalized() == SIMD2(1, 0))
        let diagonal = try #require(SIMD2<Float>(repeating: .greatestFiniteMagnitude).normalized())
        #expect(Self.isClose(diagonal.x, to: Float(0.5).squareRoot()))
        #expect(diagonal.x == diagonal.y)
    }

    @Test
    func normalizesVectorsOfTinyScalars() throws {
        // Squaring these scalars underflows to zero.
        let unit = try #require(SIMD2<Float>(3e-30, 4e-30).normalized())
        #expect(Self.isClose(unit.x, to: 0.6))
        #expect(Self.isClose(unit.y, to: 0.8))
        #expect(SIMD2<Float>(0, -.leastNonzeroMagnitude).normalized() == SIMD2(0, -1))
        #expect(SIMD3<Double>(.leastNonzeroMagnitude, 0, 0).normalized() == SIMD3(1, 0, 0))
    }

    #if canImport(simd)
    @Test
    func matchesSimdNormalizeWithTheSimdModuleImported() throws {
        let vectors: [SIMD3<Float>] = [[1, 2, 3], [-0.25, 8, 1e-3], [1e10, 1, -1], [0.1, 0.2, 0.3]]
        for vector in vectors {
            let unit = try #require(vector.normalized())
            let expected = simd_normalize(vector)
            #expect(Self.isClose(unit.x, to: expected.x))
            #expect(Self.isClose(unit.y, to: expected.y))
            #expect(Self.isClose(unit.z, to: expected.z))
            #expect(normalize(vector) == expected)
        }
        // simd gives NaNs for the zero vector, where this method gives nil.
        #expect(simd_normalize(SIMD3<Float>.zero).x.isNaN)
        #expect(SIMD3<Float>.zero.normalized() == nil)
    }
    #endif

    private static func isClose<T: FloatingPoint>(_ value: T, to expected: T) -> Bool {
        (value - expected).magnitude <= expected.magnitude * T.ulpOfOne * 4
    }
}
