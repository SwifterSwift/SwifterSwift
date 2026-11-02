// UITableView+IsValidIndexPathTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import Foundation
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UITableViewIsValidIndexPathTests {
    @Test(arguments: [IndexPath(row: 0, section: 0), IndexPath(row: 4, section: 0), IndexPath(row: 7, section: 1)])
    func returnsTrueForExistingRows(_ indexPath: IndexPath) {
        withTableView(rows: [5, 8]) { tableView in
            #expect(tableView.isValidIndexPath(indexPath))
        }
    }

    @Test(arguments: [
        IndexPath(row: 5, section: 0),
        IndexPath(row: 8, section: 1),
        IndexPath(row: 0, section: 2),
        IndexPath(row: 0, section: 3),
        IndexPath(row: -1, section: 0),
        IndexPath(row: 0, section: -1),
        IndexPath(row: Int.max, section: 0),
        IndexPath(row: 0, section: Int.min)
    ])
    func returnsFalseForMissingRows(_ indexPath: IndexPath) {
        withTableView(rows: [5, 8, 0]) { tableView in
            #expect(!tableView.isValidIndexPath(indexPath))
        }
    }

    @Test(arguments: [IndexPath(), IndexPath(index: 0), IndexPath(indexes: [0, 0, 0])])
    func returnsFalseForIndexPathsWithoutTwoIndices(_ indexPath: IndexPath) {
        withTableView(rows: [5]) { tableView in
            #expect(!tableView.isValidIndexPath(indexPath))
        }
    }

    @Test
    func returnsFalseWithoutSections() {
        withTableView(rows: []) { tableView in
            #expect(!tableView.isValidIndexPath(IndexPath(row: 0, section: 0)))
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
