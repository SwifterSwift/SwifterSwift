// UIView+WidthConstraintTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIViewWidthConstraintTests {
    @Test
    func findsConstantConstraintInstalledOnView() {
        let view = UIView()
        let constraint = view.widthAnchor.constraint(equalToConstant: 12)
        constraint.isActive = true
        #expect(view.widthConstraint === constraint)
        #expect(view.widthConstraint?.constant == 12)
    }

    @Test
    func findsConstraintWhereViewIsSecondItem() {
        let container = UIView()
        let view = UIView()
        let sibling = UIView()
        container.addSubview(view)
        container.addSubview(sibling)
        let constraint = sibling.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2)
        constraint.isActive = true
        #expect(view.widthConstraint === constraint)
        #expect(sibling.widthConstraint === constraint)
    }

    @Test
    func findsConstraintInstalledOnAncestor() {
        let root = UIView()
        let container = UIView()
        let view = UIView()
        root.addSubview(container)
        container.addSubview(view)
        let constraint = view.widthAnchor.constraint(equalTo: root.widthAnchor, constant: -8)
        constraint.isActive = true
        #expect(root.constraints.contains(constraint))
        #expect(view.widthConstraint === constraint)
    }

    @Test
    func ignoresOtherAttributes() {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 12).isActive = true
        #expect(view.widthConstraint == nil)
    }

    @Test
    func returnsNilWithoutConstraints() {
        let container = UIView()
        let view = UIView()
        container.addSubview(view)
        #expect(view.widthConstraint == nil)
        #expect(UIView().widthConstraint == nil)
    }

    @Test
    func ignoresInactiveConstraints() {
        let container = UIView()
        let view = UIView()
        container.addSubview(view)
        let constraint = view.widthAnchor.constraint(equalTo: container.widthAnchor)
        constraint.isActive = true
        constraint.isActive = false
        #expect(view.widthConstraint == nil)
    }

    @Test
    func ignoresConstraintsOfOtherViews() {
        let container = UIView()
        let view = UIView()
        let sibling = UIView()
        container.addSubview(view)
        container.addSubview(sibling)
        sibling.widthAnchor.constraint(equalTo: container.widthAnchor).isActive = true
        #expect(view.widthConstraint == nil)
    }
}
#endif
