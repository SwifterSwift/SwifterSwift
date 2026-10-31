// UITableView+RegisterNibWithCellClassTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS) && !os(visionOS)
import CoreGraphics
import Foundation
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UITableViewRegisterNibWithCellClassTests {
    @Test
    func registersTheNibUnderTheClassName() throws {
        final class ProfileCell: UITableViewCell {}
        let template = ProfileCell()
        template.tag = 42
        let nib = UINib(data: makeNibData(containing: template), bundle: nil)
        try withTableView(rows: [1]) { tableView in
            tableView.register(nib: nib, withCellClass: ProfileCell.self)
            let cell = try #require(tableView.dequeueReusableCell(withIdentifier: "ProfileCell"))
            #expect(cell is ProfileCell)
            #expect(cell.tag == 42)
        }
    }

    @Test
    func replacesAClassRegistration() throws {
        final class ProfileCell: UITableViewCell {}
        let template = ProfileCell()
        template.tag = 7
        let nib = UINib(data: makeNibData(containing: template), bundle: nil)
        try withTableView(rows: [1]) { tableView in
            tableView.register(ProfileCell.self, forCellReuseIdentifier: "ProfileCell")
            tableView.register(nib: nib, withCellClass: ProfileCell.self)
            let cell = try #require(tableView.dequeueReusableCell(withIdentifier: "ProfileCell"))
            #expect(cell.tag == 7)
        }
    }

    @Test
    func removesTheRegistrationForANilNib() {
        final class ProfileCell: UITableViewCell {}
        withTableView(rows: [1]) { tableView in
            tableView.register(ProfileCell.self, forCellReuseIdentifier: "ProfileCell")
            tableView.register(nib: nil, withCellClass: ProfileCell.self)
            #expect(tableView.dequeueReusableCell(withIdentifier: "ProfileCell") == nil)
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
