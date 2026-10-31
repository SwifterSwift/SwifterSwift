// UITableView+DequeueReusableCell.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import Foundation
import UIKit

public extension UITableView {
    /// SwifterSwift: Dequeues a reusable cell of the given class, using the class name as the reuse identifier.
    ///
    /// The reuse identifier is `String(describing: cellClass)`: the bare class name, such as `"ProfileCell"`, without
    /// the module or any enclosing types. Register the cell under that identifier first, with
    /// `register(_:forCellReuseIdentifier:)` for a class or a nib, or with a storyboard prototype cell whose identifier is
    /// the class name.
    ///
    /// This calls `dequeueReusableCell(withIdentifier:for:)`, so, as with that method, UIKit raises an exception if
    /// nothing is registered for the identifier. The method returns `nil` when the dequeued cell isn't a `Cell`, for
    /// example because another class was registered under the same name.
    ///
    /// ```swift
    /// tableView.register(ProfileCell.self, forCellReuseIdentifier: "ProfileCell")
    ///
    /// // In tableView(_:cellForRowAt:):
    /// guard let cell = tableView.dequeueReusableCell(withClass: ProfileCell.self, for: indexPath) else {
    ///     return UITableViewCell()
    /// }
    /// cell.nameLabel.text = user.name
    /// return cell
    /// ```
    ///
    /// - Parameters:
    ///   - cellClass: The class of the cell to dequeue. Its name is the reuse identifier.
    ///   - indexPath: The index path of the cell, which the table view uses to size it.
    /// - Returns: A cell of type `Cell`, or `nil` if the cell registered for the identifier isn't a `Cell`.
    func dequeueReusableCell<Cell: UITableViewCell>(withClass cellClass: Cell.Type, for indexPath: IndexPath) -> Cell? {
        dequeueReusableCell(withIdentifier: String(describing: cellClass), for: indexPath) as? Cell
    }
}
#endif
