//
//  ArrayExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/5/16.
//  Copyright © 2016 SwifterSwift
//

// MARK: - Methods
public extension Array {

    /// SwifterSwift: Insert an element at the beginning of array.
    ///
    ///        [2, 3, 4, 5].prepend(1) -> [1, 2, 3, 4, 5]
    ///        ["e", "l", "l", "o"].prepend("h") -> ["h", "e", "l", "l", "o"]
    ///
    /// - Parameter newElement: element to insert.
    mutating func prepend(_ newElement: Element) {
        insert(newElement, at: 0)
    }

    /// SwifterSwift: Safely swap values at given index positions.
    ///
    ///        [1, 2, 3, 4, 5].safeSwap(from: 3, to: 0) -> [4, 2, 3, 1, 5]
    ///        ["h", "e", "l", "l", "o"].safeSwap(from: 1, to: 0) -> ["e", "h", "l", "l", "o"]
    ///
    /// - Parameters:
    ///   - index: index of first element.
    ///   - otherIndex: index of other element.
    mutating func safeSwap(from index: Index, to otherIndex: Index) {
        guard index != otherIndex else { return }
        guard startIndex..<endIndex ~= index else { return }
        guard startIndex..<endIndex ~= otherIndex else { return }
        swapAt(index, otherIndex)
    }

    /// SwifterSwift: Separates array into 2 arrays based on a given predicate.
    ///
    ///     [0, 1, 2, 3, 4, 5].divided { $0 % 2 == 0 } -> ( [0, 2, 4], [1, 3, 5] )
    ///
    /// - Parameter condition: condition to evaluate each element against.
    /// - Returns: Two arrays, the first containing the elements for which the specified condition evaluates to true, the second containing the rest.
    func divided(by condition: (Element) throws -> Bool) rethrows -> (matching: [Element], nonMatching: [Element]) {
        //Inspired by: http://ruby-doc.org/core-2.5.0/Enumerable.html#method-i-partition
        var matching = [Element]()
        var nonMatching = [Element]()
        for element in self {
            try condition(element) ? matching.append(element) : nonMatching.append(element)
        }
        return (matching, nonMatching)
    }

    /// SwifterSwift: Returns a sorted array based on an optional keypath.
    ///
    /// - Parameter path: Key path to sort. The key path type must be Comparable.
    /// - Parameter ascending: If order must be ascending.
    /// - Returns: Sorted array based on keyPath.
    func sorted<T: Comparable>(by path: KeyPath<Element, T?>, ascending: Bool = true) -> [Element] {
        return sorted(by: { (lhs, rhs) -> Bool in
            guard let lhsValue = lhs[keyPath: path], let rhsValue = rhs[keyPath: path] else { return false }
            return ascending ? (lhsValue < rhsValue) : (lhsValue > rhsValue)
        })
    }

    /// SwifterSwift: Returns a sorted array based on a keypath.
    ///
    /// - Parameter path: Key path to sort. The key path type must be Comparable.
    /// - Parameter ascending: If order must be ascending.
    /// - Returns: Sorted array based on keyPath.
    func sorted<T: Comparable>(by path: KeyPath<Element, T>, ascending: Bool = true) -> [Element] {
        return sorted(by: { (lhs, rhs) -> Bool in
            return ascending ? (lhs[keyPath: path] < rhs[keyPath: path]) : (lhs[keyPath: path] > rhs[keyPath: path])
        })
    }

    /// SwifterSwift: Sort the array based on an optional keypath.
    ///
    /// - Parameters:
    ///   - path: Key path to sort, must be Comparable.
    ///   - ascending: whether order is ascending or not.
    /// - Returns: self after sorting.
    @discardableResult
    mutating func sort<T: Comparable>(by path: KeyPath<Element, T?>, ascending: Bool = true) -> [Element] {
        self = sorted(by: path, ascending: ascending)
        return self
    }

    /// SwifterSwift: Sort the array based on a keypath.
    ///
    /// - Parameters:
    ///   - path: Key path to sort, must be Comparable.
    ///   - ascending: whether order is ascending or not.
    /// - Returns: self after sorting.
    @discardableResult
    mutating func sort<T: Comparable>(by path: KeyPath<Element, T>, ascending: Bool = true) -> [Element] {
        self = sorted(by: path, ascending: ascending)
        return self
    }

    /// SwifterSwift: Remove all duplicate elements from Array.
    ///
    ///        [1, -1, 2, -4, 3, 3, 3, 4, -5].removeDuplicates { abs($0) == abs($1) } -> [1, 2, -4, 3, -5]
    ///
    /// - Parameters:
    ///   - comparator: Returns true if 2 elements of array are equal.
    /// - Returns: Return array with all duplicate elements removed.
    @discardableResult
    mutating func removeDuplicates(by comparator: (Element, Element) -> Bool) -> [Element] {
        self = withoutDuplicates(by: comparator)
        return self
    }

    /// SwifterSwift: Remove all duplicate elements from Array.
    ///
    /// - Parameters:
    ///   - path: Key path to compare, must be Equatable
    /// - Returns: Return array with all duplicate elements removed.
    @discardableResult
    mutating func removeDuplicates<E: Equatable>(keyPath path: KeyPath<Element, E>) -> [Element] {
        self = withoutDuplicates(keyPath: path)
        return self
    }

    /// SwifterSwift: Return array with all duplicate elements removed.
    ///
    ///     [1, -1, 2, -4, 3, 3, 3, 4, -5].withoutDuplicates { abs($0) == abs($1) } -> [1, 2, -4, 3, -5]
    ///
    /// - Parameters:
    ///   - comparator: Returns true if 2 elements of array are equal.
    /// - Returns: an array of unique elements.
    ///
    func withoutDuplicates(by comparator: (Element, Element) -> Bool) -> [Element] {
        // Thanks to https://github.com/sairamkotha for improving the method
        return reduce(into: [Element]()) { result, element in
            if !result.contains { comparator($0, element) } {
                result.append(element)
            }
        }
    }

    /// SwifterSwift: Return array with all duplicate elements removed.
    ///
    /// - Parameters:
    ///   - path: Key path to compare, must be Equatable
    /// - Returns: an array of unique elements.
    ///
    func withoutDuplicates<E: Equatable>(keyPath path: KeyPath<Element, E>) -> [Element] {
        return withoutDuplicates { $0[keyPath: path] == $1[keyPath: path] }
    }
}

// MARK: - Methods (Equatable)
public extension Array where Element: Equatable {

    /// SwifterSwift: Remove all instances of an item from array.
    ///
    ///        [1, 2, 2, 3, 4, 5].removeAll(2) -> [1, 3, 4, 5]
    ///        ["h", "e", "l", "l", "o"].removeAll("l") -> ["h", "e", "o"]
    ///
    /// - Parameter item: item to remove.
    /// - Returns: self after removing all instances of item.
    @discardableResult
    mutating func removeAll(_ item: Element) -> [Element] {
        removeAll(where: { $0 == item })
        return self
    }

    /// SwifterSwift: Remove all instances contained in items parameter from array.
    ///
    ///        [1, 2, 2, 3, 4, 5].removeAll([2,5]) -> [1, 3, 4]
    ///        ["h", "e", "l", "l", "o"].removeAll(["l", "h"]) -> ["e", "o"]
    ///
    /// - Parameter items: items to remove.
    /// - Returns: self after removing all instances of all items in given array.
    @discardableResult
    mutating func removeAll(_ items: [Element]) -> [Element] {
        guard !items.isEmpty else { return self }
        removeAll(where: { items.contains($0) })
        return self
    }

    /// SwifterSwift: Remove all duplicate elements from Array.
    ///
    ///        [1, 2, 2, 3, 4, 5].removeDuplicates() -> [1, 2, 3, 4, 5]
    ///        ["h", "e", "l", "l", "o"]. removeDuplicates() -> ["h", "e", "l", "o"]
    ///
    /// - Returns: Return array with all duplicate elements removed.
    @discardableResult
    mutating func removeDuplicates() -> [Element] {
        return removeDuplicates(by: ==)
    }

    /// SwifterSwift: Return array with all duplicate elements removed.
    ///
    ///     [1, 1, 2, 2, 3, 3, 3, 4, 5].withoutDuplicates() -> [1, 2, 3, 4, 5])
    ///     ["h", "e", "l", "l", "o"].withoutDuplicates() -> ["h", "e", "l", "o"])
    ///
    /// - Returns: an array of unique elements.
    ///
    func withoutDuplicates() -> [Element] {
        return withoutDuplicates(by: ==)
    }

}

// MARK: - Methods (Hashable)
public extension Array where Element: Hashable {

    /// SwifterSwift: Remove all duplicate elements from Array.
    ///
    ///        [1, -1, 2, -4, 3, 3, 3, 4, -5].removeDuplicates { abs($0) == abs($1) } -> [1, 2, -4, 3, -5]
    ///
    /// - Parameters:
    ///   - comparator: Returns true if 2 elements of array are equal.
    /// - Returns: Return array with all duplicate elements removed.
    @discardableResult
    mutating func removeDuplicates(by comparator: (Element, Element) -> Bool) -> [Element] {
        self = withoutDuplicates(by: comparator)
        return self
    }

    /// SwifterSwift: Remove all duplicate elements from Array.
    ///
    /// - Parameters:
    ///   - path: Key path to compare, must be Equatable
    /// - Returns: Return array with all duplicate elements removed.
    @discardableResult
    mutating func removeDuplicates<E: Equatable>(keyPath path: KeyPath<Element, E>) -> [Element] {
        self = withoutDuplicates(keyPath: path)
        return self
    }

    /// SwifterSwift: Remove all duplicate elements from Array.
    ///
    ///        [1, 2, 2, 3, 4, 5].removeDuplicates() -> [1, 2, 3, 4, 5]
    ///        ["h", "e", "l", "l", "o"]. removeDuplicates() -> ["h", "e", "l", "o"]
    ///
    /// - Returns: Return array with all duplicate elements removed.
    @discardableResult
    mutating func removeDuplicates() -> [Element] {
        return removeDuplicates(by: ==)
    }

    /// SwifterSwift: Return array with all duplicate elements removed.
    ///
    ///     [1, -1, 2, -4, 3, 3, 3, 4, -5].withoutDuplicates { abs($0) == abs($1) } -> [1, 2, -4, 3, -5]
    ///
    /// - Parameters:
    ///   - comparator: Returns true if 2 elements of array are equal.
    /// - Returns: an array of unique elements.
    ///
    func withoutDuplicates(by comparator: (Element, Element) -> Bool) -> [Element] {
        return Array(reduce(into: Set<Element>()) { result, element in
            if !result.contains { comparator($0, element) } {
                result.insert(element)
            }
        })
    }

    /// SwifterSwift: Return array with all duplicate elements removed.
    ///
    /// - Parameters:
    ///   - path: Key path to compare, must be Equatable
    /// - Returns: an array of unique elements.
    ///
    func withoutDuplicates<E: Equatable>(keyPath path: KeyPath<Element, E>) -> [Element] {
        return withoutDuplicates { $0[keyPath: path] == $1[keyPath: path] }
    }

    /// SwifterSwift: Return array with all duplicate elements removed.
    ///
    ///     [1, 1, 2, 2, 3, 3, 3, 4, 5].withoutDuplicates() -> [1, 2, 3, 4, 5])
    ///     ["h", "e", "l", "l", "o"].withoutDuplicates() -> ["h", "e", "l", "o"])
    ///
    /// - Returns: an array of unique elements.
    ///
    func withoutDuplicates() -> [Element] {
        return withoutDuplicates(by: ==)
    }
}
