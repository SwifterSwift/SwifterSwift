// Date+IsWithin.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension Date {
    /// SwifterSwift: Returns whether the date is within the given number of calendar components of another date.
    ///
    /// The window runs from `value` components before `date` to `value` components after it, bounds included, and both
    /// bounds come from `Calendar.date(byAdding:value:to:)`. So a day is a calendar day, which is 23 or 25 hours long
    /// across a daylight saving time change, and a month back from March 31 ends on the last day of February.
    ///
    /// Unlike comparing the result of `Calendar.dateComponents(_:from:to:)`, which truncates, two dates 1 day and 23
    /// hours apart are not within 1 day of each other.
    ///
    /// ```swift
    /// var calendar = Calendar(identifier: .gregorian)
    /// calendar.timeZone = TimeZone(identifier: "America/New_York")!
    /// let noon = calendar.date(from: DateComponents(year: 2026, month: 3, day: 7, hour: 12))!
    /// let nextNoon = calendar.date(from: DateComponents(year: 2026, month: 3, day: 8, hour: 12))!  // 23 hours later
    /// nextNoon.isWithin(1, .day, of: noon, in: calendar)  // true
    /// nextNoon.isWithin(22, .hour, of: noon, in: calendar)  // false
    /// noon.isWithin(1, .day, of: nextNoon, in: calendar)  // true
    /// ```
    ///
    /// - Parameters:
    ///   - value: The number of components allowed on either side of `date`. A negative value returns `false`. The
    ///     window must fit in the dates the calendar can represent, because `Calendar.date(byAdding:value:to:)`
    ///     doesn't detect overflow for extreme values such as `Int.max`.
    ///   - component: The calendar component to count, such as `.minute`, `.day` or `.month`.
    ///   - date: The date at the center of the window.
    ///   - calendar: The calendar, with its time zone, to do the arithmetic in. The default is `.current`.
    /// - Returns: `true` if the date is between `value` components before `date` and `value` components after it,
    ///   inclusive; `false` otherwise, or if either date isn't finite or `calendar` can't add `component` to `date`.
    func isWithin(
        _ value: Int,
        _ component: Calendar.Component,
        of date: Date,
        in calendar: Calendar = .current
    ) -> Bool {
        guard value >= 0, timeIntervalSinceReferenceDate.isFinite, date.timeIntervalSinceReferenceDate.isFinite,
            let earliest = calendar.date(byAdding: component, value: -value, to: date),
            let latest = calendar.date(byAdding: component, value: value, to: date),
            earliest <= date, date <= latest
        else { return false }
        return earliest <= self && self <= latest
    }
}
#endif
