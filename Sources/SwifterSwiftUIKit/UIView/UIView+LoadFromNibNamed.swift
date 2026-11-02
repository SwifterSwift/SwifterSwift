// UIView+LoadFromNibNamed.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS) && !os(visionOS)
import Foundation
import UIKit

public extension UIView {
    /// SwifterSwift: Loads a nib from a bundle and returns its first top-level view.
    ///
    /// The nib is instantiated with no owner, and the first of its top-level objects that is a `UIView` is returned,
    /// so objects that come before it, such as gesture recognizers, are skipped. The result is `nil` when the name is
    /// empty, the bundle has no nib with that name, or the nib has no top-level view. In those cases `UINib` alone
    /// raises an exception or returns no view.
    ///
    /// The name is the nib's file name without its extension: a `ProfileCard.xib` in the project is compiled to
    /// `ProfileCard.nib`. Interface Builder files are deprecated on visionOS, so this method isn't available there.
    ///
    /// ```swift
    /// let card = UIView.loadFromNib(named: "ProfileCard")  // the root view of ProfileCard.xib
    /// UIView.loadFromNib(named: "Missing")  // nil
    /// ```
    ///
    /// - Parameters:
    ///   - name: The name of the nib file, without the `.nib` extension.
    ///   - bundle: The bundle that contains the nib.
    /// - Returns: The first top-level view of the nib, or `nil` if the nib can't be found or has no top-level view.
    /// - Complexity: O(*n*), where *n* is the number of objects in the nib.
    static func loadFromNib(named name: String, bundle: Bundle = .main) -> UIView? {
        guard !name.isEmpty, bundle.path(forResource: name, ofType: "nib") != nil else { return nil }
        let objects = UINib(nibName: name, bundle: bundle).instantiate(withOwner: nil)
        return objects.first { $0 is UIView } as? UIView
    }
}
#endif
