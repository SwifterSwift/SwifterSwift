// NSView+RemoveAllSubviewsTests.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
import SwifterSwiftAppKit
import Testing

@MainActor
struct NSViewRemoveAllSubviewsTests {
    @Test
    func removesEverySubview() {
        let container = NSView()
        let views = [NSView(), NSView(), NSView()]
        for view in views {
            container.addSubview(view)
        }
        container.removeAllSubviews()
        #expect(container.subviews.isEmpty)
        #expect(views.allSatisfy { $0.superview == nil })
    }

    @Test
    func doesNothingWithoutSubviews() {
        let container = NSView()
        container.removeAllSubviews()
        #expect(container.subviews.isEmpty)
    }

    @Test
    func keepsGrandchildrenAttachedToTheirParent() {
        let container = NSView()
        let child = NSView()
        let grandchild = NSView()
        child.addSubview(grandchild)
        container.addSubview(child)
        container.removeAllSubviews()
        #expect(child.superview == nil)
        #expect(grandchild.superview === child)
    }

    @Test
    func leavesTheViewInItsOwnSuperview() {
        let parent = NSView()
        let container = NSView()
        parent.addSubview(container)
        container.addSubview(NSView())
        container.removeAllSubviews()
        #expect(container.superview === parent)
        #expect(parent.subviews == [container])
    }

    @Test
    func deactivatesConstraintsToTheRemovedViews() {
        let container = NSView()
        let child = NSView()
        child.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(child)
        let constraint = child.leadingAnchor.constraint(equalTo: container.leadingAnchor)
        constraint.isActive = true
        container.removeAllSubviews()
        #expect(!constraint.isActive)
    }
}
#endif
