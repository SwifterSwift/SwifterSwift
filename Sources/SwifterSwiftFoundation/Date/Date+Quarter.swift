// Date+Quarter.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension Date {
    /// SwifterSwift: Returns the quarter of the year, from 1 to 4, that contains the date.
    ///
    /// The quarter comes from the month number. In a calendar with 12 months, such as the Gregorian, Islamic or Persian
    /// calendars, the first quarter is months 1 to 3 and the fourth is months 10 to 12. In a calendar with 13 months,
    /// such as the Hebrew, Coptic or Ethiopic calendars, the fourth quarter has 4 months (10 to 13). A leap month of the
    /// Chinese calendar belongs to the same quarter as the month it repeats.
    ///
    /// `Calendar.component(.quarter, from:)` returns `0` for calendars such as the Hebrew, Islamic, Japanese and Buddhist
    /// ones, even on macOS 27, and has historically returned `0` for the Gregorian calendar on older OS versions too. To
    /// display a quarter, use the `.dateTime.quarter()` format style instead.
    ///
    /// ```swift
    /// var calendar = Calendar(identifier: .gregorian)
    /// calendar.timeZone = TimeZone(identifier: "Asia/Tokyo")!
    /// let date = calendar.date(from: DateComponents(year: 2026, month: 11, day: 15))!
    /// date.quarter(in: calendar)  // 4
    ///
    /// var hebrew = Calendar(identifier: .hebrew)
    /// hebrew.timeZone = calendar.timeZone
    /// date.quarter(in: hebrew)  // 1, the date falls in Kislev (month 3)
    /// ```
    ///
    /// - Parameter calendar: The calendar, with its time zone, that defines the months. The default is `.current`.
    /// - Returns: The quarter that contains the date, from 1 to 4, or `nil` if the date isn't finite or `calendar`
    ///   can't determine the months of its year.
    func quarter(in calendar: Calendar = .current) -> Int? {
        guard timeIntervalSinceReferenceDate.isFinite,
            let months = calendar.range(of: .month, in: .year, for: self)
        else { return nil }
        let month = calendar.component(.month, from: self)
        let lastMonth = months.upperBound - 1
        guard lastMonth > 0, months.contains(month) else { return nil }
        return (month * 4 + lastMonth - 1) / lastMonth
    }
}
#endif
