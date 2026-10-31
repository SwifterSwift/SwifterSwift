// UITableView+IndexPathForLastRowInSectionTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import Foundation
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UITableViewIndexPathForLastRowInSectionTests {
    @Test
    func returnsTheLastRowOfEachSection() {
        withTableView(rows: [5, 8, 1]) { tableView in
            #expect(tableView.indexPathForLastRow(inSection: 0) == IndexPath(row: 4, section: 0))
            #expect(tableView.indexPathForLastRow(inSection: 1) == IndexPath(row: 7, section: 1))
            #expect(tableView.indexPathForLastRow(inSection: 2) == IndexPath(row: 0, section: 2))
        }
    }

    @Test
    func returnsNilForAnEmptySection() {
        withTableView(rows: [5, 0]) { tableView in
            #expect(tableView.indexPathForLastRow(inSection: 1) == nil)
        }
    }

    @Test(arguments: [-1, 2, 100, Int.min, Int.max])
    func returnsNilForSectionsOutOfRange(_ section: Int) {
        withTableView(rows: [5, 8]) { tableView in
            #expect(tableView.indexPathForLastRow(inSection: section) == nil)
        }
    }

    @Test
    func returnsNilWithoutSections() {
        withTableView(rows: []) { tableView in
            #expect(tableView.indexPathForLastRow(inSection: 0) == nil)
        }
    }

    /// Calls `body` with a table view whose sections have the given numbers of rows, each 44 points tall.
    private func withTableView(rows: [Int], _ body: (UITableView) throws -> Void) rethrows {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 320, height: 200), style: .plain)
        tableView.rowHeight = 44
        tableView.estimatedRowHeight = 0
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.sectionHeaderTopPadding = 0
        tableView.contentInsetAdjustmentBehavior = .never
        let dataSource = UITableViewDiffableDataSource<Int, Int>(tableView: tableView) { _, _, _ in UITableViewCell() }
        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        for (section, count) in rows.enumerated() {
            snapshot.appendSections([section])
            snapshot.appendItems((0..<count).map { section * 1_000 + $0 }, toSection: section)
        }
        dataSource.applySnapshotUsingReloadData(snapshot)
        try withExtendedLifetime(dataSource) { try body(tableView) }
    }
}
#endif
