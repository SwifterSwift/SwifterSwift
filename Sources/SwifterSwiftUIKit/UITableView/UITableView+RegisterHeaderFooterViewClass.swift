// UITableView+RegisterHeaderFooterViewClass.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

public extension UITableView {
    /// SwifterSwift: Registers a header or footer view class, using the class name as the reuse identifier.
    ///
    /// The reuse identifier is `String(describing: viewClass)`: the bare class name, such as `"SectionHeaderView"`,
    /// without the module or any enclosing types. Dequeue the view with that identifier, for example
    /// `dequeueReusableHeaderFooterView(withIdentifier: "SectionHeaderView")`. Registering replaces any class or nib
    /// registered earlier under the same identifier.
    ///
    /// ```swift
    /// tableView.register(headerFooterViewClass: SectionHeaderView.self)
    /// tableView.dequeueReusableHeaderFooterView(withIdentifier: "SectionHeaderView")  // A SectionHeaderView.
    /// ```
    ///
    /// - Parameter viewClass: The class of the view to register. Its name is the reuse identifier.
    func register(headerFooterViewClass viewClass: (some UITableViewHeaderFooterView).Type) {
        register(viewClass, forHeaderFooterViewReuseIdentifier: String(describing: viewClass))
    }
}
#endif
