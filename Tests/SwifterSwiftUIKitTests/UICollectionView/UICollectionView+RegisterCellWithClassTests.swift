// UICollectionView+RegisterCellWithClassTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import Foundation
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UICollectionViewRegisterCellWithClassTests {
    private let indexPath = IndexPath(item: 0, section: 0)

    @Test
    func registersTheClassUnderItsName() {
        final class PhotoCell: UICollectionViewCell {}
        withCollectionView { collectionView in
            collectionView.register(cellWithClass: PhotoCell.self)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath)
            #expect(type(of: cell) == PhotoCell.self)
        }
    }

    @Test
    func registersTheBaseCellClass() {
        withCollectionView { collectionView in
            collectionView.register(cellWithClass: UICollectionViewCell.self)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
            #expect(type(of: cell) == UICollectionViewCell.self)
        }
    }

    @Test
    func usesTheDynamicTypeOfTheClass() {
        final class PhotoCell: UICollectionViewCell {}
        withCollectionView { collectionView in
            let cellClass: UICollectionViewCell.Type = PhotoCell.self
            collectionView.register(cellWithClass: cellClass)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath)
            #expect(cell is PhotoCell)
        }
    }

    @Test
    func replacesAnEarlierRegistration() {
        final class PhotoCell: UICollectionViewCell {}
        withCollectionView { collectionView in
            collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCell")
            collectionView.register(cellWithClass: PhotoCell.self)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath)
            #expect(cell is PhotoCell)
        }
    }

    @Test
    func providesCellsToADataSource() {
        final class PhotoCell: UICollectionViewCell {}
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 10, height: 10)
        let collectionView = UICollectionView(
            frame: CGRect(x: 0, y: 0, width: 10, height: 10), collectionViewLayout: layout)
        collectionView.register(cellWithClass: PhotoCell.self)
        var cells: [UICollectionViewCell] = []
        let dataSource = UICollectionViewDiffableDataSource<Int, Int>(collectionView: collectionView) {
            collectionView, indexPath, _ in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath)
            cells.append(cell)
            return cell
        }
        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        snapshot.appendSections([0])
        snapshot.appendItems([1])
        dataSource.applySnapshotUsingReloadData(snapshot)
        collectionView.layoutIfNeeded()
        #expect(cells.count == 1)
        #expect(cells.allSatisfy { $0 is PhotoCell })
        #expect(collectionView.cellForItem(at: indexPath) is PhotoCell)
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
