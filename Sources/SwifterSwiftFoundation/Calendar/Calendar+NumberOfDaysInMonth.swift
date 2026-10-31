// Calendar+NumberOfDaysInMonth.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension Calendar {
    /// SwifterSwift: Returns the number of days in the month that contains the given date.
    ///
    /// The month is the one the date falls in for this calendar and its time zone, so the same date can be in different
    /// months in different time zones. The count comes from the calendar's own rules, so it is correct for lunar and
    /// lunisolar calendars (29 or 30 days in the Islamic and Hebrew calendars, 5 or 6 for the last month of the Coptic
    /// calendar) and isn't affected by daylight saving time.
    ///
    /// This is `range(of: .day, in: .month, for: date)?.count`, which is easy to confuse with `maximumRange(of: .day)`
    /// (always 31 days in the Gregorian calendar) or to replace with a division of elapsed seconds.
    ///
    /// ```swift
    /// var calendar = Calendar(identifier: .gregorian)
    /// calendar.timeZone = TimeZone(identifier: "UTC")!
    /// let date = calendar.date(from: DateComponents(year: 2024, month: 2, day: 10))!
    /// calendar.numberOfDaysInMonth(for: date)  // 29
    /// ```
    ///
    /// - Parameter date: A date in the month to measure.
    /// - Returns: The number of days in the month that contains `date`, or `nil` if `date` isn't finite or the calendar
    ///   can't compute the month.
    func numberOfDaysInMonth(for date: Date) -> Int? {
        guard date.timeIntervalSinceReferenceDate.isFinite else { return nil }
        return range(of: .day, in: .month, for: date)?.count
    }
}
#endif
