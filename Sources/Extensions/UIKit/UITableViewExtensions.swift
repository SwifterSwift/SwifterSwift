//
//  UITableViewExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/22/16.
//  Copyright © 2016 SwifterSwift
//

#if canImport(UIKit) && !os(watchOS)
import UIKit

// MARK: - Properties
public extension UITableView {

    /// SwifterSwift: Index path of last row in tableView.
    public var indexPathForLastRow: IndexPath? {
        return indexPathForLastRow(inSection: lastSection)
    }

    /// SwifterSwift: Index of last section in tableView.
    public var lastSection: Int {
        return numberOfSections > 0 ? numberOfSections - 1 : 0
    }

}

// MARK: - Methods
public extension UITableView {

    /// SwifterSwift: Number of all rows in all sections of tableView.
    ///
    /// - Returns: The count of all rows in the tableView.
    public func numberOfRows() -> Int {
        var section = 0
        var rowCount = 0
        while section < numberOfSections {
            rowCount += numberOfRows(inSection: section)
            section += 1
        }
        return rowCount
    }

    /// SwifterSwift: IndexPath for last row in section.
    ///
    /// - Parameter section: section to get last row in.
    /// - Returns: optional last indexPath for last row in section (if applicable).
    public func indexPathForLastRow(inSection section: Int) -> IndexPath? {
        guard section >= 0 else { return nil }
        guard numberOfRows(inSection: section) > 0  else {
            return IndexPath(row: 0, section: section)
        }
        return IndexPath(row: numberOfRows(inSection: section) - 1, section: section)
    }

    /// Reload data with a completion handler.
    ///
    /// - Parameter completion: completion handler to run after reloadData finishes.
    public func reloadData(_ completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion: { _ in
            completion()
        })
    }

    /// SwifterSwift: Remove TableFooterView.
    public func removeTableFooterView() {
        tableFooterView = nil
    }

    /// SwifterSwift: Remove TableHeaderView.
    public func removeTableHeaderView() {
        tableHeaderView = nil
    }

    /// SwifterSwift: Scroll to bottom of TableView.
    ///
    /// - Parameter animated: set true to animate scroll (default is true).
    public func scrollToBottom(animated: Bool = true) {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height)
        setContentOffset(bottomOffset, animated: animated)
    }

    /// SwifterSwift: Scroll to top of TableView.
    ///
    /// - Parameter animated: set true to animate scroll (default is true).
    public func scrollToTop(animated: Bool = true) {
        setContentOffset(CGPoint.zero, animated: animated)
    }

    /// SwifterSwift: Dequeue reusable UITableViewCell using class name
    ///
    /// - Parameter name: UITableViewCell type
    /// - Returns: UITableViewCell object with associated class name.
    public func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: name)) as? T else {
            fatalError("Couldn't find UITableViewCell for \(String(describing: name))")
        }
        return cell
    }

    /// SwiferSwift: Dequeue reusable UITableViewCell using class name for indexPath
    ///
    /// - Parameters:
    ///   - name: UITableViewCell type.
    ///   - indexPath: location of cell in tableView.
    /// - Returns: UITableViewCell object with associated class name.
    public func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: name), for: indexPath) as? T else {
            fatalError("Couldn't find UITableViewCell for \(String(describing: name))")
        }
        return cell
    }

    /// SwiferSwift: Dequeue reusable UITableViewHeaderFooterView using class name
    ///
    /// - Parameter name: UITableViewHeaderFooterView type
    /// - Returns: UITableViewHeaderFooterView object with associated class name.
    public func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(withClass name: T.Type) -> T {
        guard let headerFooterView = dequeueReusableHeaderFooterView(withIdentifier: String(describing: name)) as? T else {
            fatalError("Couldn't find UITableViewHeaderFooterView for \(String(describing: name))")
        }
        return headerFooterView
    }

    /// SwifterSwift: Register UITableViewHeaderFooterView using class name
    ///
    /// - Parameters:
    ///   - nib: Nib file used to create the header or footer view.
    ///   - name: UITableViewHeaderFooterView type.
    public func register<T: UITableViewHeaderFooterView>(nib: UINib?, withHeaderFooterViewClass name: T.Type) {
        register(nib, forHeaderFooterViewReuseIdentifier: String(describing: name))
    }

    /// SwifterSwift: Register UITableViewHeaderFooterView using class name
    ///
    /// - Parameter name: UITableViewHeaderFooterView type
    public func register<T: UITableViewHeaderFooterView>(headerFooterViewClassWith name: T.Type) {
        register(T.self, forHeaderFooterViewReuseIdentifier: String(describing: name))
    }

    /// SwifterSwift: Register UITableViewCell using class name
    ///
    /// - Parameter name: UITableViewCell type
    public func register<T: UITableViewCell>(cellWithClass name: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: name))
    }

    /// SwifterSwift: Register UITableViewCell using class name
    ///
    /// - Parameters:
    ///   - nib: Nib file used to create the tableView cell.
    ///   - name: UITableViewCell type.
    public func register<T: UITableViewCell>(nib: UINib?, withCellClass name: T.Type) {
        register(nib, forCellReuseIdentifier: String(describing: name))
    }

    /// SwifterSwift: Register UITableViewCell with .xib file using only its corresponding class.
    ///               Assumes that the .xib filename and cell class has the same name.
    ///
    /// - Parameters:
    ///   - name: UITableViewCell type.
    ///   - bundleClass: Class in which the Bundle instance will be based on.
    public func register<T: UITableViewCell>(nibWithCellClass name: T.Type, at bundleClass: AnyClass? = nil) {
        let identifier = String(describing: name)
        var bundle: Bundle?

        if let bundleName = bundleClass {
            bundle = Bundle(for: bundleName)
        }

        register(UINib(nibName: identifier, bundle: bundle), forCellReuseIdentifier: identifier)
    }

    /// SwifterSwift: Check whether IndexPath is valid within the tableView
    ///
    /// - Parameter indexPath: An IndexPath to check
    /// - Returns: Boolean value for valid or invalid IndexPath
    public func isValidIndexPath(_ indexPath: IndexPath) -> Bool {
        return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section)
    }

    /// SwifterSwift: Safely scroll to possibly invalid IndexPath
    ///
    /// - Parameters:
    ///   - indexPath: Target IndexPath to scroll to
    ///   - scrollPosition: Scroll position
    ///   - animated: Whether to animate or not
    public func safeScrollToRow(at indexPath: IndexPath, at scrollPosition: UITableView.ScrollPosition, animated: Bool) {
        guard indexPath.section < numberOfSections else { return }
        guard indexPath.row < numberOfRows(inSection: indexPath.section) else { return }
        scrollToRow(at: indexPath, at: scrollPosition, animated: animated)
    }

}
#endif
