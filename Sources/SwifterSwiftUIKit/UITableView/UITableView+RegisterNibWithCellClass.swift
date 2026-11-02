// UITableView+RegisterNibWithCellClass.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS) && !os(visionOS)
import UIKit

public extension UITableView {
    /// SwifterSwift: Registers a nib for a cell class, using the class name as the reuse identifier.
    ///
    /// The reuse identifier is `String(describing: cellClass)`: the bare class name, such as `"ProfileCell"`, without
    /// the module or any enclosing types. The nib must contain exactly one top-level object, a cell of that class.
    /// Registering replaces any class or nib registered earlier under the same identifier, and passing `nil` for `nib`
    /// removes the registration.
    ///
    /// It isn't available on visionOS, where nibs are deprecated.
    ///
    /// ```swift
    /// tableView.register(nib: UINib(nibName: "ProfileCell", bundle: .main), withCellClass: ProfileCell.self)
    /// tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath)  // A ProfileCell from the nib.
    /// ```
    ///
    /// - Parameters:
    ///   - nib: The nib that contains the cell, or `nil` to remove the registration.
    ///   - cellClass: The class of the cell in the nib. Its name is the reuse identifier.
    func register(nib: UINib?, withCellClass cellClass: (some UITableViewCell).Type) {
        register(nib, forCellReuseIdentifier: String(describing: cellClass))
    }
}
#endif
