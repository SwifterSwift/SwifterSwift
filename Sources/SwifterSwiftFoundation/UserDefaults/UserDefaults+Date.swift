// UserDefaults+Date.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension UserDefaults {
    /// SwifterSwift: Returns the date stored for the given key.
    ///
    /// It reads dates written with `set(_:forKey:)`, which stores a `Date` natively, and complements the SDK's
    /// `string(forKey:)` and `url(forKey:)`. Unlike those, it doesn't convert other values: a date string such as
    /// `"2026-10-30"` or a number of seconds gives `nil`.
    ///
    /// ```swift
    /// let defaults = UserDefaults.standard
    /// defaults.set(Date(timeIntervalSince1970: 0), forKey: "lastSync")
    /// defaults.date(forKey: "lastSync")  // 1970-01-01 00:00:00 +0000
    /// defaults.date(forKey: "unknown")  // nil
    /// ```
    ///
    /// UserDefaults is a required-reason API: an app that uses this method must declare it in its privacy manifest.
    ///
    /// - Parameter key: The key to read.
    /// - Returns: The date stored for `key`, or `nil` if there's no value or the value isn't a date.
    func date(forKey key: String) -> Date? {
        object(forKey: key) as? Date
    }
}
#endif
