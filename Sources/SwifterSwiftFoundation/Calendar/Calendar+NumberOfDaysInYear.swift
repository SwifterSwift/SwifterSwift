// Calendar+NumberOfDaysInYear.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension Calendar {
    /// SwifterSwift: Returns the number of days in the year that contains the given date.
    ///
    /// The year is the one the date falls in for this calendar and its time zone. The count comes from the calendar's
    /// own rules, so it isn't always 365 or 366: Islamic years have 354 or 355 days, and Hebrew and Chinese years
    /// range from 353 to 385 days. Daylight saving time doesn't affect it.
    ///
    /// This is `range(of: .day, in: .year, for: date)?.count`, which is easy to confuse with `maximumRange(of: .day)`
    /// or to replace with a fixed 365.
    ///
    /// ```swift
    /// var calendar = Calendar(identifier: .gregorian)
    /// calendar.timeZone = TimeZone(identifier: "UTC")!
    /// let date = calendar.date(from: DateComponents(year: 2024, month: 6, day: 1))!
    /// calendar.numberOfDaysInYear(for: date)  // 366
    ///
    /// var islamic = Calendar(identifier: .islamicUmmAlQura)
    /// islamic.timeZone = calendar.timeZone
    /// islamic.numberOfDaysInYear(for: date)  // 354, the date is in the year 1445
    /// ```
    ///
    /// - Parameter date: A date in the year to measure.
    /// - Returns: The number of days in the year that contains `date`, or `nil` if `date` isn't finite or the calendar
    ///   can't compute the year.
    func numberOfDaysInYear(for date: Date) -> Int? {
        guard date.timeIntervalSinceReferenceDate.isFinite else { return nil }
        return range(of: .day, in: .year, for: date)?.count
    }
}
#endif
