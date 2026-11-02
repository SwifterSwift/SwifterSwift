// UIView+TrailingConstraintTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIViewTrailingConstraintTests {
    @Test
    func findsConstraintWhereViewIsFirstItem() {
        let container = UIView()
        let view = UIView()
        container.addSubview(view)
        let constraint = view.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 5)
        constraint.isActive = true
        #expect(view.trailingConstraint === constraint)
        #expect(view.trailingConstraint?.constant == 5)
    }

    @Test
    func findsConstraintWhereViewIsSecondItem() {
        let container = UIView()
        let view = UIView()
        container.addSubview(view)
        let constraint = container.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 7)
        constraint.isActive = true
        #expect(view.trailingConstraint === constraint)
    }

    @Test
    func findsConstraintInstalledOnAncestor() {
        let root = UIView()
        let container = UIView()
        let view = UIView()
        root.addSubview(container)
        container.addSubview(view)
        let constraint = view.trailingAnchor.constraint(equalTo: root.trailingAnchor, constant: 9)
        constraint.isActive = true
        #expect(root.constraints.contains(constraint))
        #expect(view.trailingConstraint === constraint)
    }

    @Test
    func ignoresOtherAttributes() {
        let container = UIView()
        let view = UIView()
        container.addSubview(view)
        view.rightAnchor.constraint(equalTo: container.rightAnchor).isActive = true
        #expect(view.trailingConstraint == nil)
    }

    @Test
    func returnsNilWithoutConstraints() {
        let container = UIView()
        let view = UIView()
        container.addSubview(view)
        #expect(view.trailingConstraint == nil)
        #expect(UIView().trailingConstraint == nil)
    }

    @Test
    func ignoresInactiveConstraints() {
        let container = UIView()
        let view = UIView()
        container.addSubview(view)
        let constraint = view.trailingAnchor.constraint(equalTo: container.trailingAnchor)
        constraint.isActive = true
        constraint.isActive = false
        #expect(view.trailingConstraint == nil)
    }

    @Test
    func ignoresConstraintsOfOtherViews() {
        let container = UIView()
        let view = UIView()
        let sibling = UIView()
        container.addSubview(view)
        container.addSubview(sibling)
        sibling.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        #expect(view.trailingConstraint == nil)
    }
}
#endif
