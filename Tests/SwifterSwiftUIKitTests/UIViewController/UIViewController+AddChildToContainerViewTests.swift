// UIViewController+AddChildToContainerViewTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIViewControllerAddChildToContainerViewTests {
    @Test
    func addsChildAndItsView() {
        let parent = UIViewController()
        let child = UIViewController()
        parent.addChild(child, toContainerView: parent.view)
        #expect(parent.children == [child])
        #expect(child.parent === parent)
        #expect(child.view.superview === parent.view)
    }

    @Test
    func addsViewToNestedContainer() {
        let parent = UIViewController()
        let container = UIView()
        parent.view.addSubview(container)
        let child = UIViewController()
        parent.addChild(child, toContainerView: container)
        #expect(child.view.superview === container)
        #expect(parent.view.subviews == [container])
    }

    @Test
    func pinsChildViewToContainerEdges() {
        let parent = UIViewController()
        let container = UIView(frame: CGRect(x: 20, y: 40, width: 300, height: 200))
        parent.view.addSubview(container)
        let child = UIViewController()
        parent.addChild(child, toContainerView: container)
        container.layoutIfNeeded()
        #expect(!child.view.translatesAutoresizingMaskIntoConstraints)
        #expect(child.view.frame == container.bounds)

        container.frame.size = CGSize(width: 120, height: 80)
        container.layoutIfNeeded()
        #expect(child.view.frame == CGRect(x: 0, y: 0, width: 120, height: 80))
    }

    @Test
    func callsContainmentCallbacksInOrder() {
        final class RecordingViewController: UIViewController {
            var events: [String] = []

            override func willMove(toParent parent: UIViewController?) {
                super.willMove(toParent: parent)
                events.append("willMove(\(parent == nil ? "nil" : "parent"))")
            }

            override func didMove(toParent parent: UIViewController?) {
                super.didMove(toParent: parent)
                events.append("didMove(\(parent == nil ? "nil" : "parent"), inContainer: \(view.superview != nil))")
            }
        }

        let parent = UIViewController()
        let child = RecordingViewController()
        parent.addChild(child, toContainerView: parent.view)
        #expect(child.events == ["willMove(parent)", "didMove(parent, inContainer: true)"])
    }

    @Test
    func addsSeveralChildrenInOrder() {
        let parent = UIViewController()
        let first = UIViewController()
        let second = UIViewController()
        parent.addChild(first, toContainerView: parent.view)
        parent.addChild(second, toContainerView: parent.view)
        #expect(parent.children == [first, second])
        #expect(parent.view.subviews == [first.view, second.view])
    }
}
#endif
