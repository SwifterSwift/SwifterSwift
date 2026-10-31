// UITableView+IndexPathForLastRowInSection.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import Foundation
import UIKit

public extension UITableView {
    /// SwifterSwift: Returns the index path of a section's last row, or `nil` if the section is empty or missing.
    ///
    /// The result is always a valid index path for the table view, so it's safe to pass to APIs such as
    /// `scrollToRow(at:at:animated:)`. Negative sections and sections past the end return `nil` instead of trapping.
    ///
    /// ```swift
    /// // A table view with 5 rows in section 0 and an empty section 1.
    /// tableView.indexPathForLastRow(inSection: 0)  // [0, 4]
    /// tableView.indexPathForLastRow(inSection: 1)  // nil
    /// tableView.indexPathForLastRow(inSection: 2)  // nil
    /// ```
    ///
    /// - Parameter section: The index of the section.
    /// - Returns: The index path of the last row in `section`, or `nil` if `section` is out of range or has no rows.
    func indexPathForLastRow(inSection section: Int) -> IndexPath? {
        guard section >= 0, section < numberOfSections else { return nil }
        let count = numberOfRows(inSection: section)
        return count > 0 ? IndexPath(row: count - 1, section: section) : nil
    }
}
#endif
