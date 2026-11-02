// UITableView+RegisterCellWithClassTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import Foundation
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UITableViewRegisterCellWithClassTests {
    @Test
    func registersTheClassUnderItsName() throws {
        final class ProfileCell: UITableViewCell {}
        try withTableView(rows: [1]) { tableView in
            tableView.register(cellWithClass: ProfileCell.self)
            let cell = try #require(tableView.dequeueReusableCell(withIdentifier: "ProfileCell"))
            #expect(type(of: cell) == ProfileCell.self)
            let forIndexPath = tableView.dequeueReusableCell(
                withIdentifier: "ProfileCell", for: IndexPath(row: 0, section: 0))
            #expect(type(of: forIndexPath) == ProfileCell.self)
        }
    }

    @Test
    func registersTheBaseCellClass() {
        withTableView(rows: [1]) { tableView in
            tableView.register(cellWithClass: UITableViewCell.self)
            #expect(tableView.dequeueReusableCell(withIdentifier: "UITableViewCell") != nil)
        }
    }

    @Test
    func usesTheDynamicTypeOfTheClass() throws {
        final class ProfileCell: UITableViewCell {}
        try withTableView(rows: [1]) { tableView in
            let cellClass: UITableViewCell.Type = ProfileCell.self
            tableView.register(cellWithClass: cellClass)
            let cell = try #require(tableView.dequeueReusableCell(withIdentifier: "ProfileCell"))
            #expect(cell is ProfileCell)
        }
    }

    @Test
    func replacesAnEarlierRegistration() throws {
        final class ProfileCell: UITableViewCell {}
        try withTableView(rows: [1]) { tableView in
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ProfileCell")
            tableView.register(cellWithClass: ProfileCell.self)
            let cell = try #require(tableView.dequeueReusableCell(withIdentifier: "ProfileCell"))
            #expect(cell is ProfileCell)
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
