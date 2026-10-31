// Date+RandomInUsingTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct DateRandomInUsingTests {
    /// Returns the same value every time and counts how often it's asked for one.
    private struct ConstantGenerator: RandomNumberGenerator {
        let value: UInt64
        var calls = 0

        mutating func next() -> UInt64 {
            calls += 1
            return value
        }
    }

    /// A small deterministic generator (SplitMix64), so two generators with the same seed produce the same dates.
    private struct SeededGenerator: RandomNumberGenerator {
        var state: UInt64

        mutating func next() -> UInt64 {
            state &+= 0x9E37_79B9_7F4A_7C15
            var value = state
            value = (value ^ (value >> 30)) &* 0xBF58_476D_1CE4_E5B9
            value = (value ^ (value >> 27)) &* 0x94D0_49BB_1331_11EB
            return value ^ (value >> 31)
        }
    }

    private static let start = Date(timeIntervalSince1970: 1_767_225_600)  // Jan 1, 2026 at 00:00 UTC
    private static let end = Date(timeIntervalSince1970: 1_767_312_000)  // Jan 2, 2026 at 00:00 UTC

    @Test
    func returnsDatesInBothKindsOfRange() throws {
        var generator = SystemRandomNumberGenerator()
        for _ in 0..<1_000 {
            let halfOpen = try #require(Date.random(in: Self.start..<Self.end, using: &generator))
            #expect((Self.start..<Self.end).contains(halfOpen))
            let closed = try #require(Date.random(in: Self.start...Self.end, using: &generator))
            #expect((Self.start...Self.end).contains(closed))
        }
    }

    @Test
    func usesTheGivenGenerator() {
        // A `Double` in a half-open range uses the low 53 bits of one random value as a fraction of the range.
        var zero = ConstantGenerator(value: 0)
        #expect(Date.random(in: Self.start..<Self.end, using: &zero) == Self.start)
        #expect(zero.calls == 1)

        var half = ConstantGenerator(value: 1 << 52)
        #expect(Date.random(in: Self.start..<Self.end, using: &half) == Self.start.addingTimeInterval(43_200))
        #expect(half.calls == 1)
    }

    @Test
    func isReproducibleWithASeededGenerator() {
        var first = SeededGenerator(state: 42)
        var second = SeededGenerator(state: 42)
        for _ in 0..<10 {
            #expect(
                Date.random(in: Self.start..<Self.end, using: &first)
                    == Date.random(in: Self.start..<Self.end, using: &second)
            )
            #expect(
                Date.random(in: Self.start...Self.end, using: &first)
                    == Date.random(in: Self.start...Self.end, using: &second)
            )
        }
    }

    @Test
    func returnsNilWithoutUsingTheGeneratorForInvalidRanges() {
        var generator = ConstantGenerator(value: 7)
        let infinity = Date(timeIntervalSinceReferenceDate: .infinity)
        let largest = Date(timeIntervalSinceReferenceDate: .greatestFiniteMagnitude)
        let smallest = Date(timeIntervalSinceReferenceDate: -.greatestFiniteMagnitude)
        #expect(Date.random(in: Self.start..<Self.start, using: &generator) == nil)
        #expect(Date.random(in: Self.start..<infinity, using: &generator) == nil)
        #expect(Date.random(in: smallest..<largest, using: &generator) == nil)
        #expect(Date.random(in: Self.start...infinity, using: &generator) == nil)
        #expect(Date.random(in: smallest...largest, using: &generator) == nil)
        #expect(generator.calls == 0)
    }

    @Test
    func returnsTheOnlyDateOfASingleDateRange() {
        var generator = SystemRandomNumberGenerator()
        #expect(Date.random(in: Self.start...Self.start, using: &generator) == Self.start)
    }
}
#endif
