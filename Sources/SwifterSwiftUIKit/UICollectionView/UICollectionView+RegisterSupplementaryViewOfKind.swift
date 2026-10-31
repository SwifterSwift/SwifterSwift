// UICollectionView+RegisterSupplementaryViewOfKind.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

public extension UICollectionView {
    /// SwifterSwift: Registers a supplementary view class, using the class name as the reuse identifier.
    ///
    /// Supplementary views are views such as section headers and footers.
    ///
    /// The reuse identifier is `String(describing: viewClass)`: the bare class name, such as `"SectionHeaderView"`,
    /// without the module or any enclosing types. The kind is defined by the layout, for example
    /// `UICollectionView.elementKindSectionHeader` for a flow layout's headers. Dequeue the view with the same kind and
    /// identifier, for example with `dequeueReusableSupplementaryView(ofKind:withReuseIdentifier:for:)`. Registering
    /// replaces any class or nib registered earlier for the same kind and identifier; registrations for other kinds are
    /// kept.
    ///
    /// `UICollectionView.SupplementaryRegistration` (iOS 14) is the modern alternative: it needs no identifier and
    /// configures the view in a closure.
    ///
    /// ```swift
    /// let kind = UICollectionView.elementKindSectionHeader
    /// collectionView.register(supplementaryViewOfKind: kind, withClass: SectionHeaderView.self)
    /// collectionView.dequeueReusableSupplementaryView(
    ///     ofKind: kind, withReuseIdentifier: "SectionHeaderView", for: indexPath)  // A SectionHeaderView.
    /// ```
    ///
    /// - Parameters:
    ///   - kind: The kind of supplementary view, as defined by the layout.
    ///   - viewClass: The class of the view to register. Its name is the reuse identifier.
    func register(supplementaryViewOfKind kind: String, withClass viewClass: (some UICollectionReusableView).Type) {
        register(viewClass, forSupplementaryViewOfKind: kind, withReuseIdentifier: String(describing: viewClass))
    }
}
#endif
