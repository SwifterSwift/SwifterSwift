// UICollectionView+LastSectionTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UICollectionViewLastSectionTests {
    @Test(arguments: [([1], 0), ([5, 3], 1), ([5, 0, 0], 2), ([0], 0)])
    func returnsTheIndexOfTheLastSection(items: [Int], expected: Int) {
        withCollectionView(items: items) { collectionView in
            #expect(collectionView.lastSection == expected)
        }
    }

    @Test
    func returnsNilWithoutSections() {
        withCollectionView(items: []) { collectionView in
            #expect(collectionView.numberOfSections == 0)
            #expect(collectionView.lastSection == nil)
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
