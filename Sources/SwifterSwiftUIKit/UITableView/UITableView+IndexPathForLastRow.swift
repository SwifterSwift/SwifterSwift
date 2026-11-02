// UITableView+IndexPathForLastRow.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import Foundation
import UIKit

public extension UITableView {
    /// SwifterSwift: The index path of the last row in the table view, or `nil` if it has no rows.
    ///
    /// Empty sections at the end are skipped, so this is the last row of the last section that has any rows. The result
    /// is always a valid index path, which makes it safe to pass to APIs such as `scrollToRow(at:at:animated:)`, for
    /// example to scroll to the bottom of a chat.
    ///
    /// ```swift
    /// // A table view with 5 rows in section 0 and an empty section 1.
    /// tableView.indexPathForLastRow  // [0, 4]
    ///
    /// // A table view whose sections are all empty.
    /// tableView.indexPathForLastRow  // nil
    /// ```
    ///
    /// - Complexity: O(*n*), where *n* is the number of sections.
    var indexPathForLastRow: IndexPath? {
        for section in (0..<numberOfSections).reversed() {
            let count = numberOfRows(inSection: section)
            if count > 0 {
                return IndexPath(row: count - 1, section: section)
            }
        }
        return nil
    }
}
#endif
