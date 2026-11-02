// UITableView+IsValidIndexPath.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import Foundation
import UIKit

public extension UITableView {
    /// SwifterSwift: Returns a Boolean value indicating whether an index path points to an existing row.
    ///
    /// The index path is valid when it has exactly two indices, its section is in `0..<numberOfSections`, and its row is
    /// in `0..<numberOfRows(inSection:)`. Index paths with any other number of indices return `false` instead of
    /// trapping like `IndexPath.row` does.
    ///
    /// ```swift
    /// // A table view with 5 rows in section 0.
    /// tableView.isValidIndexPath(IndexPath(row: 4, section: 0))  // true
    /// tableView.isValidIndexPath(IndexPath(row: 5, section: 0))  // false
    /// tableView.isValidIndexPath(IndexPath(row: -1, section: 0))  // false
    /// tableView.isValidIndexPath(IndexPath(index: 0))  // false
    /// ```
    ///
    /// - Parameter indexPath: The index path to check.
    /// - Returns: `true` if `indexPath` identifies a row in the table view; otherwise, `false`.
    func isValidIndexPath(_ indexPath: IndexPath) -> Bool {
        guard indexPath.count == 2 else { return false }
        return indexPath.section >= 0
            && indexPath.section < numberOfSections
            && indexPath.row >= 0
            && indexPath.row < numberOfRows(inSection: indexPath.section)
    }
}
#endif
