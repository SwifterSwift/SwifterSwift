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
	
	/// SwifterSwift: Index path of last row in table.
	public var indexPathForLastRow: IndexPath? {
		guard numberOfRows > 0 else {
			return nil
		}
		return IndexPath(row: numberOfRows - 1, section: lastSection)
	}
	
	/// SwifterSwift: Index of last section in table.
	public var lastSection: Int {
		guard numberOfSections > 1 else {
			return 0
		}
		return numberOfSections - 1
	}
	
	/// SwifterSwift: Number of all rows in all sections of table.
	public var numberOfRows: Int {
		var section = 0
		var rowCount = 0
		while section < self.numberOfSections {
			rowCount += self.numberOfRows(inSection: section)
			section += 1
		}
		return rowCount
	}

}


// MARK: - Methods
public extension UITableView {
	
	/// SwifterSwift: IndexPath for last row in section.
	///
	/// - Parameter section: section to check
	/// - Returns: optional last indexPath for last row in section (if applicable).
	public func indexPathForLastRow(in section: Int) -> IndexPath? {
		return IndexPath(row: numberOfRows(inSection: section) - 1, section: section)
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
