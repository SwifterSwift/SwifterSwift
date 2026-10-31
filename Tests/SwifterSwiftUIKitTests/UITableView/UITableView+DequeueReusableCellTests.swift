// UITableView+DequeueReusableCellTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import Foundation
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UITableViewDequeueReusableCellTests {
    @Test
    func dequeuesACellRegisteredUnderTheClassName() throws {
        final class ProfileCell: UITableViewCell {}
        try withTableView(rows: [1]) { tableView in
            tableView.register(ProfileCell.self, forCellReuseIdentifier: "ProfileCell")
            let cell = try #require(
                tableView.dequeueReusableCell(withClass: ProfileCell.self, for: IndexPath(row: 0, section: 0)))
            #expect(type(of: cell) == ProfileCell.self)
        }
    }

    @Test
    func dequeuesTheBaseCellClass() {
        withTableView(rows: [1]) { tableView in
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
            let cell = tableView.dequeueReusableCell(
                withClass: UITableViewCell.self, for: IndexPath(row: 0, section: 0))
            #expect(cell != nil)
        }
    }

    @Test
    func dequeuesASubclassRegisteredUnderTheName() throws {
        final class FancyCell: UITableViewCell {}
        try withTableView(rows: [1]) { tableView in
            tableView.register(FancyCell.self, forCellReuseIdentifier: "UITableViewCell")
            let cell = try #require(
                tableView.dequeueReusableCell(withClass: UITableViewCell.self, for: IndexPath(row: 0, section: 0)))
            #expect(cell is FancyCell)
        }
    }

    @Test
    func returnsNilWhenAnotherClassIsRegisteredUnderTheName() {
        final class ProfileCell: UITableViewCell {}
        withTableView(rows: [1]) { tableView in
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ProfileCell")
            #expect(
                tableView.dequeueReusableCell(withClass: ProfileCell.self, for: IndexPath(row: 0, section: 0)) == nil)
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
