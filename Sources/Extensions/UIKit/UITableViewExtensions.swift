//
//  UITableViewExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/22/16.
//  Copyright © 2016 SwifterSwift
//

#if os(iOS) || os(tvOS)
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
		guard section >= 0 else {
			return nil
		}
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
    /// - Returns: UITableViewCell object with associated class name (optional value)
    public func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: String(describing: name)) as? T
    }

	/// SwiferSwift: Dequeue reusable UITableViewCell using class name for indexPath
	///
	/// - Parameters:
	///   - name: UITableViewCell type.
	///   - indexPath: location of cell in tableView.
	/// - Returns: UITableViewCell object with associated class name.
	public func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type, for indexPath: IndexPath) -> T? {
		return dequeueReusableCell(withIdentifier: String(describing: name), for: indexPath) as? T
    }
    
    /// SwiferSwift: Dequeue reusable UITableViewHeaderFooterView using class name
    ///
    /// - Parameter name: UITableViewHeaderFooterView type
    /// - Returns: UITableViewHeaderFooterView object with associated class name (optional value)
    public func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(withClass name: T.Type) -> T? {
        return dequeueReusableHeaderFooterView(withIdentifier: String(describing: name)) as? T
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
	
}
#endif
