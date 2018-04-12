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

	func testDateRange() {
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

}
