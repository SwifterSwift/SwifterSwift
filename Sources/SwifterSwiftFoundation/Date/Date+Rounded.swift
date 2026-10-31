// Date+Rounded.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension Date {
    /// SwifterSwift: Rounds the date's wall-clock time to the nearest multiple of the given number of minutes.
    ///
    /// The multiples are counted from midnight in `timeZone`, and seconds and fractions of a second count toward the
    /// rounding: with 5 minutes, 12:02:29 rounds down to 12:00 and 12:02:30 rounds up to 12:05. A date exactly halfway
    /// between two multiples rounds up. Rounding to 60 minutes gives the nearest hour, and rounding up past 23:59 gives
    /// midnight of the next day.
    ///
    /// The rounding uses the wall-clock time, so it lines up with the clock even in time zones whose offset isn't a
    /// whole number of hours. When clocks spring forward and the rounded time is skipped, the result is the moment the
    /// clocks jump (rounding 01:55 up to 02:00 on that day gives 03:00 in the new offset). When clocks fall back and the
    /// rounded time occurs twice, the result keeps the original date's UTC offset when it can.
    ///
    /// `minutes` must divide evenly into a day (1,440 minutes), so the multiples line up with midnight: 1, 5, 10, 15, 20,
    /// 30, 60 and 120 are all valid, but 7 isn't.
    ///
    /// ```swift
    /// var calendar = Calendar(identifier: .gregorian)
    /// calendar.timeZone = TimeZone(identifier: "Europe/Paris")!
    /// let date = calendar.date(from: DateComponents(year: 2026, month: 1, day: 12, hour: 17, minute: 32, second: 40))!
    /// date.rounded(toNearestMinutes: 5, in: calendar.timeZone)  // Jan 12, 2026 at 17:35:00
    /// date.rounded(toNearestMinutes: 15, in: calendar.timeZone)  // Jan 12, 2026 at 17:30:00
    /// date.rounded(toNearestMinutes: 60, in: calendar.timeZone)  // Jan 12, 2026 at 18:00:00
    /// date.rounded(toNearestMinutes: 7, in: calendar.timeZone)  // nil
    /// ```
    ///
    /// - Parameters:
    ///   - minutes: The rounding step, in minutes. It must be positive and divide 1,440.
    ///   - timeZone: The time zone whose wall-clock time is rounded. The default is `.current`.
    /// - Returns: The rounded date, or `nil` if `minutes` doesn't divide a day or the date isn't finite.
    func rounded(toNearestMinutes minutes: Int, in timeZone: TimeZone = .current) -> Date? {
        guard minutes > 0, 1_440 % minutes == 0 else { return nil }
        let seconds = timeIntervalSinceReferenceDate
        guard seconds.isFinite else { return nil }

        // The reference date is midnight in UTC, so multiples of a step that divides a day line up with local midnight.
        let offset = timeZone.secondsFromGMT(for: self)
        let localSeconds = seconds + TimeInterval(offset)
        let step = TimeInterval(minutes * 60)
        var remainder = localSeconds.truncatingRemainder(dividingBy: step)
        if remainder < 0 {
            remainder += step
        }
        let roundedLocalSeconds = localSeconds - remainder + (remainder < step / 2 ? 0 : step)

        // Keep the original offset if it's still in effect at the rounded time, as in a repeated hour.
        let candidate = Date(timeIntervalSinceReferenceDate: roundedLocalSeconds - TimeInterval(offset))
        let candidateOffset = timeZone.secondsFromGMT(for: candidate)
        guard candidateOffset != offset else { return candidate }

        // Otherwise use the offset in effect at the rounded time, unless that time was skipped by the change.
        let adjusted = Date(timeIntervalSinceReferenceDate: roundedLocalSeconds - TimeInterval(candidateOffset))
        return timeZone.secondsFromGMT(for: adjusted) == candidateOffset ? adjusted : candidate
    }
}
#endif
