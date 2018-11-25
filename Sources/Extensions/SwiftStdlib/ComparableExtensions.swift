//
//  ComparableExtensions.swift
//  SwifterSwift
//
//  Created by Shai Mishali on 5/4/18.
//  Copyright © 2018 SwifterSwift
//

// MARK: - Methods
public extension Comparable {

    /// SwifterSwift: Returns true if value is in the provided range.
    ///
    ///    1.isBetween(5...7) // false
    ///    7.isBetween(6...12) // true
    ///    date.isBetween(date1...date2)
    ///    "c".isBetween(a...d) // true
    ///    0.32.isBetween(0.31...0.33) // true
    ///
    /// - parameter min: Minimum comparable value.
    /// - parameter max: Maximum comparable value.
    ///
    /// - returns: `true` if value is between `min` and `max`, `false` otherwise.
    public func isBetween(_ range: ClosedRange<Self>) -> Bool {
        return range ~= self
    }

    /// SwifterSwift: Returns value limited within the provided range.
    ///
    ///     1.clamped(to: 3...8) // 3
    ///     4.clamped(to: 3...7) // 4
    ///     "c".clamped(to: "e"..."g") // "e"
    ///     0.32.clamped(to: 0.1...0.29) // 0.29
    ///
    /// - parameter min: Lower bound to limit the value to.
    /// - parameter max: Upper bound to limit the value to.
    ///
    /// - returns: A value limited to the range between `min` and `max`.
    public func clamped(to range: ClosedRange<Self>) -> Self {
        return max(range.lowerBound, min(self, range.upperBound))
    }

}
