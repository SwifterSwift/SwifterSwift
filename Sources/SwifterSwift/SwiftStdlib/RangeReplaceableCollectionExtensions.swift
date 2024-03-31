// RangeReplaceableCollectionExtensions.swift - Copyright 2024 SwifterSwift

// MARK: - Initializers

public extension RangeReplaceableCollection {
    /// SwifterSwift: Creates a new collection of a given size where for each position of the collection the value will
    /// be the result of a call of the given expression.
    ///
    ///     let values = Array(expression: "Value", count: 3)
    ///     print(values)
    ///     // Prints "["Value", "Value", "Value"]"
    ///
    /// - Parameters:
    ///   - expression: The expression to execute for each position of the collection.
    ///   - count: The count of the collection.
    init(expression: @autoclosure () throws -> Element, count: Int) rethrows {
        self.init()
        // swiftlint:disable:next empty_count
        if count > 0 {
            reserveCapacity(count)
            while self.count < count {
                try append(expression())
            }
        }
    }
}

// MARK: - Methods

public extension RangeReplaceableCollection {
    ///  SwifterSwift: Returns a new rotated collection by the given places.
    ///
    ///     [1, 2, 3, 4].rotated(by: 1) -> [4,1,2,3]
    ///     [1, 2, 3, 4].rotated(by: 3) -> [2,3,4,1]
    ///     [1, 2, 3, 4].rotated(by: -1) -> [2,3,4,1]
    ///
    /// - Parameter places: Number of places that the array be rotated. If the value is positive the end becomes the
    /// start, if it negative it's that start become the end.
    /// - Returns: The new rotated collection.
    func rotated(by places: Int) -> Self {
        // Inspired by: https://ruby-doc.org/core-2.2.0/Array.html#method-i-rotate
        var copy = self
        return copy.rotate(by: places)
    }

    ///  SwifterSwift: Rotate the collection by the given places.
    ///
    ///     [1, 2, 3, 4].rotate(by: 1) -> [4,1,2,3]
    ///     [1, 2, 3, 4].rotate(by: 3) -> [2,3,4,1]
    ///     [1, 2, 3, 4].rotated(by: -1) -> [2,3,4,1]
    ///
    /// - Parameter places: The number of places that the array should be rotated. If the value is positive the end
    /// becomes the start, if it negative it's that start become the end.
    /// - Returns: self after rotating.
    @discardableResult
    mutating func rotate(by places: Int) -> Self {
        guard places != 0 else { return self }
        let placesToMove = places % count
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
    /// - Parameter predicate: A closure that takes an element as its argument and returns a Boolean value that
    /// indicates whether the passed element represents a match.
    /// - Returns: The first element for which predicate returns true, after removing it. If no elements in the
    /// collection satisfy the given predicate, returns `nil`.
    @discardableResult
    mutating func removeFirst(where predicate: (Element) throws -> Bool) rethrows -> Element? {
        guard let index = try firstIndex(where: predicate) else { return nil }
        return remove(at: index)
    }

    /// SwifterSwift: Remove a random value from the collection.
    @discardableResult
    mutating func removeRandomElement() -> Element? {
        guard let randomIndex = indices.randomElement() else { return nil }
        return remove(at: randomIndex)
    }

    /// SwifterSwift: Keep elements of Array while condition is true.
    ///
    ///        [0, 2, 4, 7].keep(while: { $0 % 2 == 0 }) -> [0, 2, 4]
    ///
    /// - Parameter condition: condition to evaluate each element against.
    /// - Returns: self after applying provided condition.
    /// - Throws: provided condition exception.
    @discardableResult
    mutating func keep(while condition: (Element) throws -> Bool) rethrows -> Self {
        if let idx = try firstIndex(where: { try !condition($0) }) {
            removeSubrange(idx...)
        }
        return self
    }

    /// SwifterSwift: Take element of Array while condition is true.
    ///
    ///        [0, 2, 4, 7, 6, 8].take( where: {$0 % 2 == 0}) -> [0, 2, 4]
    ///
    /// - Parameter condition: condition to evaluate each element against.
    /// - Returns: All elements up until condition evaluates to false.
    func take(while condition: (Element) throws -> Bool) rethrows -> Self {
        return try Self(prefix(while: condition))
    }

    /// SwifterSwift: Skip elements of Array while condition is true.
    ///
    ///        [0, 2, 4, 7, 6, 8].skip( where: {$0 % 2 == 0}) -> [6, 8]
    ///
    /// - Parameter condition: condition to evaluate each element against.
    /// - Returns: All elements after the condition evaluates to false.
    func skip(while condition: (Element) throws -> Bool) rethrows -> Self {
        guard let idx = try firstIndex(where: { try !condition($0) }) else { return Self() }
        return Self(self[idx...])
    }

    /// SwifterSwift: Remove all duplicate elements using KeyPath to compare.
    ///
    /// - Parameter path: Key path to compare, the value must be Equatable.
    mutating func removeDuplicates<E: Equatable>(keyPath path: KeyPath<Element, E>) {
        var items = [Element]()
        removeAll { element -> Bool in
            guard items.contains(where: { $0[keyPath: path] == element[keyPath: path] }) else {
                items.append(element)
                return false
            }
            return true
        }
    }

    /// SwifterSwift: Remove all duplicate elements using KeyPath to compare.
    ///
    /// - Parameter path: Key path to compare, the value must be Hashable.
    mutating func removeDuplicates<E: Hashable>(keyPath path: KeyPath<Element, E>) {
        var set = Set<E>()
        removeAll { !set.insert($0[keyPath: path]).inserted }
    }

    /// SwifterSwift: Accesses the element at the specified position.
    ///
    /// - Parameter offset: The offset position of the element to access. `offset` must be a valid index offset of the
    /// collection that is not equal to the `endIndex` property.
    subscript(offset: Int) -> Element {
        get {
            return self[index(startIndex, offsetBy: offset)]
        }
        set {
            let offsetIndex = index(startIndex, offsetBy: offset)
            replaceSubrange(offsetIndex..<index(after: offsetIndex), with: [newValue])
        }
    }

    /// SwifterSwift: Accesses a contiguous subrange of the collection’s elements.
    ///
    /// - Parameter range: A range of the collection’s indices offsets. The bounds of the range must be valid indices of
    /// the collection.
    subscript<R>(range: R) -> SubSequence where R: RangeExpression, R.Bound == Int {
        get {
            let indexRange = range.relative(to: 0..<count)
            return self[index(startIndex, offsetBy: indexRange.lowerBound)..<index(startIndex,
                                                                                   offsetBy: indexRange.upperBound)]
        }
        set {
            let indexRange = range.relative(to: 0..<count)
            replaceSubrange(
                index(startIndex, offsetBy: indexRange.lowerBound)..<index(startIndex, offsetBy: indexRange.upperBound),
                with: newValue)
        }
    }

    /**
     SwifterSwift: Adds a new element at the end of the array, mutates the array in place
     - Parameter newElement: The optional element to append to the array
     */
    mutating func appendIfNonNil(_ newElement: Element?) {
        guard let newElement = newElement else { return }
        append(newElement)
    }

    /**
     SwifterSwift: Adds the elements of a sequence to the end of the array, mutates the array in place
     - Parameter newElements: The optional sequence to append to the array
     */
    mutating func appendIfNonNil<S>(contentsOf newElements: S?) where Element == S.Element, S: Sequence {
        guard let newElements = newElements else { return }
        append(contentsOf: newElements)
    }
}
