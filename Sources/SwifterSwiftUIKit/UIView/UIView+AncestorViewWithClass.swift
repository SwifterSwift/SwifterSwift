// UIView+AncestorViewWithClass.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

public extension UIView {
    /// SwifterSwift: Returns the closest ancestor of the view that is an instance of the given class.
    ///
    /// The search starts at the view's superview and walks up to the root, so the view itself is never returned.
    /// Instances of subclasses match too: looking for `UIScrollView` can return a `UITableView`.
    ///
    /// ```swift
    /// // A button inside a table view cell.
    /// button.ancestorView(withClass: UITableViewCell.self)  // the cell
    /// button.ancestorView(withClass: UIScrollView.self)  // the table view
    /// button.ancestorView(withClass: UIStackView.self)  // nil
    /// ```
    ///
    /// - Parameter type: The class of the ancestor to find.
    /// - Returns: The closest ancestor of type `T`, or `nil` if there's none.
    /// - Complexity: O(*n*), where *n* is the number of ancestors of the view.
    func ancestorView<T: UIView>(withClass type: T.Type) -> T? {
        var candidate = superview
        while let view = candidate {
            if let match = view as? T {
                return match
            }
            candidate = view.superview
        }
        return nil
    }
}
#endif
