// UIWindow+SwitchRootViewControllerTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import Foundation
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
@Suite(
    .disabled(
        if: ProcessInfo.processInfo.isMacCatalystApp, "Mac Catalyst test runners have no NSApplication for a UIWindow"))
struct UIWindowSwitchRootViewControllerTests {
    @Test
    func replacesRootImmediatelyWhenNotAnimated() {
        let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let oldController = UIViewController()
        let newController = UIViewController()
        window.rootViewController = oldController
        var completed = false
        window.switchRootViewController(to: newController, animated: false) { completed = true }
        #expect(completed)
        #expect(window.rootViewController === newController)
    }

    @Test
    func setsRootOfWindowWithoutOne() {
        let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let controller = UIViewController()
        window.switchRootViewController(to: controller, animated: false)
        #expect(window.rootViewController === controller)
    }

    @Test
    func keepsSameRootWhenSwitchingToIt() {
        let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let controller = UIViewController()
        window.rootViewController = controller
        window.switchRootViewController(to: controller, animated: false)
        #expect(window.rootViewController === controller)
    }

    @Test(.timeLimit(.minutes(1)))
    func replacesRootAndCallsCompletionWhenAnimated() async {
        let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let oldController = UIViewController()
        let newController = UITableViewController()
        window.rootViewController = oldController
        window.isHidden = false
        await withCheckedContinuation { continuation in
            window.switchRootViewController(
                to: newController,
                duration: 0.05,
                options: .transitionCrossDissolve
            ) {
                continuation.resume()
            }
            #expect(window.rootViewController === newController)
        }
        #expect(window.rootViewController === newController)
        #expect(newController.view.window === window)
    }
}
#endif
