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
	/// - threeLetters: 3 letter month abbreviation of month name.
	/// - oneLetter: 1 letter month abbreviation of month name.
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
	///
	///		Date().era -> 1
	///
	public var era: Int {
		return Calendar.current.component(.era, from: self)
	}
	
	/// SwifterSwift: Quarter.
	public var quarter: Int {
		return Calendar.current.component(.quarter, from: self)
	}
	
	/// SwifterSwift: Week of year.
	///
	///		Date().weekOfYear -> 2 // second week in the current year.
	///
	public var weekOfYear: Int {
		return Calendar.current.component(.weekOfYear, from: self)
	}
	
	/// SwifterSwift: Week of month.
	///
	///		Date().weekOfMonth -> 2 // second week in the current month.
	///
	public var weekOfMonth: Int {
		return Calendar.current.component(.weekOfMonth, from: self)
	}
	
	/// SwifterSwift: Year.
	///
	///		Date().year -> 2017
	///
	///		var someDate = Date()
	///		someDate.year = 2000 // sets someDate's year to 2000
	///
	public var year: Int {
		get {
			return Calendar.current.component(.year, from: self)
		}
		set {
			if let date = Calendar.current.date(bySetting: .year, value: newValue, of: self) {
				self = date
			}
		}
	}
	
	/// SwifterSwift: Month.
	///
	/// 	Date().month -> 1
	///
	/// 	var someDate = Date()
	/// 	someDate.year = 10 // sets someDate's month to 10.
	///
	public var month: Int {
		get {
			return Calendar.current.component(.month, from: self)
		}
		set {
			if let date = Calendar.current.date(bySetting: .month, value: newValue, of: self) {
				self = date
			}
		}
	}
	
	/// SwifterSwift: Day.
	///
	/// 	Date().day -> 12
	///
	/// 	var someDate = Date()
	/// 	someDate.day = 1 // sets someDate's day of month to 1.
	///
	public var day: Int {
		get {
			return Calendar.current.component(.day, from: self)
		}
		set {
			if let date = Calendar.current.date(bySetting: .day, value: newValue, of: self) {
				self = date
			}
		}
	}
	
	/// SwifterSwift: Weekday.
	///
	/// 	Date().weekOfMonth -> 5 // fifth day in the current week.
	///
	public var weekday: Int {
		get {
			return Calendar.current.component(.weekday, from: self)
		}
		set {
			if let date = Calendar.current.date(bySetting: .weekday, value: newValue, of: self) {
				self = date
			}
		}
	}
	
	/// SwifterSwift: Hour.
	///
	/// 	Date().hour -> 17 // 5 pm
	///
	/// 	var someDate = Date()
	/// 	someDate.day = 13 // sets someDate's hour to 1 pm.
	///
	public var hour: Int {
		get {
			return Calendar.current.component(.hour, from: self)
		}
		set {
			if let date = Calendar.current.date(bySetting: .hour, value: newValue, of: self) {
				self = date
			}
		}
	}
	
	/// SwifterSwift: Minutes.
	///
	/// 	Date().minute -> 39
	///
	/// 	var someDate = Date()
	/// 	someDate.minute = 10 // sets someDate's minutes to 10.
	///
	public var minute: Int {
		get {
			return Calendar.current.component(.minute, from: self)
		}
		set {
			if let date = Calendar.current.date(bySetting: .minute, value: newValue, of: self) {
				self = date
			}
		}
	}
	
	/// SwifterSwift: Seconds.
	///
	/// 	Date().second -> 55
	///
	/// 	var someDate = Date()
	/// 	someDate. second = 15 // sets someDate's seconds to 15.
	///
	public var second: Int {
		get {
			return Calendar.current.component(.second, from: self)
		}
		set {
			if let date = Calendar.current.date(bySetting: .second, value: newValue, of: self) {
				self = date
			}
		}
	}
	
	/// SwifterSwift: Nanoseconds.
	///
	/// 	Date().nanosecond -> 981379985
	///
	public var nanosecond: Int {
		get {
			return Calendar.current.component(.nanosecond, from: self)
		}
		set {
			if let date = Calendar.current.date(bySetting: .nanosecond, value: newValue, of: self) {
				self = date
			}
		}
	}
	
	/// SwifterSwift: Milliseconds.
	public var millisecond: Int {
		get {
			return Calendar.current.component(.nanosecond, from: self) / 1000000
		}
		set {
			let ns = newValue * 1000000
			if let date = Calendar.current.date(bySetting: .nanosecond, value: ns, of: self) {
				self = date
			}
		}
	}
	
	/// SwifterSwift: Check if date is in future.
	///
	/// 	Date(timeInterval: 100, since: Date()).isInFuture -> true
	///
	public var isInFuture: Bool {
		return self > Date()
	}
	
	/// SwifterSwift: Check if date is in past.
	///
	/// 	Date(timeInterval: -100, since: Date()).isInPast -> true
	///
	public var isInPast: Bool {
		return self < Date()
	}
	
	/// SwifterSwift: Check if date is in today.
	///
	/// 	Date().isInToday -> true
	///
	public var isInToday: Bool {
		return Calendar.current.isDateInToday(self)
	}
	
	/// SwifterSwift: Check if date is within yesterday.
	///
	/// 	Date().isInYesterday -> false
	///
	public var isInYesterday: Bool {
		return Calendar.current.isDateInYesterday(self)
	}
	
	/// SwifterSwift: Check if date is within tomorrow.
	///
	/// 	Date().isInTomorrow -> false
	///
	public var isInTomorrow: Bool {
		return Calendar.current.isDateInTomorrow(self)
	}
	
	/// SwifterSwift: Check if date is within a weekend period.
	public var isInWeekend: Bool {
		return Calendar.current.isDateInWeekend(self)
	}
	
	/// SwifterSwift: Check if date is within a weekday period.
	public var isInWeekday: Bool {
		return !Calendar.current.isDateInWeekend(self)
	}
	
	/// SwifterSwift: Check if date is within the current week.
	public var isInThisWeek: Bool {
		return Calendar.current.isDate(self, equalTo: Date(), toGranularity: .weekOfYear)
	}
	
	/// SwifterSwift: Check if date is within the current month.
	public var isInThisMonth: Bool {
		return Calendar.current.isDate(self, equalTo: Date(), toGranularity: .month)
	}
	
	/// SwifterSwift: Check if date is within the current year.
	public var isInThisYear: Bool {
		return Calendar.current.isDate(self, equalTo: Date(), toGranularity: .year)
	}
	
	/// SwifterSwift: ISO8601 string of format (yyyy-MM-dd'T'HH:mm:ss.SSS) from date.
	///
	/// 	Date().iso8601String -> "2017-01-12T14:51:29.574Z"
	///
	public var iso8601String: String {
		// https://github.com/justinmakaila/NSDate-ISO-8601/blob/master/NSDateISO8601.swift
		let dateFormatter = DateFormatter()
		dateFormatter.locale = Locale(identifier: "en_US_POSIX")
		dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
		
		return dateFormatter.string(from: self).appending("Z")
	}
	
	/// SwifterSwift: Nearest five minutes to date.
	///
	/// 	var date = Date() // "5:54 PM"
	/// 	date.minute = 32 // "5:32 PM"
	/// 	date.nearestFiveMinutes // "5:30 PM"
	///
	/// 	date.minute = 44 // "5:44 PM"
	/// 	date.nearestFiveMinutes // "5:45 PM"
	///
	public var nearestFiveMinutes: Date {
		var components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: self)
		let min = components.minute!
		components.minute! = min % 5 < 3 ? min - min % 5 : min + 5 - (min % 5)
		components.second = 0
		return Calendar.current.date(from: components)!
	}
	
	/// SwifterSwift: Nearest ten minutes to date.
	///
	/// 	var date = Date() // "5:57 PM"
	/// 	date.minute = 34 // "5:34 PM"
	/// 	date.nearestTenMinutes // "5:30 PM"
	///
	/// 	date.minute = 48 // "5:48 PM"
	/// 	date.nearestTenMinutes // "5:50 PM"
	///
	public var nearestTenMinutes: Date {
		var components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: self)
		let min = components.minute!
		components.minute? = min % 10 < 6 ? min - min % 10 : min + 10 - (min % 10)
		components.second = 0
		return Calendar.current.date(from: components)!
	}
	
	/// SwifterSwift: Nearest quarter hour to date.
	///
	/// 	var date = Date() // "5:57 PM"
	/// 	date.minute = 34 // "5:34 PM"
	/// 	date.nearestQuarterHour // "5:30 PM"
	///
	/// 	date.minute = 40 // "5:40 PM"
	/// 	date.nearestQuarterHour // "5:45 PM"
	///
	public var nearestQuarterHour: Date {
		var components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: self)
		let min = components.minute!
		components.minute! = min % 15 < 8 ? min - min % 15 : min + 15 - (min % 15)
		components.second = 0
		return Calendar.current.date(from: components)!
	}
	
	/// SwifterSwift: Nearest half hour to date.
	///
	/// 	var date = Date() // "6:07 PM"
	/// 	date.minute = 41 // "6:41 PM"
	/// 	date.nearestHalfHour // "6:30 PM"
	///
	/// 	date.minute = 51 // "6:51 PM"
	/// 	date.nearestHalfHour // "7:00 PM"
	///
	public var nearestHalfHour: Date {
		var components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: self)
		let min = components.minute!
		components.minute! = min % 30 < 15 ? min - min % 30 : min + 30 - (min % 30)
		components.second = 0
		return Calendar.current.date(from: components)!
	}
	
	/// SwifterSwift: Nearest hour to date.
	///
	/// 	var date = Date() // "6:17 PM"
	/// 	date.nearestHour // "6:00 PM"
	///
	/// 	date.minute = 36 // "6:36 PM"
	/// 	date.nearestHour // "7:00 PM"
	///
	public var nearestHour: Date {
		if minute >= 30 {
			return beginning(of: .hour)!.adding(.hour, value: 1)
		}
		return beginning(of: .hour)!
	}
	
	/// SwifterSwift: Time zone used by system.
	///
	///		Date().timeZone -> Europe/Istanbul (current)
	///
	public var timeZone: TimeZone {
		return Calendar.current.timeZone
	}
	
	/// SwifterSwift: UNIX timestamp from date.
	///
	///		Date().unixTimestamp -> 1484233862.826291
	///
	public var unixTimestamp: Double {
		return timeIntervalSince1970
	}
	
}

// MARK: - Methods
public extension Date {
	
	/// SwifterSwift: Date by adding multiples of calendar component.
	///
	/// 	let date = Date() // "Jan 12, 2017, 7:07 PM"
	/// 	let date2 = date.adding(.minute, value: -10) // "Jan 12, 2017, 6:57 PM"
	/// 	let date3 = date.adding(.day, value: 4) // "Jan 16, 2017, 7:07 PM"
	/// 	let date4 = date.adding(.month, value: 2) // "Mar 12, 2017, 7:07 PM"
	/// 	let date5 = date.adding(.year, value: 13) // "Jan 12, 2030, 7:07 PM"
	///
	/// - Parameters:
	///   - component: component type.
	///   - value: multiples of components to add.
	/// - Returns: original date + multiples of component added.
	public func adding(_ component: Calendar.Component, value: Int) -> Date {
		return Calendar.current.date(byAdding: component, value: value, to: self)!
	}
	
	/// SwifterSwift: Add calendar component to date.
	///
	/// 	var date = Date() // "Jan 12, 2017, 7:07 PM"
	/// 	date.add(.minute, value: -10) // "Jan 12, 2017, 6:57 PM"
	/// 	date.add(.day, value: 4) // "Jan 16, 2017, 7:07 PM"
	/// 	date.add(.month, value: 2) // "Mar 12, 2017, 7:07 PM"
	/// 	date.add(.year, value: 13) // "Jan 12, 2030, 7:07 PM"
	///
	/// - Parameters:
	///   - component: component type.
	///   - value: multiples of compnenet to add.
	public mutating func add(_ component: Calendar.Component, value: Int) {
		self = adding(component, value: value)
	}
	
	/// SwifterSwift: Date by changing value of calendar component.
	///
	/// 	let date = Date() // "Jan 12, 2017, 7:07 PM"
	/// 	let date2 = date.changing(.minute, value: 10) // "Jan 12, 2017, 6:10 PM"
	/// 	let date3 = date.changing(.day, value: 4) // "Jan 4, 2017, 7:07 PM"
	/// 	let date4 = date.changing(.month, value: 2) // "Feb 12, 2017, 7:07 PM"
	/// 	let date5 = date.changing(.year, value: 2000) // "Jan 12, 2000, 7:07 PM"
	///
	/// - Parameters:
	///   - component: component type.
	///   - value: new value of compnenet to change.
	/// - Returns: original date after changing given component to given value.
	public func changing(_ component: Calendar.Component, value: Int) -> Date? {
		return Calendar.current.date(bySetting: component, value: value, of: self)
	}
	
	/// SwifterSwift: Data at the beginning of calendar component.
	///
	/// 	let date = Date() // "Jan 12, 2017, 7:14 PM"
	/// 	let date2 = date.beginning(of: .hour) // "Jan 12, 2017, 7:00 PM"
	/// 	let date3 = date.beginning(of: .month) // "Jan 1, 2017, 12:00 AM"
	/// 	let date4 = date.beginning(of: .year) // "Jan 1, 2017, 12:00 AM"
	///
	/// - Parameter component: calendar component to get date at the beginning of.
	/// - Returns: date at the beginning of calendar component (if applicable).
	public func beginning(of component: Calendar.Component) -> Date? {
		switch component {
		case .second:
			return Calendar.current.date(from:
				Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self))
			
		case .minute:
			return Calendar.current.date(from:
				Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: self))
			
		case .hour:
			return Calendar.current.date(from:
				Calendar.current.dateComponents([.year, .month, .day, .hour], from: self))
			
		case .day:
			return Calendar.current.startOfDay(for: self)
			
		case .weekOfYear, .weekOfMonth:
			return Calendar.current.date(from:
				Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))
			
		case .month:
			return Calendar.current.date(from:
				Calendar.current.dateComponents([.year, .month], from: self))
			
		case .year:
			return Calendar.current.date(from:
				Calendar.current.dateComponents([.year], from: self))
			
		default:
			return nil
		}
	}
	
	/// SwifterSwift: Date at the end of calendar component.
	///
	/// 	let date = Date() // "Jan 12, 2017, 7:27 PM"
	/// 	let date2 = date.end(of: .day) // "Jan 12, 2017, 11:59 PM"
	/// 	let date3 = date.end(of: .month) // "Jan 31, 2017, 11:59 PM"
	/// 	let date4 = date.end(of: .year) // "Dec 31, 2017, 11:59 PM"
	///
	/// - Parameter component: calendar component to get date at the end of.
	/// - Returns: date at the end of calendar component (if applicable).
	public func end(of component: Calendar.Component) -> Date? {
		switch component {
		case .second:
			var date = adding(.second, value: 1)
			date = Calendar.current.date(from:
				Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date))!
			date.add(.second, value: -1)
			return date
			
		case .minute:
			var date = adding(.minute, value: 1)
			let after = Calendar.current.date(from:
				Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date))!
			date = after.adding(.second, value: -1)
			return date
			
		case .hour:
			var date = adding(.hour, value: 1)
			let after = Calendar.current.date(from:
				Calendar.current.dateComponents([.year, .month, .day, .hour], from: date))!
			date = after.adding(.second, value: -1)
			return date
			
		case .day:
			var date = adding(.day, value: 1)
			date = Calendar.current.startOfDay(for: date)
			date.add(.second, value: -1)
			return date
			
		case .weekOfYear, .weekOfMonth:
			var date = self
			let beginningOfWeek = Calendar.current.date(from:
				Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))!
			date = beginningOfWeek.adding(.day, value: 7).adding(.second, value: -1)
			return date
			
		case .month:
			var date = adding(.month, value: 1)
			let after = Calendar.current.date(from:
				Calendar.current.dateComponents([.year, .month], from: date))!
			date = after.adding(.second, value: -1)
			return date
			
		case .year:
			var date = adding(.year, value: 1)
			let after = Calendar.current.date(from:
				Calendar.current.dateComponents([.year], from: date))!
			date = after.adding(.second, value: -1)
			return date
			
		default:
			return nil
		}
	}
	
	/// SwifterSwift: Date string from date.
	///
	/// 	Date().dateString(ofStyle: .short) -> "1/12/17"
	/// 	Date().dateString(ofStyle: .medium) -> "Jan 12, 2017"
	/// 	Date().dateString(ofStyle: .long) -> "January 12, 2017"
	/// 	Date().dateString(ofStyle: .full) -> "Thursday, January 12, 2017"
	///
	/// - Parameter style: DateFormatter style (default is .medium).
	/// - Returns: date string.
	public func dateString(ofStyle style: DateFormatter.Style = .medium) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.timeStyle = .none
		dateFormatter.dateStyle = style
		return dateFormatter.string(from: self)
	}
	
	/// SwifterSwift: Date and time string from date.
	///
	/// 	Date().dateTimeString(ofStyle: .short) -> "1/12/17, 7:32 PM"
	/// 	Date().dateTimeString(ofStyle: .medium) -> "Jan 12, 2017, 7:32:00 PM"
	/// 	Date().dateTimeString(ofStyle: .long) -> "January 12, 2017 at 7:32:00 PM GMT+3"
	/// 	Date().dateTimeString(ofStyle: .full) -> "Thursday, January 12, 2017 at 7:32:00 PM GMT+03:00"
	///
	/// - Parameter style: DateFormatter style (default is .medium).
	/// - Returns: date and time string.
	public func dateTimeString(ofStyle style: DateFormatter.Style = .medium) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.timeStyle = style
		dateFormatter.dateStyle = style
		return dateFormatter.string(from: self)
	}
	
	/// SwifterSwift: Check if date is in current given calendar component.
	///
	/// 	Date().isInCurrent(.day) -> true
	/// 	Date().isInCurrent(.year) -> true
	///
	/// - Parameter component: calendar component to check.
	/// - Returns: true if date is in current given calendar component.
	public func isInCurrent(_ component: Calendar.Component) -> Bool {
		return calendar.isDate(self, equalTo: Date(), toGranularity: component)
	}
	
	/// SwifterSwift: Time string from date
	///
	/// 	Date().timeString(ofStyle: .short) -> "7:37 PM"
	/// 	Date().timeString(ofStyle: .medium) -> "7:37:02 PM"
	/// 	Date().timeString(ofStyle: .long) -> "7:37:02 PM GMT+3"
	/// 	Date().timeString(ofStyle: .full) -> "7:37:02 PM GMT+03:00"
	///
	/// - Parameter style: DateFormatter style (default is .medium).
	/// - Returns: time string.
	public func timeString(ofStyle style: DateFormatter.Style = .medium) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.timeStyle = style
		dateFormatter.dateStyle = .none
		return dateFormatter.string(from: self)
	}
	
	/// SwifterSwift: Day name from date.
	///
	/// 	Date().dayName(ofStyle: .oneLetter) -> "T"
	/// 	Date().dayName(ofStyle: .threeLetters) -> "Thu"
	/// 	Date().dayName(ofStyle: .full) -> "Thursday"
	///
	/// - Parameter Style: style of day name (default is DayNameStyle.full).
	/// - Returns: day name string (example: W, Wed, Wednesday).
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
	/// 	Date().monthName(ofStyle: .oneLetter) -> "J"
	/// 	Date().monthName(ofStyle: .threeLetters) -> "Jan"
	/// 	Date().monthName(ofStyle: .full) -> "January"
	///
	/// - Parameter Style: style of month name (default is MonthNameStyle.full).
	/// - Returns: month name string (example: D, Dec, December).
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
	
	/// SwifterSwift: get number of seconds between two date
	///
	/// - Parameter date: date to compate self to.
	/// - Returns: number of seconds between self and given date.
	public func secondsSince(_ date: Date) -> Double {
		return self.timeIntervalSince(date)
	}
	
	/// SwifterSwift: get number of minutes between two date
	///
	/// - Parameter date: date to compate self to.
	/// - Returns: number of minutes between self and given date.
	public func minutesSince(_ date: Date) -> Double {
		return self.timeIntervalSince(date)/60
	}
	
	/// SwifterSwift: get number of hours between two date
	///
	/// - Parameter date: date to compate self to.
	/// - Returns: number of hours between self and given date.
	public func hoursSince(_ date: Date) -> Double {
		return self.timeIntervalSince(date)/3600
	}
	
	/// SwifterSwift: get number of days between two date
	///
	/// - Parameter date: date to compate self to.
	/// - Returns: number of days between self and given date.
	public func daysSince(_ date: Date) -> Double {
		return self.timeIntervalSince(date)/(3600*24)
	}
    
  /// SwifterSwift: check if a date is between two other dates
  ///
  /// - Parameters:
  ///   - startDate: start date to compare self to.
  ///   - endDate: endDate date to compare self to.
  ///   - includeBounds: true if the start and end date should be included (default is false)
  /// - Returns: true if the date is between the two given dates.
  public func isBetween(_ startDate: Date, _ endDate: Date, includeBounds: Bool = false) -> Bool {
      if includeBounds {
          return startDate.compare(self).rawValue * self.compare(endDate).rawValue >= 0
      } else {
          return startDate.compare(self).rawValue * self.compare(endDate).rawValue > 0
      }
  }
}

// MARK: - Initializers
public extension Date {
	
	/// SwifterSwift: Create a new date form calendar components.
	///
	/// 	let date = Date(year: 2010, month: 1, day: 12) // "Jan 12, 2010, 7:45 PM"
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
	/// 	let date = Date(iso8601String: "2017-01-12T16:48:00.959Z") // "Jan 12, 2017, 7:48 PM"
	///
	/// - Parameter iso8601String: ISO8601 string of format (yyyy-MM-dd'T'HH:mm:ss.SSSZ).
	public init?(iso8601String: String) {
		// https://github.com/justinmakaila/NSDate-ISO-8601/blob/master/NSDateISO8601.swift
		let dateFormatter = DateFormatter()
		dateFormatter.locale = .posix
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
	/// 	let date = Date(unixTimestamp: 1484239783.922743) // "Jan 12, 2017, 7:49 PM"
	///
	/// - Parameter unixTimestamp: UNIX timestamp.
	public init(unixTimestamp: Double) {
		self.init(timeIntervalSince1970: unixTimestamp)
	}
	
}
