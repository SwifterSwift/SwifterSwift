//
//  UITableViewExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/22/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import UIKit


// MARK: - Properties
public extension UITableView {
	
	/// SwifterSwift: Index path of last row in tableView.
	public var indexPathForLastRow: IndexPath? {
		guard numberOfRows > 0 else {
			return nil
		}
		return IndexPath(row: numberOfRows - 1, section: lastSection)
	}
	
	/// SwifterSwift: Index of last section in tableView.
	public var lastSection: Int {
		return numberOfSections > 0 ? numberOfSections - 1 : 0
	}
	
	/// SwifterSwift: Number of all rows in all sections of tableView.
	public var numberOfRows: Int {
		var section = 0
		var rowCount = 0
		while section < numberOfSections {
			rowCount += numberOfRows(inSection: section)
			section += 1
		}
		return rowCount
	}

}


// MARK: - Methods
public extension UITableView {
	
	/// SwifterSwift: IndexPath for last row in section.
	///
	/// - Parameter section: section to get last row in.
	/// - Returns: optional last indexPath for last row in section (if applicable).
	public func indexPathForLastRow(in section: Int) -> IndexPath? {
		return IndexPath(row: numberOfRows(inSection: section) - 1, section: section)
	}
	
	/// Reload data with a completion handler.
	///
	/// - Parameter completion: completion handler to run after reloadData finishes.
	func reloadData(_ completion: @escaping () -> Void) {
		UIView.animate(withDuration: 0, animations: {
			self.reloadData()
		}, completion: { _ in
			completion()
		})
	}
	
	/// SwifterSwift: Remove TableFooterView.
	public func removeTableFooterView() {
		tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
	}
	
	/// SwifterSwift: Remove TableHeaderView.
	public func removeTableHeaderView() {
		tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
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
	
}
