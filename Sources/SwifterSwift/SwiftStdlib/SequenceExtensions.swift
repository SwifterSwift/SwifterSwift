// SequenceExtensions.swift - Copyright 2024 SwifterSwift

public extension Sequence {
    /// SwifterSwift: Check if all elements in collection match a condition.
    ///
    ///        [2, 2, 4].all(matching: {$0 % 2 == 0}) -> true
    ///        [1,2, 2, 4].all(matching: {$0 % 2 == 0}) -> false
    ///
    /// - Parameter condition: condition to evaluate each element against.
    /// - Returns: true when all elements in the array match the specified condition.
    func all(matching condition: (Element) throws -> Bool) rethrows -> Bool {
        return try !contains { try !condition($0) }
    }

    /// SwifterSwift: Check if no elements in collection match a condition.
    ///
    ///        [2, 2, 4].none(matching: {$0 % 2 == 0}) -> false
    ///        [1, 3, 5, 7].none(matching: {$0 % 2 == 0}) -> true
    ///
    /// - Parameter condition: condition to evaluate each element against.
    /// - Returns: true when no elements in the array match the specified condition.
    func none(matching condition: (Element) throws -> Bool) rethrows -> Bool {
        return try !contains { try condition($0) }
    }

    /// SwifterSwift: Check if any element in collection match a condition.
    ///
    ///        [2, 2, 4].any(matching: {$0 % 2 == 0}) -> false
    ///        [1, 3, 5, 7].any(matching: {$0 % 2 == 0}) -> true
    ///
    /// - Parameter condition: condition to evaluate each element against.
    /// - Returns: true when no elements in the array match the specified condition.
    func any(matching condition: (Element) throws -> Bool) rethrows -> Bool {
        return try contains { try condition($0) }
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
    ///        [0, 2, 4, 7].forEachReversed({ print($0)}) -> // Order of print: 7,4,2,0
    ///
    /// - Parameter body: a closure that takes an element of the array as a parameter.
    func forEachReversed(_ body: (Element) throws -> Void) rethrows {
        try reversed().forEach(body)
    }

    /// SwifterSwift: Calls the given closure with each element where condition is true.
    ///
    ///        [0, 2, 4, 7].forEach(where: {$0 % 2 == 0}, body: { print($0)}) -> // print: 0, 2, 4
    ///
    /// - Parameters:
    ///   - condition: condition to evaluate each element against.
    ///   - body: a closure that takes an element of the array as a parameter.
    func forEach(where condition: (Element) throws -> Bool, body: (Element) throws -> Void) rethrows {
        try lazy.filter(condition).forEach(body)
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
    func filtered<T>(_ isIncluded: (Element) throws -> Bool, map transform: (Element) throws -> T) rethrows -> [T] {
        return try lazy.filter(isIncluded).map(transform)
    }

    /// SwifterSwift: Get the only element based on a condition.
    ///
    ///     [].single(where: {_ in true}) -> nil
    ///     [4].single(where: {_ in true}) -> 4
    ///     [1, 4, 7].single(where: {$0 % 2 == 0}) -> 4
    ///     [2, 2, 4, 7].single(where: {$0 % 2 == 0}) -> nil
    ///
    /// - Parameter condition: condition to evaluate each element against.
    /// - Returns: The only element in the array matching the specified condition. If there are more matching elements,
    /// nil is returned. (optional)
    func single(where condition: (Element) throws -> Bool) rethrows -> Element? {
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
        return try filter { try set.insert(transform($0)).inserted }
    }

    ///  SwifterSwift: Separates all items into 2 lists based on a given predicate. The first list contains all items
    /// for which the specified condition evaluates to true. The second list contains those that don't.
    ///
    ///     let (even, odd) = [0, 1, 2, 3, 4, 5].divided { $0 % 2 == 0 }
    ///     let (minors, adults) = people.divided { $0.age < 18 }
    ///
    /// - Parameter condition: condition to evaluate each element against.
    /// - Returns: A tuple of matched and non-matched items
    func divided(by condition: (Element) throws -> Bool) rethrows -> (matching: [Element], nonMatching: [Element]) {
        // Inspired by: http://ruby-doc.org/core-2.5.0/Enumerable.html#method-i-partition
        var matching = [Element]()
        var nonMatching = [Element]()

        for element in self {
            // swiftlint:disable:next void_function_in_ternary
            try condition(element) ? matching.append(element) : nonMatching.append(element)
        }
        return (matching, nonMatching)
    }

    /// SwifterSwift: Return a sorted array based on a key path and a compare function.
    ///
    /// - Parameter keyPath: Key path to sort by.
    /// - Parameter compare: Comparison function that will determine the ordering.
    /// - Returns: The sorted array.
    func sorted<T>(by keyPath: KeyPath<Element, T>, with compare: (T, T) -> Bool) -> [Element] {
        return sorted { compare($0[keyPath: keyPath], $1[keyPath: keyPath]) }
    }

    /// SwifterSwift: Return a sorted array based on a map function and a compare function.
    ///
    /// - Parameter map: Function that defines the property to sort by.
    /// - Parameter compare: Comparison function that will determine the ordering.
    /// - Returns: The sorted array.
    func sorted<T>(by map: (Element) throws -> T, with compare: (T, T) -> Bool) rethrows -> [Element] {
        return try sorted { try compare(map($0), map($1)) }
    }

    /// SwifterSwift: Return a sorted array based on a key path.
    ///
    /// - Parameter keyPath: Key path to sort by. The key path type must be Comparable.
    /// - Returns: The sorted array.
    func sorted(by keyPath: KeyPath<Element, some Comparable>) -> [Element] {
        return sorted { $0[keyPath: keyPath] < $1[keyPath: keyPath] }
    }

    /// SwifterSwift: Return a sorted array based on a map function.
    ///
    /// - Parameter map: Function that defines the property to sort by. The output type must be Comparable.
    /// - Returns: The sorted array.
    func sorted(by map: (Element) throws -> some Comparable) rethrows -> [Element] {
        return try sorted { try map($0) < map($1) }
    }

    /// SwifterSwift: Returns a sorted sequence based on two key paths. The second one will be used in case the values
    /// of the first one match.
    ///
    /// - Parameters:
    ///     - keyPath1: Key path to sort by. Must be Comparable.
    ///     - keyPath2: Key path to sort by in case the values of `keyPath1` match. Must be Comparable.
    func sorted(by keyPath1: KeyPath<Element, some Comparable>,
                and keyPath2: KeyPath<Element, some Comparable>) -> [Element] {
        return sorted {
            if $0[keyPath: keyPath1] != $1[keyPath: keyPath1] {
                return $0[keyPath: keyPath1] < $1[keyPath: keyPath1]
            }
            return $0[keyPath: keyPath2] < $1[keyPath: keyPath2]
        }
    }

    /// SwifterSwift: Returns a sorted sequence based on two map functions. The second one will be used in case the
    /// values of the first one match.
    ///
    /// - Parameters:
    ///     - map1: Map function to sort by. Output type must be Comparable.
    ///     - map2: Map function to sort by in case the values of `map1` match. Output type must be Comparable.
    func sorted(by map1: (Element) throws -> some Comparable,
                and map2: (Element) throws -> some Comparable) rethrows -> [Element] {
        return try sorted {
            let value10 = try map1($0)
            let value11 = try map1($1)
            if value10 != value11 {
                return value10 < value11
            }
            return try map2($0) < map2($1)
        }
    }

    /// SwifterSwift: Returns a sorted sequence based on three key paths. Whenever the values of one key path match, the
    /// next one will be used.
    ///
    /// - Parameters:
    ///     - keyPath1: Key path to sort by. Must be Comparable.
    ///     - keyPath2: Key path to sort by in case the values of `keyPath1` match. Must be Comparable.
    ///     - keyPath3: Key path to sort by in case the values of `keyPath1` and `keyPath2` match. Must be Comparable.
    func sorted(by keyPath1: KeyPath<Element, some Comparable>,
                and keyPath2: KeyPath<Element, some Comparable>,
                and keyPath3: KeyPath<Element, some Comparable>)
        -> [Element] {
        return sorted {
            if $0[keyPath: keyPath1] != $1[keyPath: keyPath1] {
                return $0[keyPath: keyPath1] < $1[keyPath: keyPath1]
            }
            if $0[keyPath: keyPath2] != $1[keyPath: keyPath2] {
                return $0[keyPath: keyPath2] < $1[keyPath: keyPath2]
            }
            return $0[keyPath: keyPath3] < $1[keyPath: keyPath3]
        }
    }

    /// SwifterSwift: Returns a sorted sequence based on three map functions. Whenever the values of one map function
    /// match, the next one will be used.
    ///
    /// - Parameters:
    ///     - map1: Map function to sort by. Output type must be Comparable.
    ///     - map2: Map function to sort by in case the values of `map1` match. Output type must be Comparable.
    ///     - map3: Map function to sort by in case the values of `map1` and `map2` match.
    ///     Output type must be Comparable.
    func sorted(by map1: (Element) throws -> some Comparable,
                and map2: (Element) throws -> some Comparable,
                and map3: (Element) throws -> some Comparable) rethrows
        -> [Element] {
        return try sorted {
            let value10 = try map1($0)
            let value11 = try map1($1)
            if value10 != value11 {
                return value10 < value11
            }

            let value20 = try map2($0)
            let value21 = try map2($1)
            if value20 != value21 {
                return value20 < value21
            }
            return try map3($0) < map3($1)
        }
    }

    /// SwifterSwift: Sum of a `AdditiveArithmetic` property of each `Element` in a `Sequence`.
    ///
    ///     ["James", "Wade", "Bryant"].sum(for: \.count) -> 15
    ///
    /// - Parameter keyPath: Key path of the `AdditiveArithmetic` property.
    /// - Returns: The sum of the `AdditiveArithmetic` properties at `keyPath`.
    func sum<T: AdditiveArithmetic>(for keyPath: KeyPath<Element, T>) -> T {
        // Inspired by: https://swiftbysundell.com/articles/reducers-in-swift/
        return reduce(.zero) { $0 + $1[keyPath: keyPath] }
    }

    /// SwifterSwift: Product of all elements in sequence.
    ///
    ///        ["James", "Wade", "Bryant"].product(for: \.count) -> 120
    ///
    /// - Parameter map: Mapping function to `Numeric` value.
    /// - Returns: product of the sequence's elements.
    func product<T: Numeric>(for map: (Element) -> T) -> T {
        reduce(1) { $0 * map($1) }
    }

    /// SwifterSwift: Sum of a `AdditiveArithmetic` property of each `Element` in a `Sequence`.
    ///
    ///     ["James", "Wade", "Bryant"].sum(for: \.count) -> 15
    ///
    /// - Parameter map: Getter for  the `AdditiveArithmetic` property.
    /// - Returns: The sum of the `AdditiveArithmetic` properties at `map`.
    func sum<T: AdditiveArithmetic>(for map: (Element) throws -> T) rethrows -> T {
        // Inspired by: https://swiftbysundell.com/articles/reducers-in-swift/
        return try reduce(.zero) { try $0 + map($1) }
    }

    /// SwifterSwift: Returns the first element of the sequence with having property by given key path equals to given
    /// `value`.
    ///
    /// - Parameters:
    ///   - keyPath: The `KeyPath` of property for `Element` to compare.
    ///   - value: The value to compare with `Element` property.
    /// - Returns: The first element of the collection that has property by given key path equals to given `value` or
    /// `nil` if there is no such element.
    func first<T: Equatable>(where keyPath: KeyPath<Element, T>, equals value: T) -> Element? {
        return first { $0[keyPath: keyPath] == value }
    }

    /// SwifterSwift: Returns the first element of the sequence with having property by given key path equals to given
    /// `value`.
    ///
    /// - Parameters:
    ///   - map: Function for `Element` to compare.
    ///   - value: The value to compare with `Element` property.
    /// - Returns: The first element of the collection that has property by given map function equals to given `value`
    /// or `nil` if there is no such element.
    func first<T: Equatable>(where map: (Element) throws -> T, equals value: T) rethrows -> Element? {
        return try first { try map($0) == value }
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
    /// - Returns: true if sequence contains all given items.
    /// - Complexity: _O(m·n)_, where _m_ is the length of `elements` and _n_ is the length of this sequence.
    func contains<S>(_ elements: S) -> Bool where S: Sequence, Element == S.Element {
        return elements.allSatisfy { contains($0) }
    }
}

public extension Sequence where Element: Hashable {
    /// SwifterSwift: Check if sequence contains elements of another sequence.
    ///
    ///        [1, 2, 3, 4, 5].contains([1, 2]) -> true
    ///        [1.2, 2.3, 4.5, 3.4, 4.5].contains([2, 6]) -> false
    ///        ["h", "e", "l", "l", "o"].contains(["l", "o"]) -> true
    ///
    /// - Parameter elements: sequence of elements to check.
    /// - Returns: true if sequence contains all given items.
    /// - Complexity: _O(m + n)_, where _m_ is the length of `elements` and _n_ is the length of this sequence.
    func contains<S: Sequence>(_ elements: S) -> Bool where Element == S.Element {
        let set = Set(self)
        return elements.allSatisfy { set.contains($0) }
    }

    /// SwifterSwift: Check whether a sequence contains duplicates.
    ///
    /// - Returns: true if the receiver contains duplicates.
    func containsDuplicates() -> Bool {
        var set = Set<Element>()
        return contains { !set.insert($0).inserted }
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

// MARK: - Methods (AdditiveArithmetic)

public extension Sequence where Element: AdditiveArithmetic {
    /// SwifterSwift: Sum of all elements in array.
    ///
    ///        [1, 2, 3, 4, 5].sum() -> 15
    ///
    /// - Returns: sum of the array's elements.
    func sum() -> Element {
        return reduce(.zero, +)
    }
}

// MARK: - Methods (Numeric)

public extension Sequence where Element: Numeric {
    /// SwifterSwift: Product of all elements in sequence.
    ///
    ///        [1, 2, 3, 4, 5].product() -> 120
    ///
    /// - Returns: product of the sequence's elements.
    func product() -> Element { reduce(1, *) }
}
