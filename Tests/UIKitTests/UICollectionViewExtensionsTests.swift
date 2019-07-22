//
//  UICollectionViewExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 2/24/17.
//  Copyright © 2017 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

final private class TestCell: UICollectionViewCell {}

final class UICollectionViewExtensionsTests: XCTestCase {

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    let emptyCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    let flowLayoutCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 10, height: 10)
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = .zero
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 10, height: 15), collectionViewLayout: layout)
        if #available(iOS 11, *) {
            collection.insetsLayoutMarginsFromSafeArea = false
        }
        collection.contentInset = .zero
        return collection
    }()

    override func setUp() {
        super.setUp()

        collectionView.dataSource = self
        collectionView.reloadData()

        emptyCollectionView.dataSource = self
        emptyCollectionView.reloadData()

        flowLayoutCollectionView.dataSource = self
        flowLayoutCollectionView.reloadData()

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

    #if os(iOS)
    func testRegisterCellWithClass() {
        let indexPath = IndexPath(row: 0, section: 0)
        collectionView.register(cellWithClass: TestCell.self)
        let cell = collectionView.dequeueReusableCell(withClass: TestCell.self, for: indexPath)
        XCTAssertNotNil(cell)
    }
    #endif

    #if os(iOS)
    func testRegisterCellWithNibUsingClass() {
        let indexPath = IndexPath(row: 0, section: 0)
        collectionView.register(nibWithCellClass: UICollectionViewCell.self, at: UICollectionViewExtensionsTests.self)
        let cell = collectionView.dequeueReusableCell(withClass: UICollectionViewCell.self, for: indexPath)
        XCTAssertNotNil(cell)
    }
    #endif

    func testSafeScrollToIndexPath() {
        let validIndexPathTop = IndexPath(row: 0, section: 0)

        flowLayoutCollectionView.contentOffset = CGPoint(x: 0, y: 30)
        XCTAssertNotEqual(flowLayoutCollectionView.contentOffset, .zero)

        flowLayoutCollectionView.safeScrollToItem(at: validIndexPathTop, at: .top, animated: false)
        XCTAssertEqual(flowLayoutCollectionView.contentOffset, .zero)

        let validIndexPathBottom = IndexPath(row: 4, section: 0)

        let bottomOffset = CGPoint(x: 0, y: flowLayoutCollectionView.collectionViewLayout.collectionViewContentSize.height - flowLayoutCollectionView.bounds.size.height)

        flowLayoutCollectionView.contentOffset = CGPoint(x: 0, y: 30)
        XCTAssertNotEqual(flowLayoutCollectionView.contentOffset, bottomOffset)

        flowLayoutCollectionView.safeScrollToItem(at: validIndexPathBottom, at: .bottom, animated: false)

        XCTAssertEqual(bottomOffset.y, flowLayoutCollectionView.contentOffset.y)

        let invalidIndexPath = IndexPath(row: 213, section: 21)
        flowLayoutCollectionView.contentOffset = .zero

        flowLayoutCollectionView.safeScrollToItem(at: invalidIndexPath, at: .bottom, animated: false)
        XCTAssertEqual(flowLayoutCollectionView.contentOffset, .zero)

        let negativeIndexPath = IndexPath(item: -1, section: 0)

        flowLayoutCollectionView.safeScrollToItem(at: negativeIndexPath, at: .bottom, animated: false)
        XCTAssertEqual(flowLayoutCollectionView.contentOffset, .zero)
    }

    func testIsValidIndexPath() {
        let zeroIndexPath = IndexPath(item: 0, section: 0)
        let invalidIndexPath = IndexPath(item: 0, section: 3)
        let validIndexPath = IndexPath(item: 4, section: 0)
        let negativeIndexPath = IndexPath(item: -1, section: 0)

        XCTAssertFalse(emptyCollectionView.isValidIndexPath(zeroIndexPath))

        XCTAssertFalse(collectionView.isValidIndexPath(negativeIndexPath))
        XCTAssertTrue(collectionView.isValidIndexPath(zeroIndexPath))
        XCTAssertTrue(collectionView.isValidIndexPath(validIndexPath))
        XCTAssertFalse(collectionView.isValidIndexPath(invalidIndexPath))
    }
}

extension UICollectionViewExtensionsTests: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (collectionView == self.collectionView || collectionView == self.flowLayoutCollectionView) ? 2 : 0
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (collectionView == self.collectionView || collectionView == self.flowLayoutCollectionView) ? (section == 0 ? 5 : 0) : 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }

}

#endif
