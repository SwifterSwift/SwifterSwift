//
//  ComparableExtensions.swift
//  SwifterSwift
//
//  Created by Shai Mishali on 5/4/18.
//  Copyright © 2018 SwifterSwift
//

// MARK: - Methods
public extension Comparable {
    /// SwifterSwift: Returns true if value is between provided `min`
    /// and `max`.
    ///
    ///    1.isBetween(min: 5, max: 7) // false
    ///    7.isBetween(min: 6, max: 12) // true
    ///    date.isBetween(min: date1, max: date2)
    ///    "c".isBetween(min: "a", max: "d") // true
    ///    0.32.isBetween(min: 0.31, max: 0.33) // true
    ///
    /// - parameter min: Minimum comparable value.
    /// - parameter max: Maximum comparable value.
    ///
    /// - returns: `true` if value is between `min` and `max`, `false` otherwise.
    public func isBetween(min: Self, max: Self) -> Bool {
        return self >= min && self <= max
    }

    /// SwifterSwift: Returns value limited within the provided range
    /// between `min` and `max`.
    ///
    ///     1.clamped(min: 3, max: 8) // 3
    ///     4.clamped(min: 3, max: 7) // 4
    ///     "c".clamped(min: "e", max: "g") // "e"
    ///     0.32.clamped(min: 0.1, max: 0.29) // 0.29
    ///
    /// - parameter min: Lower bound to limit the value to.
    /// - parameter max: Upper bound to limit the value to.
    ///
    /// - returns: A value limited to the range between `min` and `max`.
    public func clamped(min minNum: Self, max maxNum: Self) -> Self {
        return max(minNum, min(self, maxNum))
    }
}
