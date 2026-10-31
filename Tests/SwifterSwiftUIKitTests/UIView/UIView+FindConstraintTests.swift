// UIView+FindConstraintTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIViewFindConstraintTests {
    @Test
    func findsConstraintInstalledOnView() {
        let view = UIView()
        let width = view.widthAnchor.constraint(equalToConstant: 1)
        width.isActive = true
        #expect(view.findConstraint(attribute: .width, for: view) === width)
        #expect(view.findConstraint(attribute: .height, for: view) == nil)
    }

    @Test
    func findsConstraintInstalledOnAncestor() {
        let root = UIView()
        let container = UIView()
        let view = UIView()
        root.addSubview(container)
        container.addSubview(view)
        let top = view.topAnchor.constraint(equalTo: root.topAnchor, constant: 5)
        top.isActive = true
        #expect(root.constraints.contains(top))
        #expect(view.findConstraint(attribute: .top, for: view) === top)
    }

    @Test
    func findsViewOnEitherSideOfConstraint() {
        let container = UIView()
        let view = UIView()
        container.addSubview(view)
        let leading = container.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 3)
        leading.isActive = true
        #expect(view.findConstraint(attribute: .leading, for: view) === leading)
        #expect(view.findConstraint(attribute: .leading, for: container) === leading)
    }

    @Test
    func findsConstraintOfDescendantWhenCalledOnDescendant() {
        let container = UIView()
        let view = UIView()
        container.addSubview(view)
        view.heightAnchor.constraint(equalToConstant: 4).isActive = true
        #expect(view.findConstraint(attribute: .height, for: view)?.constant == 4)
        #expect(container.findConstraint(attribute: .height, for: view) == nil)
    }

    @Test
    func ignoresInactiveConstraints() {
        let view = UIView()
        let width = view.widthAnchor.constraint(equalToConstant: 1)
        width.isActive = true
        width.isActive = false
        #expect(view.findConstraint(attribute: .width, for: view) == nil)
    }

    @Test
    func ignoresConstraintsOfOtherViews() {
        let container = UIView()
        let view = UIView()
        let sibling = UIView()
        container.addSubview(view)
        container.addSubview(sibling)
        sibling.widthAnchor.constraint(equalToConstant: 1).isActive = true
        sibling.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        #expect(view.findConstraint(attribute: .width, for: view) == nil)
        #expect(view.findConstraint(attribute: .top, for: view) == nil)
        #expect(view.findConstraint(attribute: .height, for: UIView()) == nil)
    }

    @Test
    func returnsFirstMatchFromClosestView() {
        let container = UIView()
        let view = UIView()
        container.addSubview(view)
        let toContainer = view.widthAnchor.constraint(equalTo: container.widthAnchor)
        let constant = view.widthAnchor.constraint(lessThanOrEqualToConstant: 50)
        NSLayoutConstraint.activate([toContainer, constant])
        #expect(view.findConstraint(attribute: .width, for: view) === constant)
    }
}
#endif
