//
//  UICollectionViewExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 2/24/17.
//  Copyright © 2017 omaralbeik. All rights reserved.
//

#if os(iOS) || os(tvOS)
	
import XCTest
@testable import SwifterSwift

final class UICollectionViewExtensionsTests: XCTestCase {
	
	let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
	let emptyCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
	
	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
		collectionView.dataSource = self
		collectionView.reloadData()
		
		emptyCollectionView.dataSource = self
		emptyCollectionView.reloadData()
	}
	
	func testIndexPathForLastRow() {
		XCTAssertEqual(collectionView.indexPathForLastItem, IndexPath(item: 0, section: 1))
	}
	
	func testLastSection() {
		XCTAssertEqual(collectionView.lastSection, 1)
		XCTAssertEqual(emptyCollectionView.lastSection, 0)
	}
	
	func testNumberOfRows() {
		XCTAssertEqual(collectionView.numberOfItems(), 5)
		XCTAssertEqual(emptyCollectionView.numberOfItems(), 0)
	}
	
	func testIndexPathForLastRowInSection() {
		XCTAssertNil(collectionView.indexPathForLastItem(inSection: -1))
		XCTAssertNil(collectionView.indexPathForLastItem(inSection: 2))
		XCTAssertEqual(collectionView.indexPathForLastItem(inSection: 0), IndexPath(item: 4, section: 0))
	}
	
	func testReloadData() {
		var completionCalled = false
		collectionView.reloadData {
			completionCalled = true
			XCTAssert(completionCalled)
		}
	}
}

extension UICollectionViewExtensionsTests: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return (collectionView == self.collectionView) ? 2 : 0
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return (collectionView == self.collectionView) ? (section == 0 ? 5 : 0) : 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		return UICollectionViewCell()
	}
	
}
	
#endif
