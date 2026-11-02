// UIViewController+IsVisibleTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIViewControllerIsVisibleTests {
    @Test
    func isFalseAndDoesNotLoadViewBeforeViewIsLoaded() {
        let viewController = UIViewController()
        #expect(!viewController.isVisible)
        #expect(!viewController.isViewLoaded)
    }

    @Test
    func isFalseWhenViewIsNotInWindow() {
        let viewController = UIViewController()
        viewController.loadViewIfNeeded()
        #expect(!viewController.isVisible)

        let superview = UIView()
        superview.addSubview(viewController.view)
        #expect(!viewController.isVisible)
    }
}
#endif
