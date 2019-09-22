//
//  StdlibDeprecated.swift
//  SwifterSwift
//
//  Created by Luciano Almeida on 21/09/19.
//  Copyright © 2019 SwifterSwift
//

private func optionalCompareAscending<T: Comparable>(path1: T?, path2: T?) -> Bool {
    guard let path1 = path1, let path2 = path2 else { return false }
    return path1 < path2
}

private func optionalCompareDescending<T: Comparable>(path1: T?, path2: T?) -> Bool {
    guard let path1 = path1, let path2 = path2 else { return false }
    return path1 > path2
}

public extension Array {

    /// SwifterSwift: Returns a sorted array based on an optional keypath.
    ///
    /// - Parameter path: Key path to sort. The key path type must be Comparable.
    /// - Parameter ascending: If order must be ascending.
    /// - Returns: Sorted array based on keyPath.
    @available(*, deprecated, message: "Use sorted(by:with:) instead.")
    func sorted<T: Comparable>(by path: KeyPath<Element, T?>, ascending: Bool) -> [Element] {
        if ascending {
            return sorted(by: path, with: optionalCompareAscending)
        }
        return sorted(by: path, with: optionalCompareDescending)
    }

    /// SwifterSwift: Returns a sorted array based on a keypath.
    ///
    /// - Parameter path: Key path to sort. The key path type must be Comparable.
    /// - Parameter ascending: If order must be ascending.
    /// - Returns: Sorted array based on keyPath.
    @available(*, deprecated, message: "Use sorted(by:with:) instead.")
    func sorted<T: Comparable>(by path: KeyPath<Element, T>, ascending: Bool) -> [Element] {
        if ascending {
            return sorted(by: path, with: <)
        }
        return sorted(by: path, with: >)
    }

    /// SwifterSwift: Sort the array based on an optional keypath.
    ///
    /// - Parameters:
    ///   - path: Key path to sort, must be Comparable.
    ///   - ascending: whether order is ascending or not.
    /// - Returns: self after sorting.
    @available(*, deprecated, message: "Use sort(by:with:) instead.")
    @discardableResult
    mutating func sort<T: Comparable>(by path: KeyPath<Element, T?>, ascending: Bool) -> [Element] {
        if ascending {
            sort(by: path, with: optionalCompareAscending)
        } else {
            sort(by: path, with: optionalCompareDescending)
        }
        return self
    }

    /// SwifterSwift: Sort the array based on a keypath.
    ///
    /// - Parameters:
    ///   - path: Key path to sort, must be Comparable.
    ///   - ascending: whether order is ascending or not.
    /// - Returns: self after sorting.
    @available(*, deprecated, message: "Use sort(by:with:) instead.")
    @discardableResult
    mutating func sort<T: Comparable>(by path: KeyPath<Element, T>, ascending: Bool) -> [Element] {
        if ascending {
            sort(by: path, with: <)
        } else {
            sort(by: path, with: >)
        }
        return self
    }

}
