//
//  MutableCollectionExtensions.swift
//  SwifterSwift
//
//  Created by Luciano Almeida on 21/09/19.
//  Copyright © 2019 SwifterSwift
//

public extension MutableCollection where Self: RandomAccessCollection {
    /// SwifterSwift: Sort the collection  based on a keypath and a compare function.
    ///
    /// - Parameter path: Key path to sort. The key path type must be Comparable.
    /// - Parameter compare: Comparation function that will determine the ordering.
    mutating func sort<T>(by keyPath: KeyPath<Element, T>, with compare: (T, T) -> Bool) {
        sort { compare($0[keyPath: keyPath], $1[keyPath: keyPath]) }
    }

    /// SwifterSwift: Sort the collection  based on a keypath and a compare function.
    ///
    /// - Parameter path: Key path to sort. The key path type must be Comparable.
    mutating func sort<T: Comparable>(by keyPath: KeyPath<Element, T>) {
        sort { $0[keyPath: keyPath] < $1[keyPath: keyPath] }
    }
}

public extension MutableCollection {
    /// SwifterSwift: Assign a given value to a field `keyPath` of all elements in the collection.
    ///
    /// - Parameter value: The new value of the field
    /// - Parameter keyPath: The actual field of the element
    mutating func assignToAll<Value>(value: Value, by keyPath: WritableKeyPath<Element, Value>) {
        guard !isEmpty else { return }

        var idx = startIndex
        while idx != endIndex {
            self[idx][keyPath: keyPath] = value
            idx = index(after: idx)
        }
    }
}
