// Calendar+NumberOfDays.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension Calendar {
    /// SwifterSwift: Returns the number of calendar days from one date to another, ignoring the time of day.
    ///
    /// The result counts how many times the date changes between `start` and `end` in this calendar and its time
    /// zone: from 23:00 on Monday to 01:00 on Tuesday is 1 day, and from 01:00 to 23:00 on the same day is 0. It's
    /// negative when `end` is on an earlier day than `start`.
    ///
    /// Dividing `end.timeIntervalSince(start)` by 86,400 is wrong across daylight saving time changes, where days last
    /// 23 or 25 hours. Comparing `startOfDay(for:)` values with `dateComponents([.day], from:to:)` breaks in time zones
    /// where clocks change at midnight, such as America/Santiago, because that day starts at 01:00. This method compares
    /// the two days at noon instead.
    ///
    /// ```swift
    /// var calendar = Calendar(identifier: .gregorian)
    /// calendar.timeZone = TimeZone(identifier: "America/New_York")!
    /// let saturday = calendar.date(from: DateComponents(year: 2026, month: 3, day: 7, hour: 23))!
    /// let sunday = calendar.date(from: DateComponents(year: 2026, month: 3, day: 8, hour: 1))!
    /// let monday = calendar.date(from: DateComponents(year: 2026, month: 3, day: 9, hour: 23))!
    /// calendar.numberOfDays(from: saturday, to: sunday)  // 1
    /// calendar.numberOfDays(from: saturday, to: monday)  // 2, although only 47 hours apart
    /// calendar.numberOfDays(from: monday, to: saturday)  // -2
    /// ```
    ///
    /// - Parameters:
    ///   - start: The date to count from.
    ///   - end: The date to count to.
    /// - Returns: The number of days from the day of `start` to the day of `end`, or `nil` if either date isn't finite
    ///   or the calendar can't compute the days.
    func numberOfDays(from start: Date, to end: Date) -> Int? {
        guard start.timeIntervalSinceReferenceDate.isFinite, end.timeIntervalSinceReferenceDate.isFinite else {
            return nil
        }
        let fields: Set<Calendar.Component> = [.era, .year, .month, .day, .isLeapMonth]
        var startDay = dateComponents(fields, from: start)
        var endDay = dateComponents(fields, from: end)
        startDay.hour = 12
        endDay.hour = 12
        guard let startNoon = date(from: startDay), let endNoon = date(from: endDay) else { return nil }
        return dateComponents([.day], from: startNoon, to: endNoon).day
    }
}
#endif
