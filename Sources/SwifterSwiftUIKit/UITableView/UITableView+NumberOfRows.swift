// UITableView+NumberOfRows.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

public extension UITableView {
    /// SwifterSwift: Returns the total number of rows in all sections.
    ///
    /// This adds up `numberOfRows(inSection:)` for every section, so it reflects what the table view knows about its data
    /// source. It returns `0` when there are no sections.
    ///
    /// ```swift
    /// // A table view with 5 rows in section 0 and 8 in section 1.
    /// tableView.numberOfRows()  // 13
    /// ```
    ///
    /// - Returns: The number of rows in the table view.
    /// - Complexity: O(*n*), where *n* is the number of sections.
    func numberOfRows() -> Int {
        var count = 0
        for section in 0..<numberOfSections {
            count += numberOfRows(inSection: section)
        }
        return count
    }
}
#endif
