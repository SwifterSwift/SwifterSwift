// UICollectionView+RegisterNibWithCellClassBundle.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS) && !os(visionOS)
import Foundation
import UIKit

public extension UICollectionView {
    /// SwifterSwift: Registers the nib named after a cell class, using the class name as the reuse identifier too.
    ///
    /// The name is `String(describing: cellClass)`: the bare class name, such as `"PhotoCell"`, without the module or
    /// any enclosing types. So `PhotoCell` is loaded from `PhotoCell.nib` (compiled from `PhotoCell.xib`) and registered
    /// under the identifier `"PhotoCell"`. The nib must contain exactly one top-level object, a cell of that class.
    ///
    /// The nib is loaded lazily, so a missing nib isn't reported here: UIKit raises an exception when it first dequeues
    /// the cell. Pass the bundle that contains the nib, for example `Bundle.module` in a Swift package or
    /// `Bundle(for: PhotoCell.self)` in a framework; `nil` means the main bundle.
    ///
    /// It isn't available on visionOS, where nibs are deprecated.
    ///
    /// ```swift
    /// collectionView.register(nibWithCellClass: PhotoCell.self, bundle: .module)
    /// collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath)  // A PhotoCell from the nib.
    /// ```
    ///
    /// - Parameters:
    ///   - cellClass: The class of the cell in the nib. Its name is the nib name and the reuse identifier.
    ///   - bundle: The bundle that contains the nib, or `nil` for the main bundle.
    func register(nibWithCellClass cellClass: (some UICollectionViewCell).Type, bundle: Bundle?) {
        let name = String(describing: cellClass)
        register(UINib(nibName: name, bundle: bundle), forCellWithReuseIdentifier: name)
    }
}
#endif
