// UIView+LeadingConstraintTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIViewLeadingConstraintTests {
    @Test
    func findsConstraintWhereViewIsFirstItem() {
        let container = UIView()
        let view = UIView()
        container.addSubview(view)
        let constraint = view.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 5)
        constraint.isActive = true
        #expect(view.leadingConstraint === constraint)
        #expect(view.leadingConstraint?.constant == 5)
    }

    @Test
    func findsConstraintWhereViewIsSecondItem() {
        let container = UIView()
        let view = UIView()
        container.addSubview(view)
        let constraint = container.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 7)
        constraint.isActive = true
        #expect(view.leadingConstraint === constraint)
    }

    @Test
    func findsConstraintInstalledOnAncestor() {
        let root = UIView()
        let container = UIView()
        let view = UIView()
        root.addSubview(container)
        container.addSubview(view)
        let constraint = view.leadingAnchor.constraint(equalTo: root.leadingAnchor, constant: 9)
        constraint.isActive = true
        #expect(root.constraints.contains(constraint))
        #expect(view.leadingConstraint === constraint)
    }

    @Test
    func ignoresOtherAttributes() {
        let container = UIView()
        let view = UIView()
        container.addSubview(view)
        view.leftAnchor.constraint(equalTo: container.leftAnchor).isActive = true
        #expect(view.leadingConstraint == nil)
    }

    @Test
    func returnsNilWithoutConstraints() {
        let container = UIView()
        let view = UIView()
        container.addSubview(view)
        #expect(view.leadingConstraint == nil)
        #expect(UIView().leadingConstraint == nil)
    }

    @Test
    func ignoresInactiveConstraints() {
        let container = UIView()
        let view = UIView()
        container.addSubview(view)
        let constraint = view.leadingAnchor.constraint(equalTo: container.leadingAnchor)
        constraint.isActive = true
        constraint.isActive = false
        #expect(view.leadingConstraint == nil)
    }

    @Test
    func ignoresConstraintsOfOtherViews() {
        let container = UIView()
        let view = UIView()
        let sibling = UIView()
        container.addSubview(view)
        container.addSubview(sibling)
        sibling.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        #expect(view.leadingConstraint == nil)
    }
}
#endif
