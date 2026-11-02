// UITableView+LastSection.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

public extension UITableView {
    /// SwifterSwift: The index of the last section, or `nil` if the table view has no sections.
    ///
    /// The value comes from `numberOfSections`, so it reflects what the table view knows about its data source, and it
    /// counts empty sections too. Unlike `numberOfSections - 1`, it never returns `-1`.
    ///
    /// ```swift
    /// // A table view with 3 sections.
    /// tableView.lastSection  // 2
    ///
    /// // A table view with no sections.
    /// tableView.lastSection  // nil
    /// ```
    var lastSection: Int? {
        let count = numberOfSections
        return count > 0 ? count - 1 : nil
    }
}
#endif
