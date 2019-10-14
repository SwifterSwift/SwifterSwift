//
//  BidirectionalCollectionExtensions.swift
//  SwifterSwift
//
//  Created by Quentin Jin on 2018/10/13.
//  Copyright © 2018 SwifterSwift
//

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

}
