// UICollectionView+IsValidIndexPathTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import Foundation
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UICollectionViewIsValidIndexPathTests {
    @Test(arguments: [IndexPath(item: 0, section: 0), IndexPath(item: 4, section: 0), IndexPath(item: 2, section: 1)])
    func returnsTrueForExistingItems(_ indexPath: IndexPath) {
        withCollectionView(items: [5, 3]) { collectionView in
            #expect(collectionView.isValidIndexPath(indexPath))
        }
    }

    @Test(arguments: [
        IndexPath(item: 5, section: 0),
        IndexPath(item: 3, section: 1),
        IndexPath(item: 0, section: 2),
        IndexPath(item: 0, section: 3),
        IndexPath(item: -1, section: 0),
        IndexPath(item: 0, section: -1),
        IndexPath(item: Int.max, section: 0),
        IndexPath(item: 0, section: Int.min)
    ])
    func returnsFalseForMissingItems(_ indexPath: IndexPath) {
        withCollectionView(items: [5, 3, 0]) { collectionView in
            #expect(!collectionView.isValidIndexPath(indexPath))
        }
    }

    @Test(arguments: [IndexPath(), IndexPath(index: 0), IndexPath(indexes: [0, 0, 0])])
    func returnsFalseForIndexPathsWithoutTwoIndices(_ indexPath: IndexPath) {
        withCollectionView(items: [5]) { collectionView in
            #expect(!collectionView.isValidIndexPath(indexPath))
        }
    }

    @Test
    func returnsFalseWithoutSections() {
        withCollectionView(items: []) { collectionView in
            #expect(!collectionView.isValidIndexPath(IndexPath(item: 0, section: 0)))
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
