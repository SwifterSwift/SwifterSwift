// Date+RandomInTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct DateRandomInTests {
    private static let start = Date(timeIntervalSince1970: 1_767_225_600)  // Jan 1, 2026 at 00:00 UTC
    private static let end = Date(timeIntervalSince1970: 1_767_312_000)  // Jan 2, 2026 at 00:00 UTC

    @Test
    func returnsDatesInAHalfOpenRange() throws {
        for _ in 0..<1_000 {
            let date = try #require(Date.random(in: Self.start..<Self.end))
            #expect(date >= Self.start)
            #expect(date < Self.end)
        }
    }

    @Test
    func returnsDatesInAClosedRange() throws {
        for _ in 0..<1_000 {
            let date = try #require(Date.random(in: Self.start...Self.end))
            #expect(date >= Self.start)
            #expect(date <= Self.end)
        }
    }

    @Test
    func spreadsResultsAcrossTheRange() throws {
        var dates = Set<Date>()
        for _ in 0..<100 {
            dates.insert(try #require(Date.random(in: Self.start..<Self.end)))
        }
        #expect(dates.count > 90)
    }

    @Test
    func returnsDatesBeforeTheReferenceDate() throws {
        let landing = Date(timeIntervalSince1970: -14_182_940)
        let range = landing..<landing.addingTimeInterval(60)
        let date = try #require(Date.random(in: range))
        #expect(range.contains(date))
    }

    @Test
    func returnsNilForAnEmptyRange() {
        #expect(Date.random(in: Self.start..<Self.start) == nil)
    }

    @Test
    func returnsTheOnlyDateOfASingleDateRange() {
        #expect(Date.random(in: Self.start...Self.start) == Self.start)
    }

    @Test
    func returnsNilForRangesThatArentFinite() {
        let infinity = Date(timeIntervalSinceReferenceDate: .infinity)
        let negativeInfinity = Date(timeIntervalSinceReferenceDate: -.infinity)
        let largest = Date(timeIntervalSinceReferenceDate: .greatestFiniteMagnitude)
        let smallest = Date(timeIntervalSinceReferenceDate: -.greatestFiniteMagnitude)
        #expect(Date.random(in: Self.start..<infinity) == nil)
        #expect(Date.random(in: negativeInfinity..<Self.start) == nil)
        #expect(Date.random(in: smallest..<largest) == nil)
        #expect(Date.random(in: Self.start...infinity) == nil)
        #expect(Date.random(in: infinity...infinity) == nil)
        #expect(Date.random(in: smallest...largest) == nil)
    }

    @Test
    func supportsTheWidestFiniteRangesOfDates() throws {
        let date = try #require(Date.random(in: Date.distantPast..<Date.distantFuture))
        #expect(date >= .distantPast)
        #expect(date < .distantFuture)
        let closed = try #require(Date.random(in: Date.distantPast...Date.distantFuture))
        #expect((Date.distantPast...Date.distantFuture).contains(closed))
    }
}
#endif
