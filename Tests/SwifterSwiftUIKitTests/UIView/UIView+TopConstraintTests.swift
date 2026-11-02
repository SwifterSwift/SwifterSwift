// UIView+TopConstraintTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIViewTopConstraintTests {
    @Test
    func findsConstraintWhereViewIsFirstItem() {
        let container = UIView()
        let view = UIView()
        container.addSubview(view)
        let constraint = view.topAnchor.constraint(equalTo: container.topAnchor, constant: 5)
        constraint.isActive = true
        #expect(view.topConstraint === constraint)
        #expect(view.topConstraint?.constant == 5)
    }

    @Test
    func findsConstraintWhereViewIsSecondItem() {
        let container = UIView()
        let view = UIView()
        container.addSubview(view)
        let constraint = container.topAnchor.constraint(equalTo: view.topAnchor, constant: 7)
        constraint.isActive = true
        #expect(view.topConstraint === constraint)
    }

    @Test
    func findsConstraintInstalledOnAncestor() {
        let root = UIView()
        let container = UIView()
        let view = UIView()
        root.addSubview(container)
        container.addSubview(view)
        let constraint = view.topAnchor.constraint(equalTo: root.topAnchor, constant: 9)
        constraint.isActive = true
        #expect(root.constraints.contains(constraint))
        #expect(view.topConstraint === constraint)
    }

    @Test
    func ignoresOtherAttributes() {
        let container = UIView()
        let view = UIView()
        container.addSubview(view)
        view.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        #expect(view.topConstraint == nil)
    }

    @Test
    func returnsNilWithoutConstraints() {
        let container = UIView()
        let view = UIView()
        container.addSubview(view)
        #expect(view.topConstraint == nil)
        #expect(UIView().topConstraint == nil)
    }

    @Test
    func ignoresInactiveConstraints() {
        let container = UIView()
        let view = UIView()
        container.addSubview(view)
        let constraint = view.topAnchor.constraint(equalTo: container.topAnchor)
        constraint.isActive = true
        constraint.isActive = false
        #expect(view.topConstraint == nil)
    }

    @Test
    func ignoresConstraintsOfOtherViews() {
        let container = UIView()
        let view = UIView()
        let sibling = UIView()
        container.addSubview(view)
        container.addSubview(sibling)
        sibling.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        #expect(view.topConstraint == nil)
    }
}
#endif
