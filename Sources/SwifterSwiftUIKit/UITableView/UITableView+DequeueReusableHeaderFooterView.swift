// UITableView+DequeueReusableHeaderFooterView.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

public extension UITableView {
    /// SwifterSwift: Dequeues a header or footer view of a given class, using the class name as the reuse identifier.
    ///
    /// The reuse identifier is `String(describing: viewClass)`: the bare class name, such as `"SectionHeaderView"`,
    /// without the module or any enclosing types. Register the view under that identifier first, with
    /// `register(_:forHeaderFooterViewReuseIdentifier:)` for a class or a nib.
    ///
    /// Like `dequeueReusableHeaderFooterView(withIdentifier:)`, which this calls, it returns `nil` when nothing is
    /// registered for the identifier. It also returns `nil` when the dequeued view isn't a `View`.
    ///
    /// ```swift
    /// tableView.register(SectionHeaderView.self, forHeaderFooterViewReuseIdentifier: "SectionHeaderView")
    ///
    /// // In tableView(_:viewForHeaderInSection:):
    /// let header = tableView.dequeueReusableHeaderFooterView(withClass: SectionHeaderView.self)  // SectionHeaderView?
    /// ```
    ///
    /// - Parameter viewClass: The class of the view to dequeue. Its name is the reuse identifier.
    /// - Returns: A view of type `View`, or `nil` if no view is registered for the identifier or the registered view
    ///   isn't a `View`.
    func dequeueReusableHeaderFooterView<View: UITableViewHeaderFooterView>(withClass viewClass: View.Type) -> View? {
        dequeueReusableHeaderFooterView(withIdentifier: String(describing: viewClass)) as? View
    }
}
#endif
