// UICollectionView+DequeueReusableSupplementaryView.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import Foundation
import UIKit

public extension UICollectionView {
    /// SwifterSwift: Dequeues a supplementary view of a kind and class, using the class name as the reuse identifier.
    ///
    /// The reuse identifier is `String(describing: viewClass)`: the bare class name, such as `"SectionHeaderView"`,
    /// without the module or any enclosing types. Register the view for `kind` under that identifier first, with
    /// `register(_:forSupplementaryViewOfKind:withReuseIdentifier:)` for a class or a nib.
    ///
    /// This calls `dequeueReusableSupplementaryView(ofKind:withReuseIdentifier:for:)`, so the same rules apply: UIKit
    /// raises an exception if nothing is registered for the kind and identifier, and the view must be dequeued when the
    /// collection view asks for one, in `collectionView(_:viewForSupplementaryElementOfKind:at:)` or a diffable data
    /// source's supplementary view provider, and then returned to it.
    ///
    /// The method returns `nil` when the dequeued view isn't a `View`, for example because another class was registered
    /// under the same name. The collection view still expects the view it handed out, so returning a different view
    /// then makes UIKit raise an exception: treat `nil` as a registration mistake to fix, not a case to recover from.
    ///
    /// ```swift
    /// let kind = UICollectionView.elementKindSectionHeader
    /// collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: kind,
    ///                         withReuseIdentifier: "SectionHeaderView")
    ///
    /// // In collectionView(_:viewForSupplementaryElementOfKind:at:):
    /// let header = collectionView.dequeueReusableSupplementaryView(
    ///     ofKind: kind, withClass: SectionHeaderView.self, for: indexPath)  // SectionHeaderView?
    /// ```
    ///
    /// - Parameters:
    ///   - kind: The kind of supplementary view, as defined by the layout.
    ///   - viewClass: The class of the view to dequeue. Its name is the reuse identifier.
    ///   - indexPath: The index path of the view, which the collection view uses to lay it out.
    /// - Returns: A view of type `View`, or `nil` if the view registered for the kind and identifier isn't a `View`.
    func dequeueReusableSupplementaryView<View: UICollectionReusableView>(
        ofKind kind: String, withClass viewClass: View.Type, for indexPath: IndexPath
    ) -> View? {
        dequeueReusableSupplementaryView(
            ofKind: kind, withReuseIdentifier: String(describing: viewClass), for: indexPath) as? View
    }
}
#endif
