// UICollectionView+RegisterNibForSupplementaryViewOfKind.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS) && !os(visionOS)
import UIKit

public extension UICollectionView {
    /// SwifterSwift: Registers a nib for a supplementary view class, using the class name as the reuse identifier.
    ///
    /// Supplementary views are views such as section headers and footers.
    ///
    /// The reuse identifier is `String(describing: viewClass)`: the bare class name, such as `"SectionHeaderView"`,
    /// without the module or any enclosing types. The nib must contain exactly one top-level object, a view of that
    /// class. The kind is defined by the layout, for example `UICollectionView.elementKindSectionHeader` for a flow
    /// layout's headers. Registering replaces any class or nib registered earlier for the same kind and identifier, and
    /// passing `nil` for `nib` removes the registration.
    ///
    /// It isn't available on visionOS, where nibs are deprecated.
    ///
    /// ```swift
    /// let kind = UICollectionView.elementKindSectionHeader
    /// let nib = UINib(nibName: "SectionHeaderView", bundle: .main)
    /// collectionView.register(nib: nib, forSupplementaryViewOfKind: kind, withClass: SectionHeaderView.self)
    /// collectionView.dequeueReusableSupplementaryView(
    ///     ofKind: kind, withReuseIdentifier: "SectionHeaderView", for: indexPath)  // A SectionHeaderView.
    /// ```
    ///
    /// - Parameters:
    ///   - nib: The nib that contains the view, or `nil` to remove the registration.
    ///   - kind: The kind of supplementary view, as defined by the layout.
    ///   - viewClass: The class of the view in the nib. Its name is the reuse identifier.
    func register(
        nib: UINib?, forSupplementaryViewOfKind kind: String, withClass viewClass: (some UICollectionReusableView).Type
    ) {
        register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: String(describing: viewClass))
    }
}
#endif
