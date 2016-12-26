//
//  UICollectionViewExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 11/12/2016.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import UIKit


// MARK: - Properties
public extension UICollectionView {
	
	/// SwifterSwift: Index path of last item in collectionView.
	public var indexPathForLastItem: IndexPath? {
		guard numberOfSections > 0 else {
			return nil
		}
		return nil
	}
	
	/// SwifterSwift: Index of last section in collectionView.
	public var lastSection: Int {
		return numberOfSections > 0 ? numberOfSections - 1 : 0
	}
	
	/// SwifterSwift: Number of all items in all sections of collectionView.
	public var numberOfItems: Int {
		var section = 0
		var itemsCount = 0
		while section < self.numberOfSections {
			itemsCount += numberOfItems(inSection: section)
			section += 1
		}
		return itemsCount
	}
	
}


// MARK: - Methods
public extension UICollectionView {
	
	/// SwifterSwift: IndexPath for last item in section.
	///
	/// - Parameter section: section to get last item in.
	/// - Returns: optional last indexPath for last item in section (if applicable).
	public func indexPathForLastItem(in section: Int) -> IndexPath? {
		return IndexPath(item: numberOfItems(inSection: section) - 1, section: section)
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
}
