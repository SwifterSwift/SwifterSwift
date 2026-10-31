// UIView+RemoveAllSubviewsTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIViewRemoveAllSubviewsTests {
    @Test
    func removesEverySubview() {
        let container = UIView()
        let views = [UIView(), UILabel(), UIButton()]
        for view in views {
            container.addSubview(view)
        }
        container.removeAllSubviews()
        #expect(container.subviews.isEmpty)
        #expect(views.allSatisfy { $0.superview == nil })
    }

    @Test
    func doesNothingWithoutSubviews() {
        let container = UIView()
        container.removeAllSubviews()
        #expect(container.subviews.isEmpty)
    }

    @Test
    func keepsTheHierarchyInsideRemovedSubviews() {
        let container = UIView()
        let child = UIView()
        let grandchild = UIView()
        container.addSubview(child)
        child.addSubview(grandchild)
        container.removeAllSubviews()
        #expect(child.superview == nil)
        #expect(child.subviews == [grandchild])
    }

    @Test
    func removesConstraintsToRemovedSubviews() {
        let container = UIView()
        let child = UIView()
        container.addSubview(child)
        child.translatesAutoresizingMaskIntoConstraints = false
        let constraint = child.topAnchor.constraint(equalTo: container.topAnchor)
        constraint.isActive = true
        container.removeAllSubviews()
        #expect(!constraint.isActive)
        #expect(container.constraints.isEmpty)
    }

    @Test
    func removesArrangedSubviewsOfStackView() {
        let stack = UIStackView(arrangedSubviews: [UIView(), UIView()])
        stack.removeAllSubviews()
        #expect(stack.arrangedSubviews.isEmpty)
        #expect(stack.subviews.isEmpty)
    }
}
#endif
