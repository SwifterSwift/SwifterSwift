// UITableView+RegisterNibWithHeaderFooterViewClassTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS) && !os(visionOS)
import CoreGraphics
import Foundation
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UITableViewRegisterNibWithHeaderFooterViewClassTests {
    @Test
    func registersTheNibUnderTheClassName() throws {
        final class SectionHeaderView: UITableViewHeaderFooterView {}
        let template = SectionHeaderView(reuseIdentifier: nil)
        template.tag = 42
        let nib = UINib(data: makeNibData(containing: template), bundle: nil)
        try withTableView(rows: [1]) { tableView in
            tableView.register(nib: nib, withHeaderFooterViewClass: SectionHeaderView.self)
            let view = try #require(tableView.dequeueReusableHeaderFooterView(withIdentifier: "SectionHeaderView"))
            #expect(view is SectionHeaderView)
            #expect(view.tag == 42)
        }
    }

    @Test
    func removesTheRegistrationForANilNib() {
        final class SectionHeaderView: UITableViewHeaderFooterView {}
        withTableView(rows: [1]) { tableView in
            tableView.register(SectionHeaderView.self, forHeaderFooterViewReuseIdentifier: "SectionHeaderView")
            tableView.register(nib: nil, withHeaderFooterViewClass: SectionHeaderView.self)
            #expect(tableView.dequeueReusableHeaderFooterView(withIdentifier: "SectionHeaderView") == nil)
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
