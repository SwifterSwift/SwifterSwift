// UICollectionView+SafeScrollToItemTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import Foundation
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UICollectionViewSafeScrollToItemTests {
    @Test
    func scrollsToValidItems() {
        withCollectionView(items: [5, 3]) { collectionView in
            // 8 items of 10 points in a 15-point-tall collection view.
            collectionView.safeScrollToItem(at: IndexPath(item: 2, section: 1), at: .bottom, animated: false)
            #expect(abs(collectionView.contentOffset.y - (8 * 10 - 15)) < 1)

            collectionView.safeScrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
            #expect(abs(collectionView.contentOffset.y) < 1)

            collectionView.safeScrollToItem(at: IndexPath(item: 3, section: 0), at: .top, animated: false)
            #expect(abs(collectionView.contentOffset.y - 30) < 1)
        }
    }

    @Test(arguments: [
        IndexPath(item: 3, section: 1),
        IndexPath(item: 0, section: 2),
        IndexPath(item: 213, section: 21),
        IndexPath(item: -1, section: 0),
        IndexPath(item: 0, section: -1),
        IndexPath(item: -1, section: -1),
        IndexPath(item: Int.min, section: Int.max),
        IndexPath(),
        IndexPath(index: 0),
        IndexPath(indexes: [0, 0, 0])
    ])
    func doesNothingForInvalidIndexPaths(_ indexPath: IndexPath) {
        withCollectionView(items: [5, 3]) { collectionView in
            collectionView.contentOffset = CGPoint(x: 0, y: 20)
            collectionView.safeScrollToItem(at: indexPath, at: .bottom, animated: false)
            #expect(collectionView.contentOffset == CGPoint(x: 0, y: 20))
        }
    }

    @Test
    func doesNothingForAnEmptySection() {
        withCollectionView(items: [5, 0]) { collectionView in
            collectionView.contentOffset = CGPoint(x: 0, y: 10)
            collectionView.safeScrollToItem(at: IndexPath(item: 0, section: 1), at: .top, animated: false)
            #expect(collectionView.contentOffset == CGPoint(x: 0, y: 10))
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
