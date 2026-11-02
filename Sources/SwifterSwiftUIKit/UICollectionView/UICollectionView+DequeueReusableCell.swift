// UICollectionView+DequeueReusableCell.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import Foundation
import UIKit

public extension UICollectionView {
    /// SwifterSwift: Dequeues a reusable cell of the given class, using the class name as the reuse identifier.
    ///
    /// The reuse identifier is `String(describing: cellClass)`: the bare class name, such as `"PhotoCell"`, without the
    /// module or any enclosing types. Register the cell under that identifier first, with
    /// `register(_:forCellWithReuseIdentifier:)` for a class or a nib, or with a storyboard prototype cell whose
    /// identifier is the class name.
    ///
    /// This calls `dequeueReusableCell(withReuseIdentifier:for:)`, so the same rules apply: UIKit raises an exception if
    /// nothing is registered for the identifier, and the cell must be dequeued when the collection view asks for one, in
    /// `collectionView(_:cellForItemAt:)` or a diffable data source's cell provider, and then returned to it.
    ///
    /// The method returns `nil` when the dequeued cell isn't a `Cell`, for example because another class was registered
    /// under the same name. The collection view still expects the cell it handed out, so returning a different cell
    /// then makes UIKit raise an exception: treat `nil` as a registration mistake to fix, not a case to recover from.
    ///
    /// ```swift
    /// collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "PhotoCell")
    ///
    /// // In collectionView(_:cellForItemAt:):
    /// let cell = collectionView.dequeueReusableCell(withClass: PhotoCell.self, for: indexPath)  // PhotoCell?
    /// cell?.imageView.image = photo.thumbnail
    /// ```
    ///
    /// - Parameters:
    ///   - cellClass: The class of the cell to dequeue. Its name is the reuse identifier.
    ///   - indexPath: The index path of the cell, which the collection view uses to lay it out.
    /// - Returns: A cell of type `Cell`, or `nil` if the cell registered for the identifier isn't a `Cell`.
    func dequeueReusableCell<Cell: UICollectionViewCell>(withClass cellClass: Cell.Type, for indexPath: IndexPath)
        -> Cell?
    {
        dequeueReusableCell(withReuseIdentifier: String(describing: cellClass), for: indexPath) as? Cell
    }
}
#endif
