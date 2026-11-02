// RangeReplaceableCollection+RemoveDuplicatesBy.swift - Copyright 2026 SwifterSwift

public extension RangeReplaceableCollection {
    /// SwifterSwift: Removes elements whose key repeats an earlier element's key, keeping the first for each key.
    ///
    /// The remaining elements keep their original order, and `key` is called once per element. You can pass a key
    /// path, such as `\.id`. This overload compares each key with the keys kept so far; when the keys are `Hashable`,
    /// a linear-time overload is used instead.
    ///
    /// ```swift
    /// var tags = [Tag(name: "swift", color: .orange), Tag(name: "ios", color: .blue), Tag(name: "go", color: .blue)]
    /// tags.removeDuplicates(by: \.color)
    /// tags.map(\.name)  // ["swift", "ios"]
    /// ```
    ///
    /// - Parameter key: A closure that returns the value to compare for an element.
    /// - Throws: Rethrows any error thrown by `key`. The collection is left unchanged when it throws.
    /// - Complexity: O(*n*²), where *n* is the length of the collection.
    mutating func removeDuplicates<Key: Equatable>(by key: (Element) throws -> Key) rethrows {
        var keptKeys: [Key] = []
        var unique = Self()
        for element in self {
            let elementKey = try key(element)
            if !keptKeys.contains(elementKey) {
                keptKeys.append(elementKey)
                unique.append(element)
            }
        }
        self = unique
    }
}

public extension RangeReplaceableCollection {
    /// SwifterSwift: Removes elements whose key repeats an earlier element's key, keeping the first for each key.
    ///
    /// The remaining elements keep their original order, and `key` is called once per element. You can pass a key
    /// path, such as `\.id`. The keys seen so far are tracked in a `Set`, so this overload runs in linear time.
    ///
    /// ```swift
    /// var words = ["apple", "avocado", "banana", "blueberry", "cherry"]
    /// words.removeDuplicates(by: \.first)
    /// words  // ["apple", "banana", "cherry"]
    /// ```
    ///
    /// - Parameter key: A closure that returns the value to compare for an element.
    /// - Throws: Rethrows any error thrown by `key`. The collection is left unchanged when it throws.
    /// - Complexity: O(*n*), where *n* is the length of the collection.
    mutating func removeDuplicates<Key: Hashable>(by key: (Element) throws -> Key) rethrows {
        var seenKeys = Set<Key>()
        var unique = Self()
        for element in self where try seenKeys.insert(key(element)).inserted {
            unique.append(element)
        }
        self = unique
    }
}
