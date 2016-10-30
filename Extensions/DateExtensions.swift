//
//  DateExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/5/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import Foundation

public extension Date {
	/// Add calendar component to date.
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
	
	/// Return date by adding a component
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
	
	/// Return date by changing a component
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
	
	/// Return beginning of given date component.
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
	
	/// Return user’s current calendar.
	public var calendar: Calendar {
		return Calendar.current
	}
	
	/// Return date string from date
	func dateString(ofStyle style: DateFormatter.Style = .medium) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.timeStyle = .none
		dateFormatter.dateStyle = style
		return dateFormatter.string(from: self)
	}
	
	/// Return date and time string from date
	func dateTimeString(ofStyle style: DateFormatter.Style = .medium) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.timeStyle = style
		dateFormatter.dateStyle = style
		return dateFormatter.string(from: self)
	}
	
	/// Day.
	public var day: Int {
		get {
			return calendar.component(.day, from: self)
		}
		set {
			self = Date(calendar: calendar, timeZone: timeZone, era: era, year: year, month: month, day: newValue, hour: hour, minute: minute, second: second, nanosecond: nanosecond)
		}
	}
	
	/// Return date at the end of given date component.
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
	
	/// Era.
	public var era: Int {
		return calendar.component(.era, from: self)
	}
	
	/// Hour.
	public var hour: Int {
		get {
			return calendar.component(.hour, from: self)
		}
		set {
			self = Date(calendar: calendar, timeZone: timeZone, era: era, year: year, month: month, day: day, hour: newValue, minute: minute, second: second, nanosecond: nanosecond)
		}
	}
	
	/// Create a new date.
	public init(
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
		
		self = calendar?.date(from: components) ?? Date()
	}
	
	/// Create date object from ISO8601 string (yyyy-MM-dd'T'HH:mm:ss.SSSZ).
	public init(iso8601String: String) {
		// https://github.com/justinmakaila/NSDate-ISO-8601/blob/master/NSDateISO8601.swift
		let dateFormatter = DateFormatter()
		dateFormatter.locale = Locale(identifier: "en_US_POSIX")
		dateFormatter.timeZone = TimeZone.current
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
		self = dateFormatter.date(from: iso8601String) ?? Date()
	}
	
	/// Create new date object from UNIX timestamp.
	public init(unixTimestamp: Double) {
		self.init(timeIntervalSince1970: unixTimestamp)
	}
	
	/// Return true if date component in current given calendar component.
	public func isInCurrent(_ component: Calendar.Component) -> Bool {
		
		switch component {
		case .second:
			return second == Date().second && minute == Date().minute && hour == Date().hour && day == Date().day && month == Date().month && year == Date().year && era == Date().era
			
		case .minute:
			return minute == Date().minute && hour == Date().hour && day == Date().day && month == Date().month && year == Date().year && era == Date().era
			
		case .hour:
			return hour == Date().hour && day == Date().day && month == Date().month && year == Date().year && era == Date().era
			
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
	
	/// Return true if date is in future.
	public var isInFuture: Bool {
		return self > Date()
	}
	
	/// Return true if date is in past.
	public var isInPast: Bool {
		return self < Date()
	}
	
	/// Return true if date is in today.
	public var isInToday: Bool {
		return self.day == Date().day && self.month == Date().month && self.year == Date().year
	}
	
	/// Return ISO8601 string (yyyy-MM-dd'T'HH:mm:ss.SSS) from date.
	public var iso8601String: String {
		// https://github.com/justinmakaila/NSDate-ISO-8601/blob/master/NSDateISO8601.swift
		let dateFormatter = DateFormatter()
		dateFormatter.locale = Locale(identifier: "en_US_POSIX")
		dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
		
		return dateFormatter.string(from: self).appending("Z")
	}
	
	/// Minutes.
	public var minute: Int {
		get {
			return calendar.component(.minute, from: self)
		}
		set {
			self = Date(calendar: calendar, timeZone: timeZone, era: era, year: year, month: month, day: day, hour: hour, minute: newValue, second: second, nanosecond: nanosecond)
		}
	}
	
	/// Month.
	public var month: Int {
		get {
			return calendar.component(.month, from: self)
		}
		set {
			self = Date(calendar: calendar, timeZone: timeZone, era: era, year: year, month: newValue, day: day, hour: hour, minute: minute, second: newValue, nanosecond: nanosecond)
		}
	}
	
	/// Nanoseconds.
	public var nanosecond: Int {
		return calendar.component(.nanosecond, from: self)
	}
	
	/// Return nearest five minutes to date
	var nearestFiveMinutes: Date {
		var components = Calendar.current.dateComponents([.year, .month , .day , .hour , .minute], from: self)
		guard let min = components.minute else {
			return self
		}
		components.minute! = min % 5 < 3 ? min - min % 5 : min + 5 - (min % 5)
		components.second = 0
		if min > 57 {
			components.hour? += 1
		}
		return Calendar.current.date(from: components) ?? Date()
	}
	
	/// Return nearest ten minutes to date
	var nearestTenMinutes: Date {
		var components = Calendar.current.dateComponents([.year, .month , .day , .hour , .minute], from: self)
		guard let min = components.minute else {
			return self
		}
		components.minute! = min % 10 < 6 ? min - min % 10 : min + 10 - (min % 10)
		components.second = 0
		if min > 55 {
			components.hour? += 1
		}
		return Calendar.current.date(from: components) ?? Date()
	}
	
	/// Return nearest quarter to date
	var nearestHourQuarter: Date {
		var components = Calendar.current.dateComponents([.year, .month , .day , .hour , .minute], from: self)
		guard let min = components.minute else {
			return self
		}
		components.minute! = min % 15 < 8 ? min - min % 15 : min + 15 - (min % 15)
		components.second = 0
		if min > 52 {
			components.hour? += 1
		}
		return Calendar.current.date(from: components) ?? Date()
	}
	
	/// Return nearest half hour to date
	var nearestHalfHour: Date {
		var components = Calendar.current.dateComponents([.year, .month , .day , .hour , .minute], from: self)
		guard let min = components.minute else {
			return self
		}
		components.minute! = min % 30 < 15 ? min - min % 30 : min + 30 - (min % 30)
		components.second = 0
		if min > 30 {
			components.hour? += 1
		}
		return Calendar.current.date(from: components) ?? Date()
	}
	
	/// Quarter.
	public var quarter: Int {
		return calendar.component(.quarter, from: self)
	}
	
	/// Seconds.
	public var second: Int {
		get {
			return calendar.component(.second, from: self)
		}
		set {
			self = Date(calendar: calendar, timeZone: timeZone, era: era, year: year, month: month, day: day, hour: hour, minute: minute, second: newValue, nanosecond: nanosecond)
		}
	}
	
	/// Return time string from date
	func timeString(ofStyle style: DateFormatter.Style = .medium) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.timeStyle = style
		dateFormatter.dateStyle = .none
		return dateFormatter.string(from: self)
	}
	
	/// Return time zone used by system.
	public var timeZone: TimeZone {
		return self.calendar.timeZone
	}
	
	/// Get UNIX timestamp from date.
	var unixTimestamp: Double {
		return timeIntervalSince1970
	}
	
	/// Weekday.
	public var weekday: Int {
		return calendar.component(.weekday, from: self)
	}
	
	/// Week of month.
	public var weekOfMonth: Int {
		return calendar.component(.weekOfMonth, from: self)
	}
	
	/// Week of year.
	public var weekOfYear: Int {
		return calendar.component(.weekOfYear, from: self)
	}
	
	/// Year.
	public var year: Int {
		get {
			return calendar.component(.year, from: self)
		}
		set {
			self = Date(calendar: calendar, timeZone: timeZone, era: era, year: newValue, month: month, day: day, hour: hour, minute: minute, second: newValue, nanosecond: nanosecond)
		}
	}
}
