// Date+Setting.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension Date {
    /// SwifterSwift: Returns a new date with one calendar component set to a new value and the others kept.
    ///
    /// The other components (era, year, month, day, hour, minute, second and the fraction of a second) keep the values
    /// they have in `calendar` and its time zone, so the wall-clock time doesn't move across a daylight saving time
    /// change. This differs from `Calendar.date(bySetting:value:of:)`, which searches forward for the next matching date
    /// (setting the day to 5 on January 10 gives February 5), and from adding the difference with
    /// `Calendar.date(byAdding:value:to:)`, which counts elapsed hours (on a day when clocks spring forward, setting the
    /// hour to 3 at 00:30 would give 04:30).
    ///
    /// Nothing is clamped or rolled over: the method returns `nil` when the result doesn't exist. That covers values out
    /// of range (month 13, hour 24, a negative day), a day the month doesn't have (setting the month to February on
    /// January 31, or the year to 2027 on February 29), and a wall-clock time skipped when clocks spring forward. When
    /// clocks fall back and the new time occurs twice, the method keeps the original date's UTC offset when it can, and
    /// otherwise picks the earlier occurrence.
    ///
    /// Only `.era`, `.year`, `.month`, `.day`, `.hour`, `.minute`, `.second` and `.nanosecond` can be set; any other
    /// component returns `nil`. Setting `.month` selects the regular month with that number, never a leap month of the
    /// Chinese calendar. Nanoseconds are approximate, because a `Date` stores its time as a `Double` number of seconds.
    ///
    /// ```swift
    /// var calendar = Calendar(identifier: .gregorian)
    /// calendar.timeZone = TimeZone(identifier: "America/New_York")!
    /// let date = calendar.date(from: DateComponents(year: 2026, month: 1, day: 31, hour: 9))!
    /// date.setting(.hour, to: 17, in: calendar)  // Jan 31, 2026 at 17:00
    /// date.setting(.year, to: 2030, in: calendar)  // Jan 31, 2030 at 09:00
    /// date.setting(.month, to: 2, in: calendar)  // nil, February 31 doesn't exist
    /// date.setting(.hour, to: 24, in: calendar)  // nil
    ///
    /// let springForward = calendar.date(from: DateComponents(year: 2026, month: 3, day: 8, hour: 0, minute: 30))!
    /// springForward.setting(.hour, to: 3, in: calendar)  // Mar 8, 2026 at 03:30 EDT
    /// springForward.setting(.hour, to: 2, in: calendar)  // nil, 02:30 is skipped that day
    /// ```
    ///
    /// - Parameters:
    ///   - component: The component to set: `.era`, `.year`, `.month`, `.day`, `.hour`, `.minute`, `.second` or
    ///     `.nanosecond`.
    ///   - value: The new value of the component, in the numbering `calendar` uses.
    ///   - calendar: The calendar, with its time zone, that defines the components. The default is `.current`.
    /// - Returns: The date with `component` set to `value`, or `nil` if `component` can't be set or the resulting date
    ///   doesn't exist in `calendar`.
    func setting(_ component: Calendar.Component, to value: Int, in calendar: Calendar = .current) -> Date? {
        let fields: Set<Calendar.Component> = [.era, .year, .month, .day, .hour, .minute, .second, .isLeapMonth]
        let seconds = timeIntervalSinceReferenceDate
        guard seconds.isFinite else { return nil }

        // Time zone offsets are whole seconds, so the fraction of a second is independent of the calendar.
        let wholeSeconds = seconds.rounded(.down)
        var fraction = seconds - wholeSeconds
        let original = Date(timeIntervalSinceReferenceDate: wholeSeconds)
        var components = calendar.dateComponents(fields, from: original)
        switch component {
        case .nanosecond:
            guard (0..<1_000_000_000).contains(value) else { return nil }
            fraction = TimeInterval(value) / 1_000_000_000
        case .month:
            components.month = value
            components.isLeapMonth = false
        case .era, .year, .day, .hour, .minute, .second:
            components.setValue(value, for: component)
        default:
            return nil
        }
        guard let candidate = calendar.date(from: components) else { return nil }

        // A repeated wall-clock time resolves to its first occurrence; prefer the one with the original UTC offset.
        let timeZone = calendar.timeZone
        let offsetChange = timeZone.secondsFromGMT(for: candidate) - timeZone.secondsFromGMT(for: original)
        let sameOffset = candidate.addingTimeInterval(TimeInterval(offsetChange))
        let result = calendar.dateComponents(fields, from: sameOffset) == components ? sameOffset : candidate

        // Reject values the calendar rolled over, such as February 31 or a skipped hour.
        guard calendar.dateComponents(fields, from: result) == components else { return nil }
        return result.addingTimeInterval(fraction)
    }
}
#endif
