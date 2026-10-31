// UIView+AncestorViewWithClassTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIViewAncestorViewWithClassTests {
    @Test
    func returnsClosestAncestorOfClass() {
        let tableView = UITableView(frame: .zero)
        let cell = UITableViewCell(frame: .zero)
        let button = UIButton(frame: .zero)
        let icon = UIView(frame: .zero)
        tableView.addSubview(cell)
        cell.addSubview(button)
        button.addSubview(icon)
        #expect(icon.ancestorView(withClass: UITableViewCell.self) === cell)
        #expect(icon.ancestorView(withClass: UITableView.self) === tableView)
        #expect(icon.ancestorView(withClass: UIButton.self) === button)
        #expect(icon.ancestorView(withClass: UIView.self) === button)
    }

    @Test
    func matchesSubclasses() {
        let tableView = UITableView(frame: .zero)
        let button = UIButton(frame: .zero)
        tableView.addSubview(button)
        #expect(button.ancestorView(withClass: UIScrollView.self) === tableView)
    }

    @Test
    func neverReturnsTheViewItself() {
        let container = UIView()
        let button = UIButton()
        container.addSubview(button)
        #expect(button.ancestorView(withClass: UIButton.self) == nil)
    }

    @Test
    func returnsNilWhenNoAncestorMatches() {
        let container = UIView()
        let view = UIView()
        container.addSubview(view)
        #expect(view.ancestorView(withClass: UIStackView.self) == nil)
        #expect(UIView().ancestorView(withClass: UIView.self) == nil)
    }
}
#endif
