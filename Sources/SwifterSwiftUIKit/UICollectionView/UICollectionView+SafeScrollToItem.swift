// UICollectionView+SafeScrollToItem.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import Foundation
import UIKit

public extension UICollectionView {
    /// SwifterSwift: Scrolls to an item if the index path is valid, and does nothing otherwise.
    ///
    /// `scrollToItem(at:at:animated:)` raises an exception for an index path that doesn't exist. This method checks the
    /// index path first: it must have exactly two indices, a section in `0..<numberOfSections` and an item in
    /// `0..<numberOfItems(inSection:)`. That makes it safe to call with an index path that may be stale, for example after
    /// the data changed.
    ///
    /// ```swift
    /// // A collection view with 5 items in section 0.
    /// collectionView.safeScrollToItem(at: IndexPath(item: 4, section: 0), at: .bottom, animated: true)  // Scrolls.
    /// collectionView.safeScrollToItem(at: IndexPath(item: 9, section: 0), at: .bottom, animated: true)  // Does nothing.
    /// ```
    ///
    /// - Parameters:
    ///   - indexPath: The index path of the item to scroll into view.
    ///   - scrollPosition: Where the item should be positioned when scrolling finishes.
    ///   - animated: `true` to animate the scrolling; `false` to scroll immediately.
    func safeScrollToItem(at indexPath: IndexPath, at scrollPosition: UICollectionView.ScrollPosition, animated: Bool) {
        guard indexPath.count == 2,
            indexPath.section >= 0,
            indexPath.section < numberOfSections,
            indexPath.item >= 0,
            indexPath.item < numberOfItems(inSection: indexPath.section)
        else { return }
        scrollToItem(at: indexPath, at: scrollPosition, animated: animated)
    }
}
#endif
