// UITableView+RegisterCellWithClass.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

public extension UITableView {
    /// SwifterSwift: Registers a cell class, using the class name as the reuse identifier.
    ///
    /// The reuse identifier is `String(describing: cellClass)`: the bare class name, such as `"ProfileCell"`, without
    /// the module or any enclosing types. Dequeue the cell with that identifier, for example
    /// `dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath)`. Registering replaces any class or nib
    /// registered earlier under the same identifier, so two cell classes with the same name, nested in different types,
    /// can't both be registered on one table view.
    ///
    /// ```swift
    /// tableView.register(cellWithClass: ProfileCell.self)
    /// tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath)  // A ProfileCell.
    /// ```
    ///
    /// - Parameter cellClass: The class of the cell to register. Its name is the reuse identifier.
    func register(cellWithClass cellClass: (some UITableViewCell).Type) {
        register(cellClass, forCellReuseIdentifier: String(describing: cellClass))
    }
}
#endif
