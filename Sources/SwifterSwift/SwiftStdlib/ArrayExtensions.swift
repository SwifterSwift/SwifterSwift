// ArrayExtensions.swift - Copyright 2024 SwifterSwift

// MARK: - Initializers

public extension Array {
    /// SwifterSwift: Creates an array with specified number of elements, for each element it calls specified closure.
    /// - Parameters:
    ///   - count: The number of elements in the new array.
    ///   - element: A closure that initializes each element.
    ///     - Parameter *index*: An index of initialized element in the array.
    ///     - Returns: element of the array.
    init(count: Int, element: (Int) throws -> Element) rethrows {
        try self.init(unsafeUninitializedCapacity: count) { buffer, initializedCount in
            for index in 0..<count {
                try buffer.baseAddress?.advanced(by: index).initialize(to: element(index))
            }
            initializedCount = count
        }
    }
}

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

    /// SwifterSwift: Sort an array like another array based on a key path. If the other array doesn't contain a certain
    /// value, it will be sorted last.
    ///
    ///        [MyStruct(x: 3), MyStruct(x: 1), MyStruct(x: 2)].sorted(like: [1, 2, 3], keyPath: \.x)
    ///            -> [MyStruct(x: 1), MyStruct(x: 2), MyStruct(x: 3)]
    ///
    /// - Parameters:
    ///   - otherArray: array containing elements in the desired order.
    ///   - keyPath: keyPath indicating the property that the array should be sorted by
    /// - Returns: sorted array.
    func sorted<T: Hashable>(like otherArray: [T], keyPath: KeyPath<Element, T>) -> [Element] {
        let dict = otherArray.enumerated().reduce(into: [:]) { $0[$1.element] = $1.offset }
        return sorted {
            guard let thisIndex = dict[$0[keyPath: keyPath]] else { return false }
            guard let otherIndex = dict[$1[keyPath: keyPath]] else { return true }
            return thisIndex < otherIndex
        }
    }
    
    /// SwifterSwift:  Get safe item at index
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
    /// SwifterSwift: chunked array to array of array
    /// - Parameters
    ///     - size: number of item in child array
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
    
    /// SwifterSwift: take item from 0..<count
    func take(count:Int) -> ArraySlice<Element> {
        return self[0..<count]
    }
    
    /// SwifterSwift: take item from count..<self.count(End)
    func drop(count:Int) -> ArraySlice<Element> {
        return self[count..<self.count]
    }
    
    /// SwifterSwift: get first index of element
    func index<T: Equatable>(of element: T) -> Int? {
        firstIndex(where: { ($0 as? T) == element })
    }

    var tuple: Any {
        switch count {
        case 0:
            return ()
        case 1:
            return (self[0])
        case 2:
            return (self[0], self[1])
        case 3:
            return (self[0], self[1], self[2])
        case 4:
            return (self[0], self[1], self[2], self[3])
        case 5:
            return (self[0], self[1], self[2], self[3], self[4])
        case 6:
            return (self[0], self[1], self[2], self[3], self[4], self[5])
        case 7:
            return (self[0], self[1], self[2], self[3], self[4], self[5], self[6])
        case 8:
            return (self[0], self[1], self[2], self[3], self[4], self[5], self[6], self[7])
        case 9:
            return (self[0], self[1], self[2], self[3], self[4], self[5], self[6], self[7], self[8])
        case 10:
            return (self[0], self[1], self[2], self[3], self[4], self[5], self[6], self[7], self[8], self[9])
        default:
            print("Can currently only create tuples from arrays with up to 10 elements. Elements at index 11 and up will be lost")
            return (self[0], self[1], self[2], self[3], self[4], self[5], self[6], self[7], self[8], self[9], self[10])
        }
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
        // Thanks to https://github.com/sairamkotha for improving the method
        self = reduce(into: [Element]()) {
            if !$0.contains($1) {
                $0.append($1)
            }
        }
        return self
    }

    /// SwifterSwift: Return array with all duplicate elements removed.
    ///
    ///     [1, 1, 2, 2, 3, 3, 3, 4, 5].withoutDuplicates() -> [1, 2, 3, 4, 5])
    ///     ["h", "e", "l", "l", "o"].withoutDuplicates() -> ["h", "e", "l", "o"])
    ///
    /// - Returns: an array of unique elements.
    ///
    func withoutDuplicates() -> [Element] {
        // Thanks to https://github.com/sairamkotha for improving the method
        return reduce(into: [Element]()) {
            if !$0.contains($1) {
                $0.append($1)
            }
        }
    }

    /// SwifterSwift: Returns an array with all duplicate elements removed using KeyPath to compare.
    ///
    /// - Parameter path: Key path to compare, the value must be Equatable.
    /// - Returns: an array of unique elements.
    func withoutDuplicates<E: Equatable>(keyPath path: KeyPath<Element, E>) -> [Element] {
        return reduce(into: [Element]()) { result, element in
            if !result.contains(where: { $0[keyPath: path] == element[keyPath: path] }) {
                result.append(element)
            }
        }
    }

    /// SwifterSwift: Returns an array with all duplicate elements removed using KeyPath to compare.
    ///
    /// - Parameter path: Key path to compare, the value must be Hashable.
    /// - Returns: an array of unique elements.
    func withoutDuplicates<E: Hashable>(keyPath path: KeyPath<Element, E>) -> [Element] {
        var set = Set<E>()
        return filter { set.insert($0[keyPath: path]).inserted }
    }
}


// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/
public extension Array where Element: Comparable {
    func sameElements(_ arr: [Element]) -> Bool {
        guard self.count == arr.count else { return false }
        let sorted = self.sorted(by: <)
        let arrSorted = arr.sorted(by: <)
        for elements in sorted.zip(arrSorted) where elements.0 != elements.1 {
            return false
        }
        return true
    }
}

public extension Array {
    func contains(_ x: Element, f: (Element, Element) -> Bool) -> Bool {
        for y in self where f(x, y) {
            return true
        }
        return false
    }

    // Performs a union operator using the result of f(Element) as the value to base uniqueness on.
    func union<T: Hashable>(_ arr: [Element], f: (Element) -> T) -> [Element] {
        let result = self + arr
        return result.unique(f)
    }

    // Returns unique values in an array using the result of f()
    func unique<T: Hashable>(_ f: (Element) -> T) -> [Element] {
        var map: [T: Element] = [T: Element]()
        return self.compactMap { a in
            let t = f(a)
            if map[t] == nil {
                map[t] = a
                return a
            } else {
                return nil
            }
        }
    }

    /// Removes the first element of the Array and returns the rest of the array.
    /// If the array is empty, it returns an empty array.
    var tail: Array {
        return Array(self.dropFirst())
    }
}

public extension Array where Element: NSAttributedString {
    /// If the array is made up of `NSAttributedStrings`, this allows the reduction
    /// of the array into a single `NSAttributedString`.
    func joined() -> NSAttributedString {
        return self.reduce(NSMutableAttributedString()) { result, element in
            result.append(element)
            return result
        }
    }
}
