// UICollectionView+NumberOfItems.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

public extension UICollectionView {
    /// SwifterSwift: Returns the total number of items in all sections.
    ///
    /// This adds up `numberOfItems(inSection:)` for every section, so it reflects what the collection view knows about
    /// its data source. It returns `0` when there are no sections.
    ///
    /// ```swift
    /// // A collection view with 5 items in section 0 and 3 in section 1.
    /// collectionView.numberOfItems()  // 8
    /// ```
    ///
    /// - Returns: The number of items in the collection view.
    /// - Complexity: O(*n*), where *n* is the number of sections.
    func numberOfItems() -> Int {
        var count = 0
        for section in 0..<numberOfSections {
            count += numberOfItems(inSection: section)
        }
        return count
    }
}
#endif
