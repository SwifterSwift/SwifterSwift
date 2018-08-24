//
//  FoundationDeprecated.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 11/8/17.
//  Copyright © 2017 SwifterSwift
//

#if canImport(Foundation)
import Foundation

// MARK: - Properties
public extension Date {

	/// SwifterSwift: Check if date is within the current week.
	@available(*, deprecated: 4.1.0, message: "Use isInCurrentWeek instead", renamed: "isInCurrentWeek")
	public var isInThisWeek: Bool {
		return Calendar.current.isDate(self, equalTo: Date(), toGranularity: .weekOfYear)
	}

	/// SwifterSwift: Check if date is within the current month.
	@available(*, deprecated: 4.1.0, message: "Use isInCurrentMonth instead", renamed: "isInCurrentMonth")
	public var isInThisMonth: Bool {
		return Calendar.current.isDate(self, equalTo: Date(), toGranularity: .month)
	}

	/// SwifterSwift: Check if date is within the current year.
	@available(*, deprecated: 4.1.0, message: "Use isInCurrentYear instead", renamed: "isInCurrentYear")
	public var isInThisYear: Bool {
		return Calendar.current.isDate(self, equalTo: Date(), toGranularity: .year)
	}

}
#endif
