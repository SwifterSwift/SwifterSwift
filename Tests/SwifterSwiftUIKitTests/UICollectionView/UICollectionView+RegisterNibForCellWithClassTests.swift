// UICollectionView+RegisterNibForCellWithClassTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS) && !os(visionOS)
import CoreGraphics
import Foundation
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UICollectionViewRegisterNibForCellWithClassTests {
    private let indexPath = IndexPath(item: 0, section: 0)

    @Test
    func registersTheNibUnderTheClassName() {
        final class PhotoCell: UICollectionViewCell {}
        let template = PhotoCell()
        template.tag = 42
        let nib = UINib(data: makeNibData(containing: template), bundle: nil)
        withCollectionView { collectionView in
            collectionView.register(nib: nib, forCellWithClass: PhotoCell.self)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath)
            #expect(cell is PhotoCell)
            #expect(cell.tag == 42)
        }
    }

    @Test
    func replacesAClassRegistration() {
        final class PhotoCell: UICollectionViewCell {}
        let template = PhotoCell()
        template.tag = 7
        let nib = UINib(data: makeNibData(containing: template), bundle: nil)
        withCollectionView { collectionView in
            collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "PhotoCell")
            collectionView.register(nib: nib, forCellWithClass: PhotoCell.self)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath)
            #expect(cell.tag == 7)
        }
    }

    @Test
    func usesTheDynamicTypeOfTheClassForTheIdentifier() {
        final class PhotoCell: UICollectionViewCell {}
        let template = PhotoCell()
        template.tag = 3
        let nib = UINib(data: makeNibData(containing: template), bundle: nil)
        withCollectionView { collectionView in
            let cellClass: UICollectionViewCell.Type = PhotoCell.self
            collectionView.register(nib: nib, forCellWithClass: cellClass)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath)
            #expect(cell.tag == 3)
        }
    }

    /// Returns the data of a nib whose only top-level object is `view`, built in memory so the tests need no resources.
    private func makeNibData(containing view: UIView) -> Data {
        let archiver = NSKeyedArchiver(requiringSecureCoding: false)
        archiver.encode([view], forKey: "UINibTopLevelObjectsKey")
        archiver.encode([view], forKey: "UINibObjectsKey")
        archiver.finishEncoding()
        return archiver.encodedData
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
