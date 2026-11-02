// UICollectionView+RegisterCellWithClass.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

public extension UICollectionView {
    /// SwifterSwift: Registers a cell class, using the class name as the reuse identifier.
    ///
    /// The reuse identifier is `String(describing: cellClass)`: the bare class name, such as `"ProfileCell"`, without
    /// the module or any enclosing types. Dequeue the cell with that identifier, for example
    /// `dequeueReusableCell(withReuseIdentifier: "ProfileCell", for: indexPath)`. Registering replaces any class or nib
    /// registered earlier under the same identifier, so two cell classes with the same name, nested in different types,
    /// can't both be registered on one collection view.
    ///
    /// `UICollectionView.CellRegistration` (iOS 14) is the modern alternative: it needs no identifier and configures
    /// the cell in a closure.
    ///
    /// ```swift
    /// collectionView.register(cellWithClass: PhotoCell.self)
    /// collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath)  // A PhotoCell.
    /// ```
    ///
    /// - Parameter cellClass: The class of the cell to register. Its name is the reuse identifier.
    func register(cellWithClass cellClass: (some UICollectionViewCell).Type) {
        register(cellClass, forCellWithReuseIdentifier: String(describing: cellClass))
    }
}
#endif
