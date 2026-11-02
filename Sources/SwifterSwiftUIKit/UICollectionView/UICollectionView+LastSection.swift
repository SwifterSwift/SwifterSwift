// UICollectionView+LastSection.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

public extension UICollectionView {
    /// SwifterSwift: The index of the last section, or `nil` if the collection view has no sections.
    ///
    /// The value comes from `numberOfSections`, so it reflects what the collection view knows about its data source, and
    /// it counts empty sections too. Unlike `numberOfSections - 1`, it never returns `-1`.
    ///
    /// ```swift
    /// // A collection view with 3 sections.
    /// collectionView.lastSection  // 2
    ///
    /// // A collection view with no sections.
    /// collectionView.lastSection  // nil
    /// ```
    var lastSection: Int? {
        let count = numberOfSections
        return count > 0 ? count - 1 : nil
    }
}
#endif
