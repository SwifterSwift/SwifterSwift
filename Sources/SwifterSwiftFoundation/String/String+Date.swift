// String+Date.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension String {
    /// SwifterSwift: Parses the string as a date in the given fixed format, such as `"yyyy-MM-dd"`.
    ///
    /// The format uses the Unicode date field patterns that `DateFormatter.dateFormat` takes. The locale defaults to
    /// `en_US_POSIX` and the calendar to the Gregorian calendar, as Apple recommends for fixed formats such as those in
    /// file names, APIs and logs; with the user's settings instead, the same string can parse differently, or not at
    /// all, on devices that use a 12-hour clock or a non-Gregorian calendar. Pass a different locale to parse month or
    /// weekday names in another language.
    ///
    /// The time zone is used for any field the string doesn't specify; a time zone in the string itself, such as `Z` or
    /// `+02:00` matched by an `XXX` pattern, takes precedence. For ISO 8601 text, `Date.ISO8601FormatStyle` is a better
    /// fit.
    ///
    /// Parsing follows `DateFormatter`, which is more forgiving than the format suggests: surrounding whitespace is
    /// ignored, numeric fields may have fewer digits, and a day that's too large for its month rolls over into the next
    /// month (`"2026-02-30"` becomes March 2). Check the result if you need strict validation.
    ///
    /// ```swift
    /// let utc = TimeZone(identifier: "UTC")!
    /// "2026-10-30".date(withFormat: "yyyy-MM-dd", timeZone: utc)  // 2026-10-30 00:00:00 +0000
    /// "30/10/2026 14:05".date(withFormat: "dd/MM/yyyy HH:mm", timeZone: utc)  // 2026-10-30 14:05:00 +0000
    /// "2026-13-45".date(withFormat: "yyyy-MM-dd")  // nil
    /// ```
    ///
    /// - Parameters:
    ///   - format: The date format pattern, such as `"yyyy-MM-dd HH:mm:ss"`.
    ///   - locale: The locale for month and weekday names and other locale-dependent fields. The default is
    ///     `en_US_POSIX`.
    ///   - timeZone: The time zone for fields the string doesn't specify. The default is the current time zone.
    ///   - calendar: The calendar the date fields belong to. The default is the Gregorian calendar.
    /// - Returns: The parsed date, or `nil` if the string doesn't match `format`.
    /// - Complexity: O(*n*), where *n* is the length of the string.
    func date(
        withFormat format: String,
        locale: Locale = Locale(identifier: "en_US_POSIX"),
        timeZone: TimeZone = .current,
        calendar: Calendar = Calendar(identifier: .gregorian)
    ) -> Date? {
        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.calendar = calendar
        formatter.timeZone = timeZone
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
}
#endif
