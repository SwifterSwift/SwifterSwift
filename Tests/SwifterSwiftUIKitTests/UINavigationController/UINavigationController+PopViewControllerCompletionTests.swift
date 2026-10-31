// UINavigationController+PopViewControllerCompletionTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UINavigationControllerPopViewControllerCompletionTests {
    @Test
    func popsAndCallsCompletionRightAwayWithoutWindow() {
        let root = UIViewController()
        let top = UIViewController()
        let navigationController = UINavigationController(rootViewController: root)
        navigationController.pushViewController(top, animated: false)
        var completionCalls = 0
        let popped = navigationController.popViewController(animated: true) {
            completionCalls += 1
            #expect(navigationController.topViewController === root)
        }
        #expect(popped === top)
        #expect(completionCalls == 1)
        #expect(navigationController.viewControllers == [root])
    }

    @Test
    func returnsNilAndCallsCompletionWithOnlyRoot() {
        let root = UIViewController()
        let navigationController = UINavigationController(rootViewController: root)
        var completionCalls = 0
        let popped = navigationController.popViewController {
            completionCalls += 1
        }
        #expect(popped == nil)
        #expect(completionCalls == 1)
        #expect(navigationController.viewControllers == [root])
    }

    @Test
    func returnsNilAndCallsCompletionForEmptyStack() {
        let navigationController = UINavigationController()
        var completionCalls = 0
        let popped = navigationController.popViewController(animated: false) {
            completionCalls += 1
        }
        #expect(popped == nil)
        #expect(completionCalls == 1)
    }
}
#endif
