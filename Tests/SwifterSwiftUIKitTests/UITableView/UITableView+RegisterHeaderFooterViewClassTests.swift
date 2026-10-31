// UITableView+RegisterHeaderFooterViewClassTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UITableViewRegisterHeaderFooterViewClassTests {
    @Test
    func registersTheClassUnderItsName() throws {
        final class SectionHeaderView: UITableViewHeaderFooterView {}
        try withTableView(rows: [1]) { tableView in
            tableView.register(headerFooterViewClass: SectionHeaderView.self)
            let view = try #require(tableView.dequeueReusableHeaderFooterView(withIdentifier: "SectionHeaderView"))
            #expect(type(of: view) == SectionHeaderView.self)
        }
    }

    @Test
    func registersTheBaseViewClass() {
        withTableView(rows: [1]) { tableView in
            tableView.register(headerFooterViewClass: UITableViewHeaderFooterView.self)
            #expect(tableView.dequeueReusableHeaderFooterView(withIdentifier: "UITableViewHeaderFooterView") != nil)
        }
    }

    @Test
    func replacesAnEarlierRegistration() throws {
        final class SectionHeaderView: UITableViewHeaderFooterView {}
        try withTableView(rows: [1]) { tableView in
            tableView.register(
                UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "SectionHeaderView")
            tableView.register(headerFooterViewClass: SectionHeaderView.self)
            let view = try #require(tableView.dequeueReusableHeaderFooterView(withIdentifier: "SectionHeaderView"))
            #expect(view is SectionHeaderView)
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
