// UINavigationController+PushViewControllerCompletionTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UINavigationControllerPushViewControllerCompletionTests {
    @Test
    func callsCompletionRightAwayWithoutWindow() {
        let navigationController = UINavigationController(rootViewController: UIViewController())
        let pushed = UIViewController()
        var completionCalls = 0
        navigationController.pushViewController(pushed, animated: true) {
            completionCalls += 1
            #expect(navigationController.topViewController === pushed)
        }
        #expect(completionCalls == 1)
        #expect(navigationController.viewControllers.count == 2)
    }

    @Test
    func pushesOntoEmptyStack() {
        let navigationController = UINavigationController()
        let pushed = UIViewController()
        var completionCalls = 0
        navigationController.pushViewController(pushed) {
            completionCalls += 1
        }
        #expect(completionCalls == 1)
        #expect(navigationController.viewControllers == [pushed])
    }
}
#endif
