// MutableCollectionExtensions.swift - Copyright 2024 SwifterSwift

public extension MutableCollection where Self: RandomAccessCollection {
    /// SwifterSwift: Sort the collection based on a keypath and a compare function.
    ///
    /// - Parameter keyPath: Key path to sort by. The key path type must be Comparable.
    /// - Parameter compare: Comparison function that will determine the ordering.
    mutating func sort<T>(by keyPath: KeyPath<Element, T>, with compare: (T, T) -> Bool) {
        sort { compare($0[keyPath: keyPath], $1[keyPath: keyPath]) }
    }

    /// SwifterSwift: Sort the collection based on a keypath.
    ///
    /// - Parameter keyPath: Key path to sort by. The key path type must be Comparable.
    mutating func sort<T: Comparable>(by keyPath: KeyPath<Element, T>) {
        sort { $0[keyPath: keyPath] < $1[keyPath: keyPath] }
    }

    /// SwifterSwift: Sort the collection based on two key paths. The second one will be used in case the values of the
    /// first one match.
    ///
    /// - Parameters:
    ///     - keyPath1: Key path to sort by. Must be Comparable.
    ///     - keyPath2: Key path to sort by in case the values of `keyPath1` match. Must be Comparable.
    mutating func sort<T: Comparable, U: Comparable>(by keyPath1: KeyPath<Element, T>,
                                                     and keyPath2: KeyPath<Element, U>) {
        sort {
            if $0[keyPath: keyPath1] != $1[keyPath: keyPath1] {
                return $0[keyPath: keyPath1] < $1[keyPath: keyPath1]
            }
            return $0[keyPath: keyPath2] < $1[keyPath: keyPath2]
        }
    }

    /// SwifterSwift: Sort the collection based on three key paths. Whenever the values of one key path match, the next
    /// one will be used.
    ///
    /// - Parameters:
    ///     - keyPath1: Key path to sort by. Must be Comparable.
    ///     - keyPath2: Key path to sort by in case the values of `keyPath1` match. Must be Comparable.
    ///     - keyPath3: Key path to sort by in case the values of `keyPath1` and `keyPath2` match. Must be Comparable.
    mutating func sort<T: Comparable, U: Comparable, V: Comparable>(by keyPath1: KeyPath<Element, T>,
                                                                    and keyPath2: KeyPath<Element, U>,
                                                                    and keyPath3: KeyPath<Element, V>) {
        sort {
            if $0[keyPath: keyPath1] != $1[keyPath: keyPath1] {
                return $0[keyPath: keyPath1] < $1[keyPath: keyPath1]
            }
            if $0[keyPath: keyPath2] != $1[keyPath: keyPath2] {
                return $0[keyPath: keyPath2] < $1[keyPath: keyPath2]
            }
            return $0[keyPath: keyPath3] < $1[keyPath: keyPath3]
        }
    }
}

public extension MutableCollection {
    /// SwifterSwift: Assign a given value to a field `keyPath` of all elements in the collection.
    ///
    /// - Parameters:
    ///   - value: The new value of the field.
    ///   - keyPath: The actual field of the element.
    mutating func assignToAll<Value>(value: Value, by keyPath: WritableKeyPath<Element, Value>) {
        for idx in indices {
            self[idx][keyPath: keyPath] = value
        }
    }
}
