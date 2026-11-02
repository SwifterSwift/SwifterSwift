// UICollectionView+IndexPathForLastItem.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import Foundation
import UIKit

public extension UICollectionView {
    /// SwifterSwift: The index path of the last item in the collection view, or `nil` if it has no items.
    ///
    /// Empty sections at the end are skipped, so this is the last item of the last section that has any items. The
    /// result is always a valid index path, which makes it safe to pass to APIs such as `scrollToItem(at:at:animated:)`,
    /// for example to scroll to the bottom of a feed.
    ///
    /// ```swift
    /// // A collection view with 5 items in section 0 and an empty section 1.
    /// collectionView.indexPathForLastItem  // [0, 4]
    ///
    /// // A collection view whose sections are all empty.
    /// collectionView.indexPathForLastItem  // nil
    /// ```
    ///
    /// - Complexity: O(*n*), where *n* is the number of sections.
    var indexPathForLastItem: IndexPath? {
        for section in (0..<numberOfSections).reversed() {
            let count = numberOfItems(inSection: section)
            if count > 0 {
                return IndexPath(item: count - 1, section: section)
            }
        }
        return nil
    }
}
#endif
