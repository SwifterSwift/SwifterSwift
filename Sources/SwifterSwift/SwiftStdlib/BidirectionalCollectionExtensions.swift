// BidirectionalCollectionExtensions.swift - Copyright 2020 SwifterSwift

// MARK: - Methods

public extension BidirectionalCollection {
    /// SwifterSwift: Returns the element at the specified position. If offset is negative, the `n`th element from the end will be returned where `n` is the result of `abs(distance)`.
    ///
    ///        let arr = [1, 2, 3, 4, 5]
    ///        arr[offset: 1] -> 2
    ///        arr[offset: -2] -> 4
    ///
    /// - Parameter distance: The distance to offset.
    subscript(offset distance: Int) -> Element {
        let index = distance >= 0 ? startIndex : endIndex
        return self[indices.index(index, offsetBy: distance)]
    }

    /// SwifterSwift: Returns the last element of the sequence with having property by given key path equals to given `value`.
    ///
    /// - Parameters:
    ///   - keyPath: The `KeyPath` of property for `Element` to compare.
    ///   - value: The value to compare with `Element` property
    /// - Returns: The last element of the collection that has property by given key path equals to given `value` or `nil` if there is no such element.
    func last<T: Equatable>(where keyPath: KeyPath<Element, T>, equals value: T) -> Element? {
        return last { $0[keyPath: keyPath] == value }
    }
}
