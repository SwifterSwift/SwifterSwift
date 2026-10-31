// UICollectionView+DequeueReusableSupplementaryViewTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import Foundation
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UICollectionViewDequeueReusableSupplementaryViewTests {
    private let header = UICollectionView.elementKindSectionHeader
    private let footer = UICollectionView.elementKindSectionFooter
    private let indexPath = IndexPath(item: 0, section: 0)

    @Test
    func dequeuesAViewRegisteredUnderTheClassName() throws {
        final class SectionHeaderView: UICollectionReusableView {}
        try withCollectionView { collectionView in
            collectionView.register(
                SectionHeaderView.self, forSupplementaryViewOfKind: header, withReuseIdentifier: "SectionHeaderView")
            let view = try #require(
                collectionView.dequeueReusableSupplementaryView(
                    ofKind: header, withClass: SectionHeaderView.self, for: indexPath))
            #expect(type(of: view) == SectionHeaderView.self)
        }
    }

    @Test
    func dequeuesTheBaseViewClass() {
        withCollectionView { collectionView in
            collectionView.register(
                UICollectionReusableView.self, forSupplementaryViewOfKind: footer,
                withReuseIdentifier: "UICollectionReusableView")
            let view = collectionView.dequeueReusableSupplementaryView(
                ofKind: footer, withClass: UICollectionReusableView.self, for: indexPath)
            #expect(view != nil)
        }
    }

    @Test
    func dequeuesASubclassRegisteredUnderTheName() throws {
        final class FancyView: UICollectionReusableView {}
        try withCollectionView { collectionView in
            collectionView.register(
                FancyView.self, forSupplementaryViewOfKind: header, withReuseIdentifier: "UICollectionReusableView")
            let view = try #require(
                collectionView.dequeueReusableSupplementaryView(
                    ofKind: header, withClass: UICollectionReusableView.self, for: indexPath))
            #expect(view is FancyView)
        }
    }

    @Test
    func dequeuesTheViewRegisteredForTheKind() throws {
        class SectionView: UICollectionReusableView {}
        final class FancySectionView: SectionView {}
        try withCollectionView { collectionView in
            collectionView.register(
                SectionView.self, forSupplementaryViewOfKind: header, withReuseIdentifier: "SectionView")
            collectionView.register(
                FancySectionView.self, forSupplementaryViewOfKind: footer, withReuseIdentifier: "SectionView")
            let headerView = try #require(
                collectionView.dequeueReusableSupplementaryView(
                    ofKind: header, withClass: SectionView.self, for: indexPath))
            let footerView = try #require(
                collectionView.dequeueReusableSupplementaryView(
                    ofKind: footer, withClass: SectionView.self, for: indexPath))
            #expect(type(of: headerView) == SectionView.self)
            #expect(type(of: footerView) == FancySectionView.self)
        }
    }

    @Test
    func returnsNilWhenAnotherClassIsRegisteredUnderTheName() {
        final class SectionHeaderView: UICollectionReusableView {}
        withCollectionView { collectionView in
            collectionView.register(
                UICollectionReusableView.self, forSupplementaryViewOfKind: header,
                withReuseIdentifier: "SectionHeaderView")
            let view = collectionView.dequeueReusableSupplementaryView(
                ofKind: header, withClass: SectionHeaderView.self, for: indexPath)
            #expect(view == nil)
        }
    }

    @Test
    func dequeuesViewsForADataSource() {
        final class SectionHeaderView: UICollectionReusableView {}
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 10, height: 10)
        layout.headerReferenceSize = CGSize(width: 10, height: 5)
        let collectionView = UICollectionView(
            frame: CGRect(x: 0, y: 0, width: 10, height: 20), collectionViewLayout: layout)
        collectionView.register(
            SectionHeaderView.self, forSupplementaryViewOfKind: header, withReuseIdentifier: "SectionHeaderView")
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewCell, Int> { _, _, _ in }
        var indexPaths: [IndexPath] = []
        let dataSource = UICollectionViewDiffableDataSource<Int, Int>(collectionView: collectionView) {
            collectionView, indexPath, item in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            let view = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind, withClass: SectionHeaderView.self, for: indexPath)
            if view != nil {
                indexPaths.append(indexPath)
            }
            return view
        }
        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        snapshot.appendSections([0])
        snapshot.appendItems([1])
        dataSource.applySnapshotUsingReloadData(snapshot)
        collectionView.layoutIfNeeded()
        #expect(indexPaths == [indexPath])
        #expect(collectionView.supplementaryView(forElementKind: header, at: indexPath) is SectionHeaderView)
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
