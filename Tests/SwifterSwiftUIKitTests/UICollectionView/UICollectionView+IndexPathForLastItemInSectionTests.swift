// UICollectionView+IndexPathForLastItemInSectionTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import Foundation
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UICollectionViewIndexPathForLastItemInSectionTests {
    @Test
    func returnsTheLastItemOfEachSection() {
        withCollectionView(items: [5, 3, 1]) { collectionView in
            #expect(collectionView.indexPathForLastItem(inSection: 0) == IndexPath(item: 4, section: 0))
            #expect(collectionView.indexPathForLastItem(inSection: 1) == IndexPath(item: 2, section: 1))
            #expect(collectionView.indexPathForLastItem(inSection: 2) == IndexPath(item: 0, section: 2))
        }
    }

    @Test
    func returnsNilForAnEmptySection() {
        withCollectionView(items: [5, 0]) { collectionView in
            #expect(collectionView.indexPathForLastItem(inSection: 1) == nil)
        }
    }

    @Test(arguments: [-1, 2, 100, Int.min, Int.max])
    func returnsNilForSectionsOutOfRange(_ section: Int) {
        withCollectionView(items: [5, 3]) { collectionView in
            #expect(collectionView.indexPathForLastItem(inSection: section) == nil)
        }
    }

    @Test
    func returnsNilWithoutSections() {
        withCollectionView(items: []) { collectionView in
            #expect(collectionView.indexPathForLastItem(inSection: 0) == nil)
        }
    }

    /// Calls `body` with a 10 × 15 point collection view whose sections have the given numbers of items, each 10 × 10
    /// points and stacked vertically.
    private func withCollectionView(items: [Int], _ body: (UICollectionView) throws -> Void) rethrows {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 10, height: 10)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = .zero
        let collectionView = UICollectionView(
            frame: CGRect(x: 0, y: 0, width: 10, height: 15), collectionViewLayout: layout)
        collectionView.contentInsetAdjustmentBehavior = .never
        let registration = UICollectionView.CellRegistration<UICollectionViewCell, Int> { _, _, _ in }
        let dataSource = UICollectionViewDiffableDataSource<Int, Int>(collectionView: collectionView) {
            collectionView, indexPath, item in
            collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: item)
        }
        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        for (section, count) in items.enumerated() {
            snapshot.appendSections([section])
            snapshot.appendItems((0..<count).map { section * 1_000 + $0 }, toSection: section)
        }
        dataSource.applySnapshotUsingReloadData(snapshot)
        try withExtendedLifetime(dataSource) { try body(collectionView) }
    }
}
#endif
