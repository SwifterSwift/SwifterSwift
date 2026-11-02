// UITableView+SafeScrollToRow.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import Foundation
import UIKit

public extension UITableView {
    /// SwifterSwift: Scrolls to a row if the index path is valid, and does nothing otherwise.
    ///
    /// `scrollToRow(at:at:animated:)` raises an exception for an index path that doesn't exist, including one with a
    /// negative row or section. This method checks the index path first: it must have exactly two indices, a section in
    /// `0..<numberOfSections` and a row in `0..<numberOfRows(inSection:)`. That makes it safe to call with an index path
    /// that may be stale, for example after the data changed.
    ///
    /// ```swift
    /// // A table view with 5 rows in section 0.
    /// tableView.safeScrollToRow(at: IndexPath(row: 4, section: 0), at: .bottom, animated: true)  // Scrolls.
    /// tableView.safeScrollToRow(at: IndexPath(row: -1, section: 0), at: .bottom, animated: true)  // Does nothing.
    /// ```
    ///
    /// - Parameters:
    ///   - indexPath: The index path of the row to scroll into view.
    ///   - scrollPosition: Where the row should be positioned when scrolling finishes.
    ///   - animated: `true` to animate the scrolling; `false` to scroll immediately.
    func safeScrollToRow(at indexPath: IndexPath, at scrollPosition: UITableView.ScrollPosition, animated: Bool) {
        guard indexPath.count == 2,
            indexPath.section >= 0,
            indexPath.section < numberOfSections,
            indexPath.row >= 0,
            indexPath.row < numberOfRows(inSection: indexPath.section)
        else { return }
        scrollToRow(at: indexPath, at: scrollPosition, animated: animated)
    }
}
#endif
