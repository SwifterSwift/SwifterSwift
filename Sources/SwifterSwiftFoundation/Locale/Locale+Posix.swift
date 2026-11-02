// Locale+Posix.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension Locale {
    /// SwifterSwift: The `en_US_POSIX` locale, for fixed formats that must not change with the user's settings.
    ///
    /// Use it with `DateFormatter` and `NumberFormatter` when the text is read by machines, such as file names, APIs
    /// and logs: it always uses ASCII digits, `.` as the decimal separator, English month names and the Gregorian
    /// calendar, whatever the device's region, language or 12/24-hour setting. Text shown to users should follow
    /// their locale instead.
    ///
    /// The identifier is easy to mistype, and nothing warns about a typo: `Locale(identifier: "en_US_POSX")` still
    /// gives a locale, just not this one. Each access returns a new value equal to `Locale(identifier: "en_US_POSIX")`.
    ///
    /// ```swift
    /// let formatter = DateFormatter()
    /// formatter.locale = .posix
    /// formatter.dateFormat = "yyyy-MM-dd HH:mm"
    /// formatter.string(from: date)  // "2026-10-30 14:25", on every device
    /// ```
    static var posix: Locale {
        Locale(identifier: "en_US_POSIX")
    }
}
#endif
