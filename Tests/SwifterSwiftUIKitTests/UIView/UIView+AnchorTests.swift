// UIView+AnchorTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIViewAnchorTests {
    @Test
    func doesNothingWithoutAnchorsOrSizes() {
        let container = UIView()
        let view = UIView()
        container.addSubview(view)
        #expect(view.anchor().isEmpty)
        #expect(view.translatesAutoresizingMaskIntoConstraints)
        #expect(container.constraints.isEmpty)
        #expect(view.constraints.isEmpty)
    }

    @Test
    func anchorsAllEdgesWithConstantsInward() {
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        let view = UIView()
        container.addSubview(view)
        view.anchor(
            top: container.topAnchor,
            leading: container.leadingAnchor,
            bottom: container.bottomAnchor,
            trailing: container.trailingAnchor,
            topConstant: 10,
            leadingConstant: 20,
            bottomConstant: 30,
            trailingConstant: 40
        )
        container.layoutIfNeeded()
        #expect(view.frame == CGRect(x: 20, y: 10, width: 140, height: 60))
        #expect(!view.translatesAutoresizingMaskIntoConstraints)
    }

    @Test
    func returnsActiveConstraintsInOrder() {
        let container = UIView()
        let view = UIView()
        container.addSubview(view)
        let constraints = view.anchor(
            top: container.topAnchor,
            leading: container.leadingAnchor,
            bottom: container.bottomAnchor,
            trailing: container.trailingAnchor,
            topConstant: 1,
            leadingConstant: 2,
            bottomConstant: 3,
            trailingConstant: 4,
            widthConstant: 5,
            heightConstant: 6
        )
        #expect(constraints.map(\.firstAttribute) == [.top, .leading, .bottom, .trailing, .width, .height])
        #expect(constraints.map(\.constant) == [1, 2, -3, -4, 5, 6])
        #expect(constraints.allSatisfy { $0.isActive && $0.firstItem === view })
    }

    @Test
    func skipsEdgesThatAreNotGiven() {
        let container = UIView()
        let view = UIView()
        container.addSubview(view)
        let constraints = view.anchor(top: container.topAnchor, trailing: container.trailingAnchor)
        #expect(constraints.map(\.firstAttribute) == [.top, .trailing])
    }

    @Test
    func createsZeroSizeConstraints() {
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        let view = UIView()
        container.addSubview(view)
        let constraints = view.anchor(
            top: container.topAnchor,
            leading: container.leadingAnchor,
            widthConstant: 0,
            heightConstant: 0
        )
        container.layoutIfNeeded()
        #expect(constraints.count == 4)
        #expect(view.frame.size == .zero)
    }

    @Test
    func sizesViewWithoutEdges() {
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        let view = UIView()
        container.addSubview(view)
        let constraints = view.anchor(widthConstant: 30, heightConstant: 20)
        container.layoutIfNeeded()
        #expect(constraints.map(\.firstAttribute) == [.width, .height])
        #expect(view.bounds.size == CGSize(width: 30, height: 20))
    }

    @Test
    func flipsLeadingAndTrailingInRightToLeftLayout() {
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        container.semanticContentAttribute = .forceRightToLeft
        let view = UIView()
        view.semanticContentAttribute = .forceRightToLeft
        container.addSubview(view)
        view.anchor(
            top: container.topAnchor,
            leading: container.leadingAnchor,
            leadingConstant: 20,
            widthConstant: 50,
            heightConstant: 10
        )
        container.layoutIfNeeded()
        #expect(view.frame == CGRect(x: 130, y: 0, width: 50, height: 10))
    }
}
#endif
