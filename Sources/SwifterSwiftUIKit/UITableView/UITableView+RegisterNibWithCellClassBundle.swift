// UITableView+RegisterNibWithCellClassBundle.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS) && !os(visionOS)
import Foundation
import UIKit

public extension UITableView {
    /// SwifterSwift: Registers the nib named after a cell class, using the class name as the reuse identifier too.
    ///
    /// The name is `String(describing: cellClass)`: the bare class name, such as `"ProfileCell"`, without the module or
    /// any enclosing types. So `ProfileCell` is loaded from `ProfileCell.nib` (compiled from `ProfileCell.xib`) and
    /// registered under the identifier `"ProfileCell"`. The nib must contain exactly one top-level object, a cell of that
    /// class.
    ///
    /// The nib is loaded lazily, so a missing nib isn't reported here: UIKit raises an exception when it first dequeues
    /// the cell. Pass the bundle that contains the nib, for example `Bundle.module` in a Swift package or
    /// `Bundle(for: ProfileCell.self)` in a framework; `nil` means the main bundle.
    ///
    /// It isn't available on visionOS, where nibs are deprecated.
    ///
    /// ```swift
    /// tableView.register(nibWithCellClass: ProfileCell.self, bundle: .module)
    /// tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath)  // A ProfileCell from the nib.
    /// ```
    ///
    /// - Parameters:
    ///   - cellClass: The class of the cell in the nib. Its name is the nib name and the reuse identifier.
    ///   - bundle: The bundle that contains the nib, or `nil` for the main bundle.
    func register(nibWithCellClass cellClass: (some UITableViewCell).Type, bundle: Bundle?) {
        let name = String(describing: cellClass)
        register(UINib(nibName: name, bundle: bundle), forCellReuseIdentifier: name)
    }
}
#endif
