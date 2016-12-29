//
//  DateExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/5/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import Foundation


public extension Date {
	
	/// SwifterSwift: Day name format.
	///
	/// - threeLetters: 3 letter day abbreviation of day name.
	/// - oneLetter: 1 letter day abbreviation of day name.
	/// - full: Full day name.
	public enum DayNameStyle {
		case threeLetters
		case oneLetter
		case full
	}
	
	/// SwifterSwift: Month name format.
	///
	/// - threeLetters: 3 letter day abbreviation of month name.
	/// - oneLetter: 1 letter day abbreviation of month name.
	/// - full: Full month name.
	public enum MonthNameStyle {
		case threeLetters
		case oneLetter
		case full
	}
	
}


// MARK: - Properties
public extension Date {
	
	/// SwifterSwift: User’s current calendar.
	public var calendar: Calendar {
		return Calendar.current
	}
	
	/// SwifterSwift: Era.
	public var era: Int {
		return calendar.component(.era, from: self)
	}
	
	/// SwifterSwift: Year.
	public var year: Int {
		get {
			return calendar.component(.year, from: self)
		}
		set {
			self = Date(calendar: calendar, timeZone: timeZone, era: era, year: newValue, month: month, day: day, hour: hour, minute: minute, second: second, nanosecond: nanosecond) ?? self
		}
	}
	
	/// SwifterSwift: Quarter.
	public var quarter: Int {
		return calendar.component(.quarter, from: self)
	}
	
	/// SwifterSwift: Month.
	public var month: Int {
		get {
			return calendar.component(.month, from: self)
		}
		set {
			self = Date(calendar: calendar, timeZone: timeZone, era: era, year: year, month: newValue, day: day, hour: hour, minute: minute, second: second, nanosecond: nanosecond) ?? self
		}
	}
	
	/// SwifterSwift: Week of year.
	public var weekOfYear: Int {
		return calendar.component(.weekOfYear, from: self)
	}
	
	/// SwifterSwift: Week of month.
	public var weekOfMonth: Int {
		return calendar.component(.weekOfMonth, from: self)
	}
	
	/// SwifterSwift: Weekday.
	public var weekday: Int {
		return calendar.component(.weekday, from: self)
	}
	
	/// SwifterSwift: Day.
	public var day: Int {
		get {
			return calendar.component(.day, from: self)
		}
		set {
			self = Date(calendar: calendar, timeZone: timeZone, era: era, year: year, month: month, day: newValue, hour: hour, minute: minute, second: second, nanosecond: nanosecond) ?? self
		}
	}
	
	/// SwifterSwift: Hour.
	public var hour: Int {
		get {
			return calendar.component(.hour, from: self)
		}
		set {
			self = Date(calendar: calendar, timeZone: timeZone, era: era, year: year, month: month, day: day, hour: newValue, minute: minute, second: second, nanosecond: nanosecond) ?? self
		}
	}
	
	/// SwifterSwift: Minutes.
	public var minute: Int {
		get {
			return calendar.component(.minute, from: self)
		}
		set {
			self = Date(calendar: calendar, timeZone: timeZone, era: era, year: year, month: month, day: day, hour: hour, minute: newValue, second: second, nanosecond: nanosecond) ?? self
		}
	}
	
	/// SwifterSwift: Seconds.
	public var second: Int {
		get {
			return calendar.component(.second, from: self)
		}
		set {
			self = Date(calendar: calendar, timeZone: timeZone, era: era, year: year, month: month, day: day, hour: hour, minute: minute, second: newValue, nanosecond: nanosecond) ?? self
		}
	}
	
	/// SwifterSwift: Nanoseconds.
	public var nanosecond: Int {
		return calendar.component(.nanosecond, from: self)
	}
	
	/// SwifterSwift: Check if date is in future.
	public var isInFuture: Bool {
		return self > Date()
	}
	
	/// SwifterSwift: Check if date is in past.
	public var isInPast: Bool {
		return self < Date()
	}
	
	/// SwifterSwift: Check if date is in today.
	public var isInToday: Bool {
		return self.day == Date().day && self.month == Date().month && self.year == Date().year
	}
	
	/// SwifterSwift: Check if date is in yesterday.
	public var isInYesterday: Bool {
		return self.adding(.day, value: 1).isInToday
	}
	
	/// SwifterSwift: Check if date is in tomorrow.
	public var isInTomorrow: Bool {
		return self.adding(.day, value: -1).isInToday
	}
	
	/// SwifterSwift: ISO8601 string of format (yyyy-MM-dd'T'HH:mm:ss.SSS) from date.
	public var iso8601String: String {
		// https://github.com/justinmakaila/NSDate-ISO-8601/blob/master/NSDateISO8601.swift
		let dateFormatter = DateFormatter()
		dateFormatter.locale = Locale(identifier: "en_US_POSIX")
		dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
		
		return dateFormatter.string(from: self).appending("Z")
	}
	
	/// SwifterSwift: Nearest five minutes to date.
	public var nearestFiveMinutes: Date {
		var components = Calendar.current.dateComponents([.year, .month , .day , .hour , .minute], from: self)
		guard let min = components.minute else {
			return self
		}
		components.minute! = min % 5 < 3 ? min - min % 5 : min + 5 - (min % 5)
		components.second = 0
		if min > 57 {
			components.hour? += 1
		}
		return Calendar.current.date(from: components) ?? self
	}
	
	/// SwifterSwift: Nearest ten minutes to date.
	public var nearestTenMinutes: Date {
		var components = Calendar.current.dateComponents([.year, .month , .day , .hour , .minute], from: self)
		guard let min = components.minute else {
			return self
		}
		components.minute? = min % 10 < 6 ? min - min % 10 : min + 10 - (min % 10)
		components.second = 0
		if min > 55 {
			components.hour? += 1
		}
		return Calendar.current.date(from: components) ?? self
	}
	
	/// SwifterSwift: Nearest quarter hour to date.
	public var nearestQuarterHour: Date {
		var components = Calendar.current.dateComponents([.year, .month , .day , .hour , .minute], from: self)
		guard let min = components.minute else {
			return self
		}
		components.minute! = min % 15 < 8 ? min - min % 15 : min + 15 - (min % 15)
		components.second = 0
		if min > 52 {
			components.hour? += 1
		}
		return Calendar.current.date(from: components) ?? self
	}
	
	/// SwifterSwift: Nearest half hour to date.
	public var nearestHalfHour: Date {
		var components = Calendar.current.dateComponents([.year, .month , .day , .hour , .minute], from: self)
		guard let min = components.minute else {
			return self
		}
		components.minute! = min % 30 < 15 ? min - min % 30 : min + 30 - (min % 30)
		components.second = 0
		if min > 30 {
			components.hour? += 1
		}
		return Calendar.current.date(from: components) ?? self
	}
	
	/// SwifterSwift: Nearest hour to date.
	public var nearestHour: Date {
		if minute >= 30 {
			return self.end(of: .hour) ?? self
		} else {
			return self.beginning(of: .hour) ?? self
		}
	}
	
	/// SwifterSwift: Time zone used by system.
	public var timeZone: TimeZone {
		return self.calendar.timeZone
	}
	
	/// SwifterSwift: UNIX timestamp from date.
	public var unixTimestamp: Double {
		return timeIntervalSince1970
	}
	
}


// MARK: - Methods
public extension Date {

	/// SwifterSwift: Add calendar component to date.
	///
	/// - Parameters:
	///   - component: component type.
	///   - value: multiples of compnenet to add.
	public mutating func add(_ component: Calendar.Component, value: Int) {
		switch component {
		case .second:
			self = calendar.date(byAdding: .second, value: value, to: self) ?? self
			break
			
		case .minute:
			self = calendar.date(byAdding: .minute, value: value, to: self) ?? self
			break
			
		case .hour:
			self = calendar.date(byAdding: .hour, value: value, to: self) ?? self
			break
			
		case .day:
			self = calendar.date(byAdding: .day, value: value, to: self) ?? self
			break
			
		case .weekOfYear, .weekOfMonth:
			self = calendar.date(byAdding: .day, value: value * 7, to: self) ?? self
			break
			
		case .month:
			self = calendar.date(byAdding: .month, value: value, to: self) ?? self
			break
			
		case .year:
			self = calendar.date(byAdding: .year, value: value, to: self) ?? self
			break
			
		default:
			break
		}
	}
	
	/// SwifterSwift: Date by adding multiples of calendar component.
	///
	/// - Parameters:
	///   - component: component type.
	///   - value: multiples of compnenets to add.
	/// - Returns: original date + multiples of compnenet added.
	public func adding(_ component: Calendar.Component, value: Int) -> Date {
		switch component {
		case .second:
			return calendar.date(byAdding: .second, value: value, to: self) ?? self
			
		case .minute:
			return calendar.date(byAdding: .minute, value: value, to: self) ?? self
			
		case .hour:
			return calendar.date(byAdding: .hour, value: value, to: self) ?? self
			
		case .day:
			return calendar.date(byAdding: .day, value: value, to: self) ?? self
			
		case .weekOfYear, .weekOfMonth:
			return calendar.date(byAdding: .day, value: value * 7, to: self) ?? self
			
		case .month:
			return calendar.date(byAdding: .month, value: value, to: self) ?? self
			
		case .year:
			return calendar.date(byAdding: .year, value: value, to: self) ?? self
			
		default:
			return self
		}
	}
	
	/// SwifterSwift: Date by changing value of calendar component.
	///
	/// - Parameters:
	///   - component: component type.
	///   - value: new value of compnenet to change.
	/// - Returns: original date + multiples of compnenets added.
	public func changing(_ component: Calendar.Component, value: Int) -> Date {
		switch component {
		case .second:
			var date = self
			date.second = value
			return date
			
		case .minute:
			var date = self
			date.minute = value
			return date
			
		case .hour:
			var date = self
			date.hour = value
			return date
			
		case .day:
			var date = self
			date.day = value
			return date
			
		case .month:
			var date = self
			date.month = value
			return date
			
		case .year:
			var date = self
			date.year = value
			return date
			
		default:
			return self
		}
	}
	
	/// SwifterSwift: Data at the beginning of calendar component.
	///
	/// - Parameter component: calendar component to get date at the beginning of.
	/// - Returns: date at the beginning of calendar component (if applicable).
	public func beginning(of component: Calendar.Component) -> Date? {
		switch component {
		case .second:
			return calendar.date(from: calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self))
			
		case .minute:
			return calendar.date(from: calendar.dateComponents([.year, .month, .day, .hour, .minute], from: self))
			
		case .hour:
			return calendar.date(from: calendar.dateComponents([.year, .month, .day, .hour], from: self))
			
		case .day:
			return self.calendar.startOfDay(for: self)
			
		case .weekOfYear, .weekOfMonth:
			return calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))
			
		case .month:
			return calendar.date(from: calendar.dateComponents([.year, .month], from: self))
			
		case .year:
			return calendar.date(from: calendar.dateComponents([.year], from: self))
			
		default:
			return nil
		}
	}
	
	/// SwifterSwift: Date at the end of calendar component.
	///
	/// - Parameter component: calendar component to get date at the end of.
	/// - Returns: date at the end of calendar component (if applicable).
	public func end(of component: Calendar.Component) -> Date? {
		switch component {
		case .second:
			var date = self.adding(.second, value: 1)
			guard let after = calendar.date(from: calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)) else {
				return nil
			}
			date = after
			date.add(.second, value: -1)
			return date
			
		case .minute:
			var date = self.adding(.minute, value: 1)
			guard let after = calendar.date(from: calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)) else {
				return nil
			}
			date = after.adding(.second, value: -1)
			return date
			
		case .hour:
			var date = self.adding(.hour, value: 1)
			guard let after = calendar.date(from: calendar.dateComponents([.year, .month, .day, .hour], from: self)) else {
				return nil
			}
			date = after.adding(.second, value: -1)
			return date
			
		case .day:
			var date = self.adding(.day, value: 1)
			date = date.calendar.startOfDay(for: date)
			date.add(.second, value: -1)
			return date
			
		case .weekOfYear, .weekOfMonth:
			var date = self
			guard let beginningOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else {
				return nil
			}
			date = beginningOfWeek.adding(.day, value: 7).adding(.second, value: -1)
			return date
			
		case .month:
			var date = self.adding(.month, value: 1)
			guard let after = calendar.date(from: calendar.dateComponents([.year, .month], from: self)) else {
				return nil
			}
			date = after.adding(.second, value: -1)
			return date
			
		case .year:
			var date = self.adding(.year, value: 1)
			guard let after = calendar.date(from: calendar.dateComponents([.year], from: self)) else {
				return nil
			}
			date = after.adding(.second, value: -1)
			return date
			
		default:
			return nil
		}
	}
	
	/// SwifterSwift: Date string from date.
	///
	/// - Parameter style: DateFormatter style (default is .medium)
	/// - Returns: date string
	public func dateString(ofStyle style: DateFormatter.Style = .medium) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.timeStyle = .none
		dateFormatter.dateStyle = style
		return dateFormatter.string(from: self)
	}
	
	/// SwifterSwift: Date and time string from date.
	///
	/// - Parameter style: DateFormatter style (default is .medium)
	/// - Returns: date and time string
	public func dateTimeString(ofStyle style: DateFormatter.Style = .medium) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.timeStyle = style
		dateFormatter.dateStyle = style
		return dateFormatter.string(from: self)
	}
	
	/// SwifterSwift: Check if date is in current given calendar component.
	///
	/// - Parameter component: calendar componenet to check.
	/// - Returns: true if date is in current given calendar component.
	public func isInCurrent(_ component: Calendar.Component) -> Bool {
		switch component {
		case .second:
			return second == Date().second && minute == Date().minute && hour == Date().hour && day == Date().day
				&& month == Date().month && year == Date().year && era == Date().era
			
		case .minute:
			return minute == Date().minute && hour == Date().hour && day == Date().day && month == Date().month
				&& year == Date().year && era == Date().era
			
		case .hour:
			return hour == Date().hour && day == Date().day && month == Date().month && year == Date().year
				&& era == Date().era
			
		case .day:
			return day == Date().day && month == Date().month && year == Date().year && era == Date().era
			
		case .weekOfYear, .weekOfMonth:
			let beginningOfWeek = Date().beginning(of: .weekOfMonth)!
			let endOfWeek = Date().end(of: .weekOfMonth)!
			return self >= beginningOfWeek && self <= endOfWeek
			
		case .month:
			return month == Date().month && year == Date().year && era == Date().era
			
		case .year:
			return year == Date().year && era == Date().era
			
		case .era:
			return era == Date().era
			
		default:
			return false
		}
	}
	
	/// SwifterSwift: Time string from date
	public func timeString(ofStyle style: DateFormatter.Style = .medium) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.timeStyle = style
		dateFormatter.dateStyle = .none
		return dateFormatter.string(from: self)
	}
	
	/// SwifterSwift: Day name from date.
	///
	/// - Parameter Style: style of day name.
	/// - Returns: Day name string (example: W, Wed, Wednesday).
	public func dayName(ofStyle style: DayNameStyle = .full) -> String {
		// http://www.codingexplorer.com/swiftly-getting-human-readable-date-nsdateformatter/
		let dateFormatter = DateFormatter()
		var format: String {
			switch style {
			case .oneLetter:
				return "EEEEE"
			case .threeLetters:
				return "EEE"
			case .full:
				return "EEEE"
			}
		}
		dateFormatter.setLocalizedDateFormatFromTemplate(format)
		return dateFormatter.string(from: self)
	}
	
	/// SwifterSwift: Month name from date.
	///
	/// - Parameter Style: style of month name.
	/// - Returns: Month name string (example: D, Dec, December).
	public func monthName(ofStyle style: MonthNameStyle = .full) -> String {
		// http://www.codingexplorer.com/swiftly-getting-human-readable-date-nsdateformatter/
		let dateFormatter = DateFormatter()
		var format: String {
			switch style {
			case .oneLetter:
				return "MMMMM"
			case .threeLetters:
				return "MMM"
			case .full:
				return "MMMM"
			}
		}
		dateFormatter.setLocalizedDateFormatFromTemplate(format)
		return dateFormatter.string(from: self)
	}
	
}


// MARK: - Initializers
public extension Date {
	
	/// SwifterSwift: Create a new date form calendar components.
	///
	/// - Parameters:
	///   - calendar: Calendar (default is current).
	///   - timeZone: TimeZone (default is current).
	///   - era: Era (default is current era).
	///   - year: Year (default is current year).
	///   - month: Month (default is current month).
	///   - day: Day (default is today).
	///   - hour: Hour (default is current hour).
	///   - minute: Minute (default is current minute).
	///   - second: Second (default is current second).
	///   - nanosecond: Nanosecond (default is current nanosecond).
	public init?(
		calendar: Calendar? = Calendar.current,
		timeZone: TimeZone? = TimeZone.current,
		era: Int? = Date().era,
		year: Int? = Date().year,
		month: Int? = Date().month,
		day: Int? = Date().day,
		hour: Int? = Date().hour,
		minute: Int? = Date().minute,
		second: Int? = Date().second,
		nanosecond: Int? = Date().nanosecond) {
		
		var components = DateComponents()
		components.calendar = calendar
		components.timeZone = timeZone
		components.era = era
		components.year = year
		components.month = month
		components.day = day
		components.hour = hour
		components.minute = minute
		components.second = second
		components.nanosecond = nanosecond
		
		if let date = calendar?.date(from: components) {
			self = date
		} else {
			return nil
		}
	}
	
	/// SwifterSwift: Create date object from ISO8601 string.
	///
	/// - Parameter iso8601String: ISO8601 string of format (yyyy-MM-dd'T'HH:mm:ss.SSSZ).
	public init?(iso8601String: String) {
		// https://github.com/justinmakaila/NSDate-ISO-8601/blob/master/NSDateISO8601.swift
		let dateFormatter = DateFormatter()
		dateFormatter.locale = Locale(identifier: "en_US_POSIX")
		dateFormatter.timeZone = TimeZone.current
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
		if let date = dateFormatter.date(from: iso8601String) {
			self = date
		} else {
			return nil
		}
	}
	
	/// SwifterSwift: Create new date object from UNIX timestamp.
	///
	/// - Parameter unixTimestamp: UNIX timestamp.
	public init(unixTimestamp: Double) {
		self.init(timeIntervalSince1970: unixTimestamp)
	}
	
}
