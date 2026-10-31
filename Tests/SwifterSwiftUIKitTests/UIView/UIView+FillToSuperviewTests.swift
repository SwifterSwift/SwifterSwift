// UIView+FillToSuperviewTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIViewFillToSuperviewTests {
    @Test
    func fillsSuperviewWithoutInsets() {
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        let view = UIView()
        container.addSubview(view)
        view.fillToSuperview()
        container.layoutIfNeeded()
        #expect(view.frame == container.bounds)
        #expect(!view.translatesAutoresizingMaskIntoConstraints)
    }

    @Test
    func appliesInsetsInward() {
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        let view = UIView()
        container.addSubview(view)
        view.fillToSuperview(insets: NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 30, trailing: 40))
        container.layoutIfNeeded()
        #expect(view.frame == CGRect(x: 20, y: 10, width: 140, height: 60))
    }

    @Test
    func negativeInsetsLetViewOverflow() {
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        let view = UIView()
        container.addSubview(view)
        view.fillToSuperview(insets: NSDirectionalEdgeInsets(top: -5, leading: -5, bottom: -5, trailing: -5))
        container.layoutIfNeeded()
        #expect(view.frame == CGRect(x: -5, y: -5, width: 210, height: 110))
    }

    @Test
    func flipsLeadingAndTrailingInRightToLeftLayout() {
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        container.semanticContentAttribute = .forceRightToLeft
        let view = UIView()
        view.semanticContentAttribute = .forceRightToLeft
        container.addSubview(view)
        view.fillToSuperview(insets: NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 40))
        container.layoutIfNeeded()
        #expect(view.frame == CGRect(x: 40, y: 0, width: 140, height: 100))
    }

    @Test
    func returnsActiveConstraintsInEdgeOrder() {
        let container = UIView()
        let view = UIView()
        container.addSubview(view)
        let constraints = view.fillToSuperview()
        #expect(constraints.map(\.firstAttribute) == [.top, .leading, .bottom, .trailing])
        #expect(constraints.allSatisfy { $0.isActive && $0.firstItem === view && $0.secondItem === container })
    }

    @Test
    func pinsToSafeAreaWhenRequested() {
        let container = UIView()
        let view = UIView()
        container.addSubview(view)
        let constraints = view.fillToSuperview(respectingSafeArea: true)
        #expect(constraints.count == 4)
        #expect(constraints.allSatisfy { $0.secondItem === container.safeAreaLayoutGuide })
    }

    @Test
    func doesNothingWithoutSuperview() {
        let view = UIView()
        #expect(view.fillToSuperview().isEmpty)
        #expect(view.translatesAutoresizingMaskIntoConstraints)
        #expect(view.constraints.isEmpty)
    }
}
#endif
