// UITableView+DequeueReusableHeaderFooterViewTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UITableViewDequeueReusableHeaderFooterViewTests {
    @Test
    func dequeuesAViewRegisteredUnderTheClassName() throws {
        final class SectionHeaderView: UITableViewHeaderFooterView {}
        try withTableView(rows: [1]) { tableView in
            tableView.register(SectionHeaderView.self, forHeaderFooterViewReuseIdentifier: "SectionHeaderView")
            let view = try #require(tableView.dequeueReusableHeaderFooterView(withClass: SectionHeaderView.self))
            #expect(type(of: view) == SectionHeaderView.self)
        }
    }

    @Test
    func dequeuesTheBaseViewClass() {
        withTableView(rows: [1]) { tableView in
            tableView.register(
                UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "UITableViewHeaderFooterView")
            #expect(tableView.dequeueReusableHeaderFooterView(withClass: UITableViewHeaderFooterView.self) != nil)
        }
    }

    @Test
    func returnsNilWhenNothingIsRegistered() {
        final class SectionHeaderView: UITableViewHeaderFooterView {}
        withTableView(rows: [1]) { tableView in
            #expect(tableView.dequeueReusableHeaderFooterView(withClass: SectionHeaderView.self) == nil)
        }
    }

    @Test
    func returnsNilWhenAnotherClassIsRegisteredUnderTheName() {
        final class SectionHeaderView: UITableViewHeaderFooterView {}
        withTableView(rows: [1]) { tableView in
            tableView.register(
                UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "SectionHeaderView")
            #expect(tableView.dequeueReusableHeaderFooterView(withClass: SectionHeaderView.self) == nil)
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
