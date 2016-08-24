//
//  DateExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/5/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import Foundation
public extension Date {

    // tested
    /// Return user’s current calendar.
    public var calendar: Calendar {
        return Calendar.current
    }

    // tested
    /// Return time zone used by system.
    public var timeZone: TimeZone {
        return self.calendar.timeZone
    }

    // tested
    /// Nanoseconds.
    public var nanosecond: Int {
        return calendar.component(.nanosecond, from: self)
    }

    // tested
    /// Seconds.
    public var second: Int {
        get {
            return calendar.component(.second, from: self)
        }
        set {
            self = Date(calendar: calendar, timeZone: timeZone, era: era, year: year, month: month, day: day, hour: hour, minute: minute, second: newValue, nanosecond: nanosecond)
        }
    }

    // tested
    /// Minutes.
    public var minute: Int {
        get {
            return calendar.component(.minute, from: self)
        }
        set {
            self = Date(calendar: calendar, timeZone: timeZone, era: era, year: year, month: month, day: day, hour: hour, minute: newValue, second: second, nanosecond: nanosecond)
        }
    }

    // tested
    /// Hour.
    public var hour: Int {
        get {
            return calendar.component(.hour, from: self)
        }
        set {
            self = Date(calendar: calendar, timeZone: timeZone, era: era, year: year, month: month, day: day, hour: newValue, minute: minute, second: second, nanosecond: nanosecond)
        }
    }

    // tested
    /// Day.
    public var day: Int {
        get {
            return calendar.component(.day, from: self)
        }
        set {
            self = Date(calendar: calendar, timeZone: timeZone, era: era, year: year, month: month, day: newValue, hour: hour, minute: minute, second: second, nanosecond: nanosecond)
        }
    }

    // tested
    /// Weekday.
    public var weekday: Int {
        return calendar.component(.weekday, from: self)
    }

    // tested
    /// Week of month.
    public var weekOfMonth: Int {
        return calendar.component(.weekOfMonth, from: self)
    }

    // tested
    /// Week of year.
    public var weekOfYear: Int {
        return calendar.component(.weekOfYear, from: self)
    }

    // tested
    /// Month.
    public var month: Int {
        get {
            return calendar.component(.month, from: self)
        }
        set {
            self = Date(calendar: calendar, timeZone: timeZone, era: era, year: year, month: newValue, day: day, hour: hour, minute: minute, second: newValue, nanosecond: nanosecond)
        }
    }

    // tested
    /// Year.
    public var year: Int {
        get {
            return calendar.component(.year, from: self)
        }
        set {
            self = Date(calendar: calendar, timeZone: timeZone, era: era, year: newValue, month: month, day: day, hour: hour, minute: minute, second: newValue, nanosecond: nanosecond)
        }
    }

    // tested
    /// Era.
    public var era: Int {
        return calendar.component(.era, from: self)
    }

    // tested
    /// Quarter.
    public var quarter: Int {
        return calendar.component(.quarter, from: self)
    }

    // tested
    /// Return true if date is in today.
    public var isInToday: Bool {
        return self.day == Date().day && self.month == Date().month && self.year == Date().year
    }

    // tested
    /// Add calendar components to date.
    public mutating func add(component: Calendar.Component, value: Int) {
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

    // tested
    /// Return beginning of given date component.
    public func beginning(of component: Calendar.Component) -> Date {

        switch component {

        case .second:
            return calendar.date(from: calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)) ?? self

        case .minute:
            return calendar.date(from: calendar.dateComponents([.year, .month, .day, .hour, .minute], from: self)) ?? self

        case .hour:
            return calendar.date(from: calendar.dateComponents([.year, .month, .day, .hour], from: self)) ?? self

        case .day:
            return self.calendar.startOfDay(for: self)

        case .weekOfYear, .weekOfMonth:
            return calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) ?? self

        case .month:
            return calendar.date(from: calendar.dateComponents([.year, .month], from: self)) ?? self

        case .year:
            return calendar.date(from: calendar.dateComponents([.year], from: self)) ?? self

        default:
            return self
        }
    }

    /// Return true if date component in current given calendar component.
    public func isIn(current: Calendar.Component) -> Bool {
        switch current {
        case .second:
            return second == Date().second && minute == Date().minute && hour == Date().hour && day == Date().day && month == Date().month && year == Date().year && era == Date().era

        case .minute:
            return minute == Date().minute && hour == Date().hour && day == Date().day && month == Date().month && year == Date().year && era == Date().era

        case .hour:
            return hour == Date().hour && day == Date().day && month == Date().month && year == Date().year && era == Date().era

        case .day:
            return day == Date().day && month == Date().month && year == Date().year && era == Date().era

        case .month:
            return month == Date().month && year == Date().year && era == Date().era

        case .year:
            return year == Date().year && era == Date().era

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

    /// Return ISO8601 string (yyyy-MM-dd'T'HH:mm:ss.SSS) from date.
    public var iso8601String: String {
        // https://github.com/justinmakaila/NSDate-ISO-8601/blob/master/NSDateISO8601.swift
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"

        return dateFormatter.string(from: self).appending("Z")
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

    // tested
    /// Create a new date.
    public init(calendar: Calendar?, timeZone: TimeZone?, era: Int?, year: Int?, month: Int?, day: Int?, hour: Int?, minute: Int?, second: Int?, nanosecond: Int?) {

        let calendar = calendar ?? Calendar.current
        let timeZone = timeZone ?? TimeZone.current
        let era = era ?? Date().era
        let year = year ?? Date().year
        let month = month ?? Date().month
        let day = day ?? Date().day
        let hour = hour ?? Date().hour
        let minute = minute ?? Date().minute
        let second = second ?? Date().second
        let nanosecond = nanosecond ?? Date().nanosecond

        let components = DateComponents(calendar: calendar, timeZone: timeZone, era: era, year: year, month: month, day: day, hour: hour, minute: minute, second: second, nanosecond: nanosecond, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil)

        self = calendar.date(from: components) ?? Date()
    }
}
