// Date+RandomIn.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension Date {
    /// SwifterSwift: Returns a random date within the given half-open range.
    ///
    /// Every instant in the range is equally likely, down to the precision of `TimeInterval`. Unlike
    /// `Double.random(in:)`, which traps, this method returns `nil` for an empty range, and for a range whose bounds
    /// aren't finite or are too far apart to measure.
    ///
    /// ```swift
    /// let start = Date(timeIntervalSince1970: 0)
    /// let end = Date(timeIntervalSince1970: 86_400)
    /// Date.random(in: start..<end)  // A date on Jan 1, 1970 (UTC)
    /// Date.random(in: start..<start)  // nil
    /// ```
    ///
    /// - Parameter range: The range in which to create a random date.
    /// - Returns: A random date in `range`, or `nil` if `range` is empty or not finite.
    static func random(in range: Range<Date>) -> Date? {
        let lowerBound = range.lowerBound.timeIntervalSinceReferenceDate
        let upperBound = range.upperBound.timeIntervalSinceReferenceDate
        guard lowerBound < upperBound, (upperBound - lowerBound).isFinite else { return nil }
        return Date(timeIntervalSinceReferenceDate: .random(in: lowerBound..<upperBound))
    }

    /// SwifterSwift: Returns a random date within the given closed range.
    ///
    /// Every instant in the range is equally likely, down to the precision of `TimeInterval`, and both bounds can be
    /// returned. A range with a single date always returns that date. Unlike `Double.random(in:)`, which traps, this
    /// method returns `nil` for a range whose bounds aren't finite or are too far apart to measure.
    ///
    /// ```swift
    /// let start = Date(timeIntervalSince1970: 0)
    /// let end = Date(timeIntervalSince1970: 86_400)
    /// Date.random(in: start...end)  // A date between Jan 1 and Jan 2, 1970 at midnight (UTC), inclusive
    /// Date.random(in: start...start)  // start
    /// ```
    ///
    /// - Parameter range: The range in which to create a random date.
    /// - Returns: A random date in `range`, or `nil` if `range` is not finite.
    static func random(in range: ClosedRange<Date>) -> Date? {
        let lowerBound = range.lowerBound.timeIntervalSinceReferenceDate
        let upperBound = range.upperBound.timeIntervalSinceReferenceDate
        guard (upperBound - lowerBound).isFinite else { return nil }
        return Date(timeIntervalSinceReferenceDate: .random(in: lowerBound...upperBound))
    }
}
#endif
