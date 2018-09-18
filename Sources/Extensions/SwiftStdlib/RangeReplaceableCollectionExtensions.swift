//
//  RangeReplaceableCollectionExtensions.swift
//  SwifterSwift
//
//  Created by Luciano Almeida on 7/2/18.
//  Copyright © 2018 SwifterSwift
//

#if canImport(Foundation)
import Foundation
#endif

// MARK: - Initializers
extension RangeReplaceableCollection {

    /// Creates a new collection of a given size where for each position of the collection the value will be the result
    /// of a call of the given expression.
    ///
    ///     let values = Array(expression: "Value", count: 3)
    ///     print(values)
    ///     // Prints "["Value", "Value", "Value"]"
    ///
    /// - Parameters:
    ///   - expression: The expression to execute for each position of the collection.
    ///   - count: The count of the collection.
    public init(expression: @autoclosure () throws -> Element, count: Int) rethrows {
        self.init()
        if count > 0 { //swiftlint:disable:this empty_count
            reserveCapacity(count)
            while self.count < count {
                append(try expression())
            }
        }
    }

}

// MARK: - Methods
extension RangeReplaceableCollection {

    /// SwifterSwift: Returns a new rotated collection by the given places.
    ///
    ///     [1, 2, 3, 4].rotated(by: 1) -> [4,1,2,3]
    ///     [1, 2, 3, 4].rotated(by: 3) -> [2,3,4,1]
    ///     [1, 2, 3, 4].rotated(by: -1) -> [2,3,4,1]
    ///
    /// - Parameter places: Number of places that the array be rotated. If the value is positive the end becomes the start, if it negative it's that start becom the end.
    /// - Returns: The new rotated collection.
    public func rotated(by places: Int) -> Self {
        //Inspired by: https://ruby-doc.org/core-2.2.0/Array.html#method-i-rotate
        var copy = self
        return copy.rotate(by: places)
    }

    /// SwifterSwift: Rotate the collection by the given places.
    ///
    ///     [1, 2, 3, 4].rotate(by: 1) -> [4,1,2,3]
    ///     [1, 2, 3, 4].rotate(by: 3) -> [2,3,4,1]
    ///     [1, 2, 3, 4].rotated(by: -1) -> [2,3,4,1]
    ///
    /// - Parameter places: The number of places that the array should be rotated. If the value is positive the end becomes the start, if it negative it's that start become the end.
    /// - Returns: self after rotating.
    @discardableResult
    public mutating func rotate(by places: Int) -> Self {
        guard places != 0 else { return self }
        let placesToMove = places%count
        if placesToMove > 0 {
            let range = index(endIndex, offsetBy: -placesToMove)...
            let slice = self[range]
            removeSubrange(range)
            insert(contentsOf: slice, at: startIndex)
        } else {
            let range = startIndex..<index(startIndex, offsetBy: -placesToMove)
            let slice = self[range]
            removeSubrange(range)
            append(contentsOf: slice)
        }
        return self
    }

    /// SwifterSwift: Removes the first element of the collection which satisfies the given predicate.
    ///
    ///        [1, 2, 2, 3, 4, 2, 5].removeFirst { $0 % 2 == 0 } -> [1, 2, 3, 4, 2, 5]
    ///        ["h", "e", "l", "l", "o"].removeFirst { $0 == "e" } -> ["h", "l", "l", "o"]
    ///
    /// - Parameter predicate: A closure that takes an element as its argument and returns a Boolean value that indicates whether the passed element represents a match.
    /// - Returns: The first element for which predicate returns true, after removing it. If no elements in the collection satisfy the given predicate, returns `nil`.
    @discardableResult
    public mutating func removeFirst(where predicate: (Element) throws -> Bool) rethrows -> Element? {
        guard let index = try index(where: predicate) else { return nil }
        return remove(at: index)
    }

    #if canImport(Foundation)
    /// SwifterSwift: Remove a random value from the collection.
    @discardableResult public mutating func removeRandomElement() -> Element? {
        guard !isEmpty else { return nil }
        return remove(at: index(startIndex, offsetBy: Int.random(in: 0..<count)))
    }
    #endif

}
