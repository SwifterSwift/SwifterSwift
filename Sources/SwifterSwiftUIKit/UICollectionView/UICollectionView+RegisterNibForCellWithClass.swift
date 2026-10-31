// UICollectionView+RegisterNibForCellWithClass.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS) && !os(visionOS)
import UIKit

public extension UICollectionView {
    /// SwifterSwift: Registers a nib for a cell class, using the class name as the reuse identifier.
    ///
    /// The reuse identifier is `String(describing: cellClass)`: the bare class name, such as `"PhotoCell"`, without the
    /// module or any enclosing types. The nib must contain exactly one top-level object, a cell of that class.
    /// Registering replaces any class or nib registered earlier under the same identifier, and passing `nil` for `nib`
    /// removes the registration.
    ///
    /// It isn't available on visionOS, where nibs are deprecated.
    ///
    /// ```swift
    /// collectionView.register(nib: UINib(nibName: "PhotoCell", bundle: .main), forCellWithClass: PhotoCell.self)
    /// collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath)  // A PhotoCell from the nib.
    /// ```
    ///
    /// - Parameters:
    ///   - nib: The nib that contains the cell, or `nil` to remove the registration.
    ///   - cellClass: The class of the cell in the nib. Its name is the reuse identifier.
    func register(nib: UINib?, forCellWithClass cellClass: (some UICollectionViewCell).Type) {
        register(nib, forCellWithReuseIdentifier: String(describing: cellClass))
    }
}
#endif
