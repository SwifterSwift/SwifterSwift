// UIView+BottomConstraintTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIViewBottomConstraintTests {
    @Test
    func findsConstraintWhereViewIsFirstItem() {
        let container = UIView()
        let view = UIView()
        container.addSubview(view)
        let constraint = view.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: 5)
        constraint.isActive = true
        #expect(view.bottomConstraint === constraint)
        #expect(view.bottomConstraint?.constant == 5)
    }

    @Test
    func findsConstraintWhereViewIsSecondItem() {
        let container = UIView()
        let view = UIView()
        container.addSubview(view)
        let constraint = container.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 7)
        constraint.isActive = true
        #expect(view.bottomConstraint === constraint)
    }

    @Test
    func findsConstraintInstalledOnAncestor() {
        let root = UIView()
        let container = UIView()
        let view = UIView()
        root.addSubview(container)
        container.addSubview(view)
        let constraint = view.bottomAnchor.constraint(equalTo: root.bottomAnchor, constant: 9)
        constraint.isActive = true
        #expect(root.constraints.contains(constraint))
        #expect(view.bottomConstraint === constraint)
    }

    @Test
    func ignoresOtherAttributes() {
        let container = UIView()
        let view = UIView()
        container.addSubview(view)
        view.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        #expect(view.bottomConstraint == nil)
    }

    @Test
    func returnsNilWithoutConstraints() {
        let container = UIView()
        let view = UIView()
        container.addSubview(view)
        #expect(view.bottomConstraint == nil)
        #expect(UIView().bottomConstraint == nil)
    }

    @Test
    func ignoresInactiveConstraints() {
        let container = UIView()
        let view = UIView()
        container.addSubview(view)
        let constraint = view.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        constraint.isActive = true
        constraint.isActive = false
        #expect(view.bottomConstraint == nil)
    }

    @Test
    func ignoresConstraintsOfOtherViews() {
        let container = UIView()
        let view = UIView()
        let sibling = UIView()
        container.addSubview(view)
        container.addSubview(sibling)
        sibling.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        #expect(view.bottomConstraint == nil)
    }
}
#endif
