// UIView+OwningViewControllerTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import Foundation
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIViewOwningViewControllerTests {
    @Test
    func returnsControllerForItsRootView() {
        let controller = UIViewController()
        #expect(controller.view.owningViewController === controller)
    }

    @Test
    func returnsControllerForNestedSubview() {
        let controller = UIViewController()
        let container = UIView()
        let button = UIButton()
        controller.view.addSubview(container)
        container.addSubview(button)
        #expect(button.owningViewController === controller)
        #expect(container.owningViewController === controller)
    }

    @Test
    func returnsChildControllerRatherThanItsParent() {
        let parent = UIViewController()
        let child = UIViewController()
        parent.addChild(child)
        parent.view.addSubview(child.view)
        child.didMove(toParent: parent)
        let label = UILabel()
        child.view.addSubview(label)
        #expect(label.owningViewController === child)
        #expect(child.view.owningViewController === child)
        #expect(child.view.owningViewController !== child.parent)
    }

    @Test
    func returnsNilForDetachedView() {
        let view = UIView()
        view.addSubview(UIView())
        #expect(view.owningViewController == nil)
        #expect(view.subviews[0].owningViewController == nil)
    }

    @Test(
        .disabled(
            if: ProcessInfo.processInfo.isMacCatalystApp,
            "Mac Catalyst test runners have no NSApplication for a UIWindow"))
    func returnsNilForViewInWindowWithoutController() {
        let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let view = UIView()
        window.addSubview(view)
        #expect(view.owningViewController == nil)
    }
}
#endif
