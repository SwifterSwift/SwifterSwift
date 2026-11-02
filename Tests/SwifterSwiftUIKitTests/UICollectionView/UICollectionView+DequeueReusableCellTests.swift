// UICollectionView+DequeueReusableCellTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import Foundation
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UICollectionViewDequeueReusableCellTests {
    private let indexPath = IndexPath(item: 0, section: 0)

    @Test
    func dequeuesACellRegisteredUnderTheClassName() throws {
        final class PhotoCell: UICollectionViewCell {}
        try withCollectionView { collectionView in
            collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "PhotoCell")
            let cell = try #require(collectionView.dequeueReusableCell(withClass: PhotoCell.self, for: indexPath))
            #expect(type(of: cell) == PhotoCell.self)
        }
    }

    @Test
    func dequeuesTheBaseCellClass() {
        withCollectionView { collectionView in
            collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
            #expect(collectionView.dequeueReusableCell(withClass: UICollectionViewCell.self, for: indexPath) != nil)
        }
    }

    @Test
    func dequeuesASubclassRegisteredUnderTheName() throws {
        final class FancyCell: UICollectionViewCell {}
        try withCollectionView { collectionView in
            collectionView.register(FancyCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
            let cell = try #require(
                collectionView.dequeueReusableCell(withClass: UICollectionViewCell.self, for: indexPath))
            #expect(cell is FancyCell)
        }
    }

    @Test
    func returnsNilWhenAnotherClassIsRegisteredUnderTheName() {
        final class PhotoCell: UICollectionViewCell {}
        withCollectionView { collectionView in
            collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCell")
            #expect(collectionView.dequeueReusableCell(withClass: PhotoCell.self, for: indexPath) == nil)
        }
    }

    @Test
    func dequeuesCellsForADataSource() {
        final class PhotoCell: UICollectionViewCell {}
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 10, height: 10)
        layout.minimumLineSpacing = 0
        layout.sectionInset = .zero
        let collectionView = UICollectionView(
            frame: CGRect(x: 0, y: 0, width: 10, height: 20), collectionViewLayout: layout)
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "PhotoCell")
        var indexPaths: [IndexPath] = []
        let dataSource = UICollectionViewDiffableDataSource<Int, Int>(collectionView: collectionView) {
            collectionView, indexPath, _ in
            let cell = collectionView.dequeueReusableCell(withClass: PhotoCell.self, for: indexPath)
            if cell != nil {
                indexPaths.append(indexPath)
            }
            return cell
        }
        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        snapshot.appendSections([0, 1])
        snapshot.appendItems([1], toSection: 0)
        snapshot.appendItems([2], toSection: 1)
        dataSource.applySnapshotUsingReloadData(snapshot)
        collectionView.layoutIfNeeded()
        #expect(indexPaths.sorted() == [IndexPath(item: 0, section: 0), IndexPath(item: 0, section: 1)])
        #expect(collectionView.cellForItem(at: IndexPath(item: 0, section: 1)) is PhotoCell)
    }

    /// Calls `body` with a 10 × 20 point collection view that has laid out one 10 × 10 point item between a 10 × 5 point
    /// header and footer, using registrations of its own. `body` can then dequeue views for item 0 of section 0 itself,
    /// as long as it doesn't lay out the collection view again: UIKit raises an exception for a view dequeued without
    /// its request once it lays out.
    private func withCollectionView(_ body: (UICollectionView) throws -> Void) rethrows {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 10, height: 10)
        layout.headerReferenceSize = CGSize(width: 10, height: 5)
        layout.footerReferenceSize = CGSize(width: 10, height: 5)
        layout.minimumLineSpacing = 0
        layout.sectionInset = .zero
        let collectionView = UICollectionView(
            frame: CGRect(x: 0, y: 0, width: 10, height: 20), collectionViewLayout: layout)
        collectionView.contentInsetAdjustmentBehavior = .never
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewCell, Int> { _, _, _ in }
        let headerRegistration = UICollectionView.SupplementaryRegistration<UICollectionReusableView>(
            elementKind: UICollectionView.elementKindSectionHeader
        ) { _, _, _ in }
        let footerRegistration = UICollectionView.SupplementaryRegistration<UICollectionReusableView>(
            elementKind: UICollectionView.elementKindSectionFooter
        ) { _, _, _ in }
        let dataSource = UICollectionViewDiffableDataSource<Int, Int>(collectionView: collectionView) {
            collectionView, indexPath, item in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            collectionView.dequeueConfiguredReusableSupplementary(
                using: kind == UICollectionView.elementKindSectionHeader ? headerRegistration : footerRegistration,
                for: indexPath)
        }
        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        snapshot.appendSections([0])
        snapshot.appendItems([1])
        dataSource.applySnapshotUsingReloadData(snapshot)
        collectionView.layoutIfNeeded()
        try withExtendedLifetime(dataSource) { try body(collectionView) }
    }
}
#endif
