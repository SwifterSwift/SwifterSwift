// Date+String.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension Date {
    /// SwifterSwift: Formats the date as a string in the given fixed format, such as `"yyyy-MM-dd"`.
    ///
    /// The format uses the Unicode date field patterns that `DateFormatter.dateFormat` takes; put literal text in single
    /// quotes (`"'Week' w"`), because unquoted letters are read as fields. The locale defaults to `en_US_POSIX` and the
    /// calendar to the Gregorian calendar, as Apple recommends for fixed formats such as those in file names, APIs and
    /// logs. With the user's settings instead, the same date can come out with other digits, a 12-hour clock or another
    /// calendar's year. Pass a different locale for month and weekday names, or digits, in another language.
    ///
    /// The date is shown in `timeZone`; the time zone of `calendar` is ignored. For text shown to users, prefer
    /// `formatted(_:)` with a `Date.FormatStyle`, which follows their preferences. For ISO 8601 text, use
    /// `Date.ISO8601FormatStyle`. This is the counterpart of `String.date(withFormat:locale:timeZone:calendar:)`.
    ///
    /// ```swift
    /// let date = Date(timeIntervalSince1970: 1_793_370_309)
    /// let utc = TimeZone(identifier: "UTC")!
    /// date.string(withFormat: "yyyy-MM-dd", timeZone: utc)  // "2026-10-30"
    /// date.string(withFormat: "dd/MM/yyyy HH:mm", timeZone: utc)  // "30/10/2026 14:25"
    /// date.string(withFormat: "d MMMM", locale: Locale(identifier: "fr_FR"), timeZone: utc)  // "30 octobre"
    /// ```
    ///
    /// - Parameters:
    ///   - format: The date format pattern, such as `"yyyy-MM-dd HH:mm:ss"`. An empty format gives an empty string.
    ///   - locale: The locale for month and weekday names, digits and other locale-dependent fields. The default is
    ///     `en_US_POSIX`.
    ///   - timeZone: The time zone to show the date in. The default is the current time zone.
    ///   - calendar: The calendar that gives the year, month and day. The default is the Gregorian calendar.
    /// - Returns: The date formatted with `format`.
    /// - Complexity: O(*n*), where *n* is the length of the format.
    func string(
        withFormat format: String,
        locale: Locale = Locale(identifier: "en_US_POSIX"),
        timeZone: TimeZone = .current,
        calendar: Calendar = Calendar(identifier: .gregorian)
    ) -> String {
        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.calendar = calendar
        formatter.timeZone = timeZone
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
#endif
