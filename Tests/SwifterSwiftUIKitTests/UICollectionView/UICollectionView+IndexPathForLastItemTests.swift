// UICollectionView+IndexPathForLastItemTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import Foundation
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UICollectionViewIndexPathForLastItemTests {
    @Test(arguments: [
        ([5, 3], IndexPath(item: 2, section: 1)),
        ([1], IndexPath(item: 0, section: 0)),
        ([5, 0], IndexPath(item: 4, section: 0)),
        ([0, 3, 0, 0], IndexPath(item: 2, section: 1))
    ])
    func returnsTheLastItemOfTheLastNonEmptySection(items: [Int], expected: IndexPath) {
        withCollectionView(items: items) { collectionView in
            #expect(collectionView.indexPathForLastItem == expected)
        }
    }

    @Test(arguments: [[Int](), [0], [0, 0, 0]])
    func returnsNilWithoutItems(_ items: [Int]) {
        withCollectionView(items: items) { collectionView in
            #expect(collectionView.indexPathForLastItem == nil)
        }
    }

    @Test
    func alwaysReturnsAValidIndexPath() throws {
        try withCollectionView(items: [2, 0]) { collectionView in
            let indexPath = try #require(collectionView.indexPathForLastItem)
            #expect(indexPath.item < collectionView.numberOfItems(inSection: indexPath.section))
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
