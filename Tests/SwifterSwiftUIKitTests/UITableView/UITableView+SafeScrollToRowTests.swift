// UITableView+SafeScrollToRowTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import Foundation
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UITableViewSafeScrollToRowTests {
    @Test
    func scrollsToValidRowsLikeScrollToRow() {
        let targets: [(IndexPath, UITableView.ScrollPosition)] = [
            (IndexPath(row: 7, section: 1), .bottom), (IndexPath(row: 0, section: 0), .top),
            (IndexPath(row: 2, section: 1), .top), (IndexPath(row: 4, section: 0), .middle)
        ]
        withTableView(rows: [5, 8]) { tableView in
            withTableView(rows: [5, 8]) { reference in
                for (indexPath, position) in targets {
                    tableView.safeScrollToRow(at: indexPath, at: position, animated: false)
                    reference.scrollToRow(at: indexPath, at: position, animated: false)
                    #expect(tableView.contentOffset == reference.contentOffset)
                }
            }
        }
    }

    #if !os(tvOS) && !os(visionOS)
    // tvOS and visionOS position rows differently, so the exact offsets below only hold on the other platforms.
    @Test
    func scrollsToTheExpectedOffsets() {
        withTableView(rows: [5, 8]) { tableView in
            // 13 rows of 44 points in a 200-point-tall table view.
            tableView.safeScrollToRow(at: IndexPath(row: 7, section: 1), at: .bottom, animated: false)
            #expect(abs(tableView.contentOffset.y - (13 * 44 - 200)) < 1)

            tableView.safeScrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
            #expect(abs(tableView.contentOffset.y) < 1)

            tableView.safeScrollToRow(at: IndexPath(row: 2, section: 1), at: .top, animated: false)
            #expect(abs(tableView.contentOffset.y - 7 * 44) < 1)
        }
    }
    #endif

    @Test(arguments: [
        IndexPath(row: 8, section: 1),
        IndexPath(row: 0, section: 2),
        IndexPath(row: 213, section: 21),
        IndexPath(row: -1, section: 0),
        IndexPath(row: 0, section: -1),
        IndexPath(row: -1, section: -1),
        IndexPath(row: Int.min, section: Int.max),
        IndexPath(),
        IndexPath(index: 0),
        IndexPath(indexes: [0, 0, 0])
    ])
    func doesNothingForInvalidIndexPaths(_ indexPath: IndexPath) {
        withTableView(rows: [5, 8]) { tableView in
            tableView.contentOffset = CGPoint(x: 0, y: 100)
            tableView.safeScrollToRow(at: indexPath, at: .bottom, animated: false)
            #expect(tableView.contentOffset == CGPoint(x: 0, y: 100))
        }
    }

    @Test
    func doesNothingForAnEmptySection() {
        withTableView(rows: [5, 0]) { tableView in
            tableView.contentOffset = CGPoint(x: 0, y: 10)
            tableView.safeScrollToRow(at: IndexPath(row: 0, section: 1), at: .top, animated: false)
            #expect(tableView.contentOffset == CGPoint(x: 0, y: 10))
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
