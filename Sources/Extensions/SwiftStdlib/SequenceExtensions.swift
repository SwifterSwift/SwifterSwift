//
//  SequenceExtensions.swift
//  SwifterSwift
//
//  Created by Anton Novoselov on 04/04/2018.
//  Copyright © 2018 SwifterSwift
//

import Foundation

public extension Sequence {

    /// SwifterSwift: Check if all elements in collection match a conditon.
    ///
    ///        [2, 2, 4].all(matching: {$0 % 2 == 0}) -> true
    ///        [1,2, 2, 4].all(matching: {$0 % 2 == 0}) -> false
    ///
    /// - Parameter condition: condition to evaluate each element against.
    /// - Returns: true when all elements in the array match the specified condition.
    public func all(matching condition: (Element) throws -> Bool) rethrows -> Bool {
        return try !contains { try !condition($0) }
    }

    /// SwifterSwift: Check if no elements in collection match a conditon.
    ///
    ///        [2, 2, 4].none(matching: {$0 % 2 == 0}) -> false
    ///        [1, 3, 5, 7].none(matching: {$0 % 2 == 0}) -> true
    ///
    /// - Parameter condition: condition to evaluate each element against.
    /// - Returns: true when no elements in the array match the specified condition.
    public func none(matching condition: (Element) throws -> Bool) rethrows -> Bool {
        return try !contains { try condition($0) }
    }

    /// SwifterSwift: Check if any element in collection match a conditon.
    ///
    ///        [2, 2, 4].any(matching: {$0 % 2 == 0}) -> false
    ///        [1, 3, 5, 7].any(matching: {$0 % 2 == 0}) -> true
    ///
    /// - Parameter condition: condition to evaluate each element against.
    /// - Returns: true when no elements in the array match the specified condition.
    public func any(matching condition: (Element) throws -> Bool) rethrows -> Bool {
        return try contains { try condition($0) }
    }

}
