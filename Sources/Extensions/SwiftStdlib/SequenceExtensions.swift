//
//  SequenceExtensions.swift
//  SwifterSwift
//
//  Created by Anton Novoselov on 04/04/2018.
//  Copyright © 2018 SwifterSwift
//

#if canImport(Foundation)
import Foundation
#endif

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

    /// SwifterSwift: Get last element that satisfies a conditon.
    ///
    ///        [2, 2, 4, 7].last(where: {$0 % 2 == 0}) -> 4
    ///
    /// - Parameter condition: condition to evaluate each element against.
    /// - Returns: the last element in the array matching the specified condition. (optional)
    public func last(where condition: (Element) throws -> Bool) rethrows -> Element? {
        for element in reversed() {
            if try condition(element) { return element }
        }
        return nil
    }

    /// SwifterSwift: Filter elements based on a rejection condition.
    ///
    ///        [2, 2, 4, 7].reject(where: {$0 % 2 == 0}) -> [7]
    ///
    /// - Parameter condition: to evaluate the exclusion of an element from the array.
    /// - Returns: the array with rejected values filtered from it.
    public func reject(where condition: (Element) throws -> Bool) rethrows -> [Element] {
        return try filter { return try !condition($0) }
    }

    /// SwifterSwift: Get element count based on condition.
    ///
    ///        [2, 2, 4, 7].count(where: {$0 % 2 == 0}) -> 3
    ///
    /// - Parameter condition: condition to evaluate each element against.
    /// - Returns: number of times the condition evaluated to true.
    public func count(where condition: (Element) throws -> Bool) rethrows -> Int {
        var count = 0
        for element in self where try condition(element) {
            count += 1
        }
        return count
    }

    /// SwifterSwift: Iterate over a collection in reverse order. (right to left)
    ///
    ///        [0, 2, 4, 7].forEachReversed({ print($0)}) -> //Order of print: 7,4,2,0
    ///
    /// - Parameter body: a closure that takes an element of the array as a parameter.
    public func forEachReversed(_ body: (Element) throws -> Void) rethrows {
        try reversed().forEach(body)
    }

    /// SwifterSwift: Calls the given closure with each element where condition is true.
    ///
    ///        [0, 2, 4, 7].forEach(where: {$0 % 2 == 0}, body: { print($0)}) -> //print: 0, 2, 4
    ///
    /// - Parameters:
    ///   - condition: condition to evaluate each element against.
    ///   - body: a closure that takes an element of the array as a parameter.
    public func forEach(where condition: (Element) throws -> Bool, body: (Element) throws -> Void) rethrows {
        for element in self where try condition(element) {
            try body(element)
        }
    }

    /// SwifterSwift: Reduces an array while returning each interim combination.
    ///
    ///     [1, 2, 3].accumulate(initial: 0, next: +) -> [1, 3, 6]
    ///
    /// - Parameters:
    ///   - initial: initial value.
    ///   - next: closure that combines the accumulating value and next element of the array.
    /// - Returns: an array of the final accumulated value and each interim combination.
    public func accumulate<U>(initial: U, next: (U, Element) throws -> U) rethrows -> [U] {
        var runningTotal = initial
        return try map { element in
            runningTotal = try next(runningTotal, element)
            return runningTotal
        }
    }

    /// SwifterSwift: Filtered and map in a single operation.
    ///
    ///     [1,2,3,4,5].filtered({ $0 % 2 == 0 }, map: { $0.string }) -> ["2", "4"]
    ///
    /// - Parameters:
    ///   - isIncluded: condition of inclusion to evaluate each element against.
    ///   - transform: transform element function to evaluate every element.
    /// - Returns: Return an filtered and mapped array.
    public func filtered<T>(_ isIncluded: (Element) throws -> Bool, map transform: (Element) throws -> T) rethrows ->  [T] {
        return try compactMap({
            if try isIncluded($0) {
                return try transform($0)
            }
            return nil
        })
    }

    /// SwifterSwift: Get the only element based on a condition.
    ///
    ///     [].single(where: {_ in true}) -> nil
    ///     [4].single(where: {_ in true}) -> 4
    ///     [1, 4, 7].single(where: {$0 % 2 == 0}) -> 4
    ///     [2, 2, 4, 7].single(where: {$0 % 2 == 0}) -> nil
    ///
    /// - Parameter condition: condition to evaluate each element against.
    /// - Returns: The only element in the array matching the specified condition. If there are more matching elements, nil is returned. (optional)
    public func single(where condition: ((Element) throws -> Bool)) rethrows -> Element? {
        var singleElement: Element?
        for element in self where try condition(element) {
            guard singleElement == nil else {
                singleElement = nil
                break
            }
            singleElement = element
        }
        return singleElement
    }

}

public extension Sequence where Element: Equatable {

    /// SwifterSwift: Check if array contains an array of elements.
    ///
    ///        [1, 2, 3, 4, 5].contains([1, 2]) -> true
    ///        [1.2, 2.3, 4.5, 3.4, 4.5].contains([2, 6]) -> false
    ///        ["h", "e", "l", "l", "o"].contains(["l", "o"]) -> true
    ///
    /// - Parameter elements: array of elements to check.
    /// - Returns: true if array contains all given items.
    public func contains(_ elements: [Element]) -> Bool {
        guard !elements.isEmpty else { return true }
        for element in elements {
            if !contains(element) {
                return false
            }
        }
        return true
    }

}

public extension Sequence where Element: Hashable {

    /// SwifterSwift: Check whether a sequence contains duplicates.
    ///
    /// - Returns: true if the receiver contains duplicates.
    public func containsDuplicates() -> Bool {
        var set = Set<Element>()
        for element in self {
            if !set.insert(element).inserted {
                return true
            }
        }
        return false
    }

}

// MARK: - Methods (Numeric)
public extension Sequence where Element: Numeric {

    /// SwifterSwift: Sum of all elements in array.
    ///
    ///        [1, 2, 3, 4, 5].sum() -> 15
    ///
    /// - Returns: sum of the array's elements.
    public func sum() -> Element {
        return reduce(0, {$0 + $1})
    }

}
