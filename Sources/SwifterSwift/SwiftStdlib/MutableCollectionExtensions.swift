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
