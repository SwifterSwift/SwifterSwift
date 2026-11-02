// UITableView+RegisterNibWithHeaderFooterViewClass.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS) && !os(visionOS)
import UIKit

public extension UITableView {
    /// SwifterSwift: Registers a nib for a header or footer view class, using the class name as the reuse identifier.
    ///
    /// The reuse identifier is `String(describing: viewClass)`: the bare class name, such as `"SectionHeaderView"`,
    /// without the module or any enclosing types. The nib must contain exactly one top-level object, a view of that
    /// class. Registering replaces any class or nib registered earlier under the same identifier, and passing `nil` for
    /// `nib` removes the registration.
    ///
    /// It isn't available on visionOS, where nibs are deprecated.
    ///
    /// ```swift
    /// let nib = UINib(nibName: "SectionHeaderView", bundle: .main)
    /// tableView.register(nib: nib, withHeaderFooterViewClass: SectionHeaderView.self)
    /// tableView.dequeueReusableHeaderFooterView(withIdentifier: "SectionHeaderView")  // A SectionHeaderView.
    /// ```
    ///
    /// - Parameters:
    ///   - nib: The nib that contains the view, or `nil` to remove the registration.
    ///   - viewClass: The class of the view in the nib. Its name is the reuse identifier.
    func register(nib: UINib?, withHeaderFooterViewClass viewClass: (some UITableViewHeaderFooterView).Type) {
        register(nib, forHeaderFooterViewReuseIdentifier: String(describing: viewClass))
    }
}
#endif
