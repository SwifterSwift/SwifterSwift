// UICollectionView+IsValidIndexPath.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import Foundation
import UIKit

public extension UICollectionView {
    /// SwifterSwift: Returns a Boolean value indicating whether an index path points to an existing item.
    ///
    /// The index path is valid when it has exactly two indices, its section is in `0..<numberOfSections`, and its item
    /// is in `0..<numberOfItems(inSection:)`. Index paths with any other number of indices return `false` instead of
    /// trapping like `IndexPath.item` does.
    ///
    /// ```swift
    /// // A collection view with 5 items in section 0.
    /// collectionView.isValidIndexPath(IndexPath(item: 4, section: 0))  // true
    /// collectionView.isValidIndexPath(IndexPath(item: 5, section: 0))  // false
    /// collectionView.isValidIndexPath(IndexPath(item: -1, section: 0))  // false
    /// collectionView.isValidIndexPath(IndexPath(index: 0))  // false
    /// ```
    ///
    /// - Parameter indexPath: The index path to check.
    /// - Returns: `true` if `indexPath` identifies an item in the collection view; otherwise, `false`.
    func isValidIndexPath(_ indexPath: IndexPath) -> Bool {
        guard indexPath.count == 2 else { return false }
        return indexPath.section >= 0
            && indexPath.section < numberOfSections
            && indexPath.item >= 0
            && indexPath.item < numberOfItems(inSection: indexPath.section)
    }
}
#endif
