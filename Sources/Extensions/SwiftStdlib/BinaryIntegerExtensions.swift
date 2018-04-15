//
//  BinaryIntegerExtensions.swift
//  SwifterSwift
//
//  Created by Guy Kogus on 11/04/2018.
//  Copyright © 2018 SwifterSwift
//

public extension BinaryInteger {

    /// SwifterSwift: Generate a random integer within a given range.
    ///
    /// - Parameters:
    ///   - lowerBound: The lower bound of the integer range. Defaults to 0.
    ///   - upperBound: The upper bound of the integer range.
    /// - Returns: An integer between `lowerBound` and `upperBound` (exclusive).
    /// - Warning: This is an unsafe implementation.
    ///
    ///   It will crash for signed integers where `upperBound - lowerBound` has a value that can't be represented
    ///   (e.g. `Int16.min..<Int16.max`).
    ///
    ///   It will crash for 64-bit integers, since it relies on `arc4random_uniform`, which provides a 32-bit random number.
    public static func random(lowerBound: Self = 0, upperBound: Self) -> Self {
        assert(lowerBound < upperBound)

        let distance = upperBound - lowerBound
        return lowerBound + numericCast(arc4random_uniform(numericCast(distance)))
    }

}
