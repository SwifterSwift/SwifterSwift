// UIViewController+RemoveViewAndControllerFromParentTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIViewControllerRemoveViewAndControllerFromParentTests {
    func embed(_ child: UIViewController, in parent: UIViewController) {
        parent.addChild(child)
        parent.view.addSubview(child.view)
        child.didMove(toParent: parent)
    }

    @Test
    func removesChildAndItsView() {
        let parent = UIViewController()
        let child = UIViewController()
        embed(child, in: parent)
        child.removeViewAndControllerFromParent()
        #expect(parent.children.isEmpty)
        #expect(child.parent == nil)
        #expect(child.view.superview == nil)
        #expect(parent.view.subviews.isEmpty)
    }

    @Test
    func keepsOtherChildren() {
        let parent = UIViewController()
        let first = UIViewController()
        let second = UIViewController()
        embed(first, in: parent)
        embed(second, in: parent)
        first.removeViewAndControllerFromParent()
        #expect(parent.children == [second])
        #expect(parent.view.subviews == [second.view])
    }

    @Test
    func callsContainmentCallbacksInOrder() {
        final class RecordingViewController: UIViewController {
            var events: [String] = []

            override func willMove(toParent parent: UIViewController?) {
                super.willMove(toParent: parent)
                if parent == nil {
                    events.append("willMove(nil), inSuperview: \(viewIfLoaded?.superview != nil)")
                }
            }

            override func didMove(toParent parent: UIViewController?) {
                super.didMove(toParent: parent)
                if parent == nil {
                    events.append("didMove(nil), inSuperview: \(viewIfLoaded?.superview != nil)")
                }
            }
        }

        let parent = UIViewController()
        let child = RecordingViewController()
        embed(child, in: parent)
        child.removeViewAndControllerFromParent()
        #expect(child.events == ["willMove(nil), inSuperview: true", "didMove(nil), inSuperview: false"])
    }

    @Test
    func doesNothingWithoutParent() {
        let viewController = UIViewController()
        let superview = UIView()
        superview.addSubview(viewController.view)
        viewController.removeViewAndControllerFromParent()
        #expect(viewController.parent == nil)
        #expect(viewController.view.superview === superview)
    }

    @Test
    func doesNotLoadViewOfChildWithoutView() {
        let parent = UIViewController()
        let child = UIViewController()
        parent.addChild(child)
        child.removeViewAndControllerFromParent()
        #expect(parent.children.isEmpty)
        #expect(!child.isViewLoaded)
    }
}
#endif
