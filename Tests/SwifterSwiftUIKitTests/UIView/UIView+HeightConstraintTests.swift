// UIView+HeightConstraintTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIViewHeightConstraintTests {
    @Test
    func findsConstantConstraintInstalledOnView() {
        let view = UIView()
        let constraint = view.heightAnchor.constraint(equalToConstant: 12)
        constraint.isActive = true
        #expect(view.heightConstraint === constraint)
        #expect(view.heightConstraint?.constant == 12)
    }

    @Test
    func findsConstraintWhereViewIsSecondItem() {
        let container = UIView()
        let view = UIView()
        let sibling = UIView()
        container.addSubview(view)
        container.addSubview(sibling)
        let constraint = sibling.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 2)
        constraint.isActive = true
        #expect(view.heightConstraint === constraint)
        #expect(sibling.heightConstraint === constraint)
    }

    @Test
    func findsConstraintInstalledOnAncestor() {
        let root = UIView()
        let container = UIView()
        let view = UIView()
        root.addSubview(container)
        container.addSubview(view)
        let constraint = view.heightAnchor.constraint(equalTo: root.heightAnchor, constant: -8)
        constraint.isActive = true
        #expect(root.constraints.contains(constraint))
        #expect(view.heightConstraint === constraint)
    }

    @Test
    func ignoresOtherAttributes() {
        let view = UIView()
        view.widthAnchor.constraint(equalToConstant: 12).isActive = true
        #expect(view.heightConstraint == nil)
    }

    @Test
    func returnsNilWithoutConstraints() {
        let container = UIView()
        let view = UIView()
        container.addSubview(view)
        #expect(view.heightConstraint == nil)
        #expect(UIView().heightConstraint == nil)
    }

    @Test
    func ignoresInactiveConstraints() {
        let container = UIView()
        let view = UIView()
        container.addSubview(view)
        let constraint = view.heightAnchor.constraint(equalTo: container.heightAnchor)
        constraint.isActive = true
        constraint.isActive = false
        #expect(view.heightConstraint == nil)
    }

    @Test
    func ignoresConstraintsOfOtherViews() {
        let container = UIView()
        let view = UIView()
        let sibling = UIView()
        container.addSubview(view)
        container.addSubview(sibling)
        sibling.heightAnchor.constraint(equalTo: container.heightAnchor).isActive = true
        #expect(view.heightConstraint == nil)
    }
}
#endif
