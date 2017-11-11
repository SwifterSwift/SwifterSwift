//
//  FoundationDeprecated.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 11/8/17.
//  Copyright © 2017 SwifterSwift
//

import Foundation

public extension Date {
	
	@available(*, deprecated: 4.1.0, message: "Use isInCurrentWeek instead", renamed: "isInCurrentWeek")
	/// SwifterSwift: Check if date is within the current week.
	public var isInThisWeek: Bool {
		return Calendar.current.isDate(self, equalTo: Date(), toGranularity: .weekOfYear)
	}
	
	@available(*, deprecated: 4.1.0, message: "Use isInCurrentMonth instead", renamed: "isInCurrentMonth")
	/// SwifterSwift: Check if date is within the current month.
	public var isInThisMonth: Bool {
		return Calendar.current.isDate(self, equalTo: Date(), toGranularity: .month)
	}
	
	@available(*, deprecated: 4.1.0, message: "Use isInCurrentYear instead", renamed: "isInCurrentYear")
	/// SwifterSwift: Check if date is within the current year.
	public var isInThisYear: Bool {
		return Calendar.current.isDate(self, equalTo: Date(), toGranularity: .year)
	}
	
}
