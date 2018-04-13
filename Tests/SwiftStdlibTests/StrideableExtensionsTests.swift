//
//  StrideableExtensionsTests.swift
//  SwifterSwift
//
//  Created by Guy Kogus on 11/04/2018.
//  Copyright © 2018 SwifterSwift
//

import XCTest
@testable import SwifterSwift

final class StrideableExtensionsTests: XCTestCase {

    struct StrideableDate: Strideable {
        let date: Date
        let calendarComponentStride: Calendar.Component

        // swiftlint:disable identifier_name
        func advanced(by n: Int) -> StrideableDate {
            return StrideableDate(date: date.adding(calendarComponentStride, value: n), calendarComponentStride: calendarComponentStride)
        }

        func distance(to other: StrideableDate) -> Int {
            return Calendar.current.dateComponents([calendarComponentStride], from: date, to: other.date).value(for: calendarComponentStride)!
        }
        // swiftlint:enable identifier_name
    }

    struct StrideableInt32: Strideable {
        let value: Int32

        // swiftlint:disable identifier_name
        func advanced(by n: Int32) -> StrideableInt32 {
            return StrideableInt32(value: value + n)
        }

        func distance(to other: StrideableInt32) -> Int32 {
            return other.value - value
        }
        // swiftlint:enable identifier_name
    }

    func testStrideableDate() {
        let calendarComponent = Calendar.Component.day
        let now = Date()
        let startDate = StrideableDate(date: now.adding(calendarComponent, value: -50), calendarComponentStride: calendarComponent)
        let endDate = StrideableDate(date: now.adding(calendarComponent, value: 50), calendarComponentStride: calendarComponent)
        var values = Set<Date>()
        for _ in 0..<10000 {
            let random = StrideableDate.random(lowerBound: startDate, upperBound: endDate)
            values.insert(random.date)
            XCTAssert(random.date >= startDate.date && random.date < endDate.date, "\(random.date) is not between \(startDate.date) and \(endDate.date)")
        }
        XCTAssertEqual(values.count, 100)
    }

    func testMinMaxStrideableDate() {
        let calendarComponent = Calendar.Component.day
        let startDate = StrideableDate(date: Date.distantPast, calendarComponentStride: calendarComponent)
        let endDate = StrideableDate(date: Date.distantFuture, calendarComponentStride: calendarComponent)
        var values = Set<Date>()
        for _ in 0..<1000 {
            let random = StrideableDate.random(lowerBound: startDate, upperBound: endDate)
            values.insert(random.date)
            XCTAssert(random.date >= startDate.date && random.date < endDate.date, "\(random.date) is not between \(startDate.date) and \(endDate.date)")
        }
        XCTAssertEqual(values.count, 1000)
    }

    func testMaxStrideableInt32() {
        let lowerBound = StrideableInt32(value: 0)
        let upperBound = StrideableInt32(value: Int32.max)
        var values = Set<Int32>()
        for _ in 0..<1000 {
            let random = StrideableInt32.random(lowerBound: lowerBound, upperBound: upperBound)
            values.insert(random.value)
            XCTAssert(random.value >= lowerBound.value && random.value < upperBound.value, "\(random.value) is not between \(lowerBound.value) and \(upperBound.value)")
        }
        XCTAssertEqual(values.count, 1000)
    }

}
