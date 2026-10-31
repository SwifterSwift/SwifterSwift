// UIView+LoadFromNibWithClass.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS) && !os(visionOS)
import Foundation
import UIKit

public extension UIView {
    /// SwifterSwift: Loads the nib named after a view class and returns its first top-level view of that class.
    ///
    /// The nib's name is the unqualified name of the class, so `ProfileCardView` is loaded from `ProfileCardView.nib`,
    /// the compiled form of `ProfileCardView.xib`, even when the class is nested in another type. The nib is
    /// instantiated with no owner, and the first of its top-level objects that is an instance of the class is returned.
    /// The result is `nil`, instead of a crash, when the bundle has no nib with that name or the nib has no top-level
    /// view of the class.
    ///
    /// Interface Builder files are deprecated on visionOS, so this method isn't available there.
    ///
    /// ```swift
    /// let card = UIView.loadFromNib(withClass: ProfileCardView.self)  // ProfileCardView?
    /// UIView.loadFromNib(withClass: UITableViewCell.self)  // nil
    /// ```
    ///
    /// - Parameters:
    ///   - type: The class of the view, whose name is also the name of the nib.
    ///   - bundle: The bundle that contains the nib.
    /// - Returns: The first top-level view of type `T` in the nib, or `nil` if the nib can't be found or has no such
    ///   view.
    /// - Complexity: O(*n*), where *n* is the number of objects in the nib.
    static func loadFromNib<T: UIView>(withClass type: T.Type, bundle: Bundle = .main) -> T? {
        let name = String(describing: type)
        guard bundle.path(forResource: name, ofType: "nib") != nil else { return nil }
        let objects = UINib(nibName: name, bundle: bundle).instantiate(withOwner: nil)
        return objects.first { $0 is T } as? T
    }
}
#endif
