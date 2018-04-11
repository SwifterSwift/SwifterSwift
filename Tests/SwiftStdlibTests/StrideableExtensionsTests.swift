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
		static let dayTimeInterval = TimeInterval(60 * 60 * 24)

		let date: Date

		// swiftlint:disable identifier_name
		func advanced(by n: Int) -> StrideableDate {
			return StrideableDate(date: Date(timeInterval: StrideableDate.dayTimeInterval * TimeInterval(n), since: date))
		}

		func distance(to other: StrideableDate) -> Int {
			return Int(round(other.date.timeIntervalSince(date) / StrideableDate.dayTimeInterval))
		}
		// swiftlint:enable identifier_name
	}

	func testDateRange() {
		let startDate = StrideableDate(date: Date(timeIntervalSinceNow: StrideableDate.dayTimeInterval * -50))
		let endDate = StrideableDate(date: Date(timeIntervalSinceNow: StrideableDate.dayTimeInterval * 50))
		var values = Set<Date>()
		for _ in 0..<10000 {
			let random = StrideableDate.random(lowerBound: startDate, upperBound: endDate)
			values.insert(random.date)
			XCTAssert(random.date >= startDate.date && random.date < endDate.date, "\(random.date) is not between \(startDate.date) and \(endDate.date)")
		}
		XCTAssertEqual(values.count, 100)
	}

}
