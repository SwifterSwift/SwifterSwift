// Date+RandomInUsing.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension Date {
    /// SwifterSwift: Returns a random date within a half-open range, using the given random number generator.
    ///
    /// Every instant in the range is equally likely, down to the precision of `TimeInterval`. Unlike
    /// `Double.random(in:using:)`, which traps, this method returns `nil` for an empty range, and for a range whose
    /// bounds aren't finite or are too far apart to measure. The generator isn't used in that case.
    ///
    /// ```swift
    /// var generator = SystemRandomNumberGenerator()
    /// let start = Date(timeIntervalSince1970: 0)
    /// let end = Date(timeIntervalSince1970: 86_400)
    /// Date.random(in: start..<end, using: &generator)  // A date on Jan 1, 1970 (UTC)
    /// Date.random(in: start..<start, using: &generator)  // nil
    /// ```
    ///
    /// - Parameters:
    ///   - range: The range in which to create a random date.
    ///   - generator: The random number generator to use when creating the date.
    /// - Returns: A random date in `range`, or `nil` if `range` is empty or not finite.
    static func random(in range: Range<Date>, using generator: inout some RandomNumberGenerator) -> Date? {
        let lowerBound = range.lowerBound.timeIntervalSinceReferenceDate
        let upperBound = range.upperBound.timeIntervalSinceReferenceDate
        guard lowerBound < upperBound, (upperBound - lowerBound).isFinite else { return nil }
        return Date(timeIntervalSinceReferenceDate: .random(in: lowerBound..<upperBound, using: &generator))
    }

    /// SwifterSwift: Returns a random date within a closed range, using the given random number generator.
    ///
    /// Every instant in the range is equally likely, down to the precision of `TimeInterval`, and both bounds can be
    /// returned. Unlike `Double.random(in:using:)`, which traps, this method returns `nil` for a range whose bounds
    /// aren't finite or are too far apart to measure. The generator isn't used in that case.
    ///
    /// ```swift
    /// var generator = SystemRandomNumberGenerator()
    /// let start = Date(timeIntervalSince1970: 0)
    /// let end = Date(timeIntervalSince1970: 86_400)
    /// Date.random(in: start...end, using: &generator)  // A date between Jan 1 and Jan 2, 1970 at midnight (UTC)
    /// Date.random(in: start...start, using: &generator)  // start
    /// ```
    ///
    /// - Parameters:
    ///   - range: The range in which to create a random date.
    ///   - generator: The random number generator to use when creating the date.
    /// - Returns: A random date in `range`, or `nil` if `range` is not finite.
    static func random(in range: ClosedRange<Date>, using generator: inout some RandomNumberGenerator) -> Date? {
        let lowerBound = range.lowerBound.timeIntervalSinceReferenceDate
        let upperBound = range.upperBound.timeIntervalSinceReferenceDate
        guard (upperBound - lowerBound).isFinite else { return nil }
        return Date(timeIntervalSinceReferenceDate: .random(in: lowerBound...upperBound, using: &generator))
    }
}
#endif
