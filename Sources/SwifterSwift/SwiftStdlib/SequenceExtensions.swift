//
//  SequenceExtensions.swift
//  SwifterSwift
//
//  Created by Anton Novoselov on 04/04/2018.
//  Copyright © 2018 SwifterSwift
//

public extension Sequence {

    /// SwifterSwift: Check if all elements in collection match a conditon.
    ///
    ///        [2, 2, 4].all(matching: {$0 % 2 == 0}) -> true
    ///        [1,2, 2, 4].all(matching: {$0 % 2 == 0}) -> false
    ///
    /// - Parameter condition: condition to evaluate each element against.
    /// - Returns: true when all elements in the array match the specified condition.
    func all(matching condition: (Element) throws -> Bool) rethrows -> Bool {
        return try !contains { try !condition($0) }
    }

    /// SwifterSwift: Check if no elements in collection match a conditon.
    ///
    ///        [2, 2, 4].none(matching: {$0 % 2 == 0}) -> false
    ///        [1, 3, 5, 7].none(matching: {$0 % 2 == 0}) -> true
    ///
    /// - Parameter condition: condition to evaluate each element against.
    /// - Returns: true when no elements in the array match the specified condition.
    func none(matching condition: (Element) throws -> Bool) rethrows -> Bool {
        return try !contains { try condition($0) }
    }

    /// SwifterSwift: Check if any element in collection match a conditon.
    ///
    ///        [2, 2, 4].any(matching: {$0 % 2 == 0}) -> false
    ///        [1, 3, 5, 7].any(matching: {$0 % 2 == 0}) -> true
    ///
    /// - Parameter condition: condition to evaluate each element against.
    /// - Returns: true when no elements in the array match the specified condition.
    func any(matching condition: (Element) throws -> Bool) rethrows -> Bool {
        return try contains { try condition($0) }
    }

    /// SwifterSwift: Get last element that satisfies a conditon.
    ///
    ///        [2, 2, 4, 7].last(where: {$0 % 2 == 0}) -> 4
    ///
    /// - Parameter condition: condition to evaluate each element against.
    /// - Returns: the last element in the array matching the specified condition. (optional)
    func last(where condition: (Element) throws -> Bool) rethrows -> Element? {
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
    func reject(where condition: (Element) throws -> Bool) rethrows -> [Element] {
        return try filter { return try !condition($0) }
    }

    /// SwifterSwift: Get element count based on condition.
    ///
    ///        [2, 2, 4, 7].count(where: {$0 % 2 == 0}) -> 3
    ///
    /// - Parameter condition: condition to evaluate each element against.
    /// - Returns: number of times the condition evaluated to true.
    func count(where condition: (Element) throws -> Bool) rethrows -> Int {
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
    func forEachReversed(_ body: (Element) throws -> Void) rethrows {
        try reversed().forEach(body)
    }

    /// SwifterSwift: Calls the given closure with each element where condition is true.
    ///
    ///        [0, 2, 4, 7].forEach(where: {$0 % 2 == 0}, body: { print($0)}) -> //print: 0, 2, 4
    ///
    /// - Parameters:
    ///   - condition: condition to evaluate each element against.
    ///   - body: a closure that takes an element of the array as a parameter.
    func forEach(where condition: (Element) throws -> Bool, body: (Element) throws -> Void) rethrows {
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
    func accumulate<U>(initial: U, next: (U, Element) throws -> U) rethrows -> [U] {
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
    func filtered<T>(_ isIncluded: (Element) throws -> Bool, map transform: (Element) throws -> T) rethrows ->  [T] {
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
    func single(where condition: ((Element) throws -> Bool)) rethrows -> Element? {
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

    /// SwifterSwift: Remove duplicate elements based on condition.
    ///
    ///        [1, 2, 1, 3, 2].withoutDuplicates { $0 } -> [1, 2, 3]
    ///        [(1, 4), (2, 2), (1, 3), (3, 2), (2, 1)].withoutDuplicates { $0.0 } -> [(1, 4), (2, 2), (3, 2)]
    ///
    /// - Parameter transform: A closure that should return the value to be evaluated for repeating elements.
    /// - Returns: Sequence without repeating elements
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    func withoutDuplicates<T: Hashable>(transform: (Element) throws -> T) rethrows -> [Element] {
        var set = Set<T>()
        return try filter { set.insert(try transform($0)).inserted }
    }

    /// SwifterSwift: Separates all items into 2 lists based on a given predicate.
    /// The first list contains all items for which the specified condition evaluates to true.
    /// The second list contains those that don't.
    ///
    ///     let (even, odd) = [0, 1, 2, 3, 4, 5].divided { $0 % 2 == 0 }
    ///     let (minors, adults) = people.divided { $0.age < 18 }
    ///
    /// - Parameter condition: condition to evaluate each element against.
    /// - Returns: A tuple of matched and non-matched items
    func divided(by condition: (Element) throws -> Bool) rethrows -> (matching: [Element], nonMatching: [Element]) {
        //Inspired by: http://ruby-doc.org/core-2.5.0/Enumerable.html#method-i-partition
        var matching = ContiguousArray<Element>()
        var nonMatching = ContiguousArray<Element>()

        var iterator = self.makeIterator()
        while let element = iterator.next() {
            try condition(element) ? matching.append(element) : nonMatching.append(element)
        }
        return (Array(matching), Array(nonMatching))
    }

    /// SwifterSwift: Return a sorted array  based on a keypath and a compare function.
    ///
    /// - Parameter path: Key path to sort. The key path type must be Comparable.
    /// - Parameter compare: Comparation function that will determine the ordering.
    /// - Returns: The sorted array.
    func sorted<T>(by keyPath: KeyPath<Element, T>, with compare: (T, T) -> Bool) -> [Element] {
        return sorted { compare($0[keyPath: keyPath], $1[keyPath: keyPath]) }
    }

    /// SwifterSwift: Return a sorted array  based on a keypath and a compare function.
    ///
    /// - Parameter path: Key path to sort. The key path type must be Comparable.
    /// - Returns: The sorted array.
    func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        return sorted { $0[keyPath: keyPath] < $1[keyPath: keyPath] }
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
    func contains(_ elements: [Element]) -> Bool {
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
    func containsDuplicates() -> Bool {
        var set = Set<Element>()
        for element in self {
            if !set.insert(element).inserted {
                return true
            }
        }
        return false
    }

    /// SwifterSwift: Getting the duplicated elements in a sequence.
    ///
    ///     [1, 1, 2, 2, 3, 3, 3, 4, 5].duplicates().sorted() -> [1, 2, 3])
    ///     ["h", "e", "l", "l", "o"].duplicates().sorted() -> ["l"])
    ///
    /// - Returns: An array of duplicated elements.
    ///
    func duplicates() -> [Element] {
        var set = Set<Element>()
        var duplicates = Set<Element>()
        forEach {
            if !set.insert($0).inserted {
                duplicates.insert($0)
            }
        }
        return Array(duplicates)
    }
}

// MARK: - Methods (Numeric)
public extension Sequence where Element: Numeric {

    /// SwifterSwift: Sum of all elements in array.
    ///
    ///        [1, 2, 3, 4, 5].sum() -> 15
    ///
    /// - Returns: sum of the array's elements.
    func sum() -> Element {
        return reduce(into: 0, +=)
    }

}
