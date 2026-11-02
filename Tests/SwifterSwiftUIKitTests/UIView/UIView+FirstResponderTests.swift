// UIView+FirstResponderTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIViewFirstResponderTests {
    final class ResponderView: UIView {
        override var isFirstResponder: Bool { true }
    }

    @Test
    func returnsNilWhenNothingIsFirstResponder() {
        let root = UIView()
        let child = UIView()
        root.addSubview(child)
        child.addSubview(UITextField())
        #expect(root.firstResponder() == nil)
        #expect(UIView().firstResponder() == nil)
    }

    @Test
    func returnsViewItself() {
        let view = ResponderView()
        view.addSubview(ResponderView())
        #expect(view.firstResponder() === view)
    }

    @Test
    func returnsDeeplyNestedResponder() {
        let root = UIView()
        let child = UIView()
        let grandchild = UIView()
        let responder = ResponderView()
        root.addSubview(child)
        child.addSubview(grandchild)
        grandchild.addSubview(responder)
        #expect(root.firstResponder() === responder)
        #expect(child.firstResponder() === responder)
        #expect(responder.firstResponder() === responder)
    }

    @Test
    func searchesBreadthFirst() {
        let root = UIView()
        let branch = UIView()
        let deep = ResponderView()
        let shallow = ResponderView()
        root.addSubview(branch)
        branch.addSubview(deep)
        root.addSubview(shallow)
        #expect(root.firstResponder() === shallow)
    }

    @Test
    func ignoresRespondersOutsideTheHierarchy() {
        let root = UIView()
        let sibling = ResponderView()
        let container = UIView()
        container.addSubview(root)
        container.addSubview(sibling)
        #expect(root.firstResponder() == nil)
        #expect(container.firstResponder() === sibling)
    }
}
#endif
