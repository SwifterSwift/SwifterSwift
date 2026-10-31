// Date+InitISO8601String.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension Date {
    /// SwifterSwift: Creates a date from an ISO 8601 date and time string, with or without fractional seconds.
    ///
    /// The string must be a full date and time with a time zone designator, as in RFC 3339:
    /// `2017-01-12T16:48:00Z`, `2017-01-12T16:48:00.959Z` or `2017-01-12T16:48:00.959+03:00`. Any number of fractional
    /// digits is accepted, and the time zone can be `Z` or an offset, with or without a colon.
    ///
    /// `ISO8601DateFormatter` rejects fractional seconds unless `.withFractionalSeconds` is set, and then rejects
    /// strings without them, so parsing timestamps from a server that only sometimes sends milliseconds is easy to get
    /// wrong. This initializer accepts both forms on every OS version by trying a `Date.ISO8601FormatStyle` without
    /// fractional seconds and then one with them. Field validation is left to `Date.ISO8601FormatStyle`, which rolls
    /// over out-of-range values such as February 30 on recent OS versions.
    ///
    /// ```swift
    /// Date(iso8601String: "2017-01-12T16:48:00Z")  // Jan 12, 2017 at 16:48:00 UTC
    /// Date(iso8601String: "2017-01-12T16:48:00.959Z")  // Jan 12, 2017 at 16:48:00.959 UTC
    /// Date(iso8601String: "2017-01-12T19:48:00+03:00")  // Jan 12, 2017 at 16:48:00 UTC
    /// Date(iso8601String: "2017-01-12")  // nil, the time is missing
    /// Date(iso8601String: "2017-01-12T16:48:00")  // nil, the time zone is missing
    /// ```
    ///
    /// - Parameter iso8601String: The ISO 8601 string to parse.
    init?(iso8601String: String) {
        let wholeSeconds = Date.ISO8601FormatStyle()
        let fractionalSeconds = Date.ISO8601FormatStyle(includingFractionalSeconds: true)
        guard let date = (try? wholeSeconds.parse(iso8601String)) ?? (try? fractionalSeconds.parse(iso8601String))
        else { return nil }
        self = date
    }
}
#endif
