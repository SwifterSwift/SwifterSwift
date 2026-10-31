// UITableView+IndexPathForLastRowTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import Foundation
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UITableViewIndexPathForLastRowTests {
    @Test(arguments: [
        ([5, 8], IndexPath(row: 7, section: 1)),
        ([1], IndexPath(row: 0, section: 0)),
        ([5, 0], IndexPath(row: 4, section: 0)),
        ([0, 3, 0, 0], IndexPath(row: 2, section: 1))
    ])
    func returnsTheLastRowOfTheLastNonEmptySection(rows: [Int], expected: IndexPath) {
        withTableView(rows: rows) { tableView in
            #expect(tableView.indexPathForLastRow == expected)
        }
    }

    @Test(arguments: [[Int](), [0], [0, 0, 0]])
    func returnsNilWithoutRows(_ rows: [Int]) {
        withTableView(rows: rows) { tableView in
            #expect(tableView.indexPathForLastRow == nil)
        }
    }

    @Test
    func alwaysReturnsAValidIndexPath() throws {
        try withTableView(rows: [2, 0]) { tableView in
            let indexPath = try #require(tableView.indexPathForLastRow)
            #expect(indexPath.row < tableView.numberOfRows(inSection: indexPath.section))
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
