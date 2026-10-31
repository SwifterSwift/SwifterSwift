// UICollectionView+IndexPathForLastItemInSection.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import Foundation
import UIKit

public extension UICollectionView {
    /// SwifterSwift: Returns the index path of a section's last item, or `nil` if the section is empty or missing.
    ///
    /// The result is always a valid index path for the collection view, so it's safe to pass to APIs such as
    /// `scrollToItem(at:at:animated:)`. Negative sections and sections past the end return `nil` instead of trapping.
    ///
    /// ```swift
    /// // A collection view with 5 items in section 0 and an empty section 1.
    /// collectionView.indexPathForLastItem(inSection: 0)  // [0, 4]
    /// collectionView.indexPathForLastItem(inSection: 1)  // nil
    /// collectionView.indexPathForLastItem(inSection: 2)  // nil
    /// ```
    ///
    /// - Parameter section: The index of the section.
    /// - Returns: The index path of the last item in `section`, or `nil` if `section` is out of range or has no items.
    func indexPathForLastItem(inSection section: Int) -> IndexPath? {
        guard section >= 0, section < numberOfSections else { return nil }
        let count = numberOfItems(inSection: section)
        return count > 0 ? IndexPath(item: count - 1, section: section) : nil
    }
}
#endif
