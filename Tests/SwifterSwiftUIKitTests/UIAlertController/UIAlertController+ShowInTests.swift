// UIAlertController+ShowInTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import Foundation
import SwifterSwiftUIKit
import Testing
import UIKit

/// A `UIWindowScene` can't be created directly; it only exists in an app. Package test runners aren't apps, so these
/// tests only run when the tests are hosted in an app, and are skipped otherwise.
@MainActor
@Suite(
    .enabled("Needs a window scene from a host app") {
        await MainActor.run {
            let application =
                (UIApplication.self as AnyObject).perform(NSSelectorFromString("sharedApplication"))?
                .takeUnretainedValue() as? UIApplication
            return application?.connectedScenes.contains { $0 is UIWindowScene } == true
        }
    })
struct UIAlertControllerShowInTests {
    /// Records presentation requests instead of presenting, and can pretend to be presenting another controller.
    final class RecordingPresenter: UIViewController {
        var presented: [(viewController: UIViewController, animated: Bool)] = []
        var stubbedPresentedViewController: UIViewController?

        override var presentedViewController: UIViewController? {
            stubbedPresentedViewController
        }

        override func present(
            _ viewControllerToPresent: UIViewController,
            animated flag: Bool,
            completion: (() -> Void)? = nil
        ) {
            presented.append((viewControllerToPresent, flag))
            completion?()
        }
    }

    /// An alert that reports being presented already.
    final class PresentedAlert: UIAlertController {
        let presenter = UIViewController()

        override var presentingViewController: UIViewController? {
            presenter
        }
    }

    /// The first window scene of the app hosting the tests, if they run in one.
    static func hostScene() -> UIWindowScene? {
        // `UIApplication.shared` isn't optional, but there's no application outside an app.
        let application =
            (UIApplication.self as AnyObject).perform(NSSelectorFromString("sharedApplication"))?
            .takeUnretainedValue() as? UIApplication
        return application?.connectedScenes.first { $0 is UIWindowScene } as? UIWindowScene
    }

    /// Runs the body with a new key window in the host scene, whose root is the given view controller.
    func withKeyWindow(rootViewController: UIViewController?, _ body: (UIWindowScene) -> Void) throws {
        let scene = try #require(Self.hostScene())
        let previousKeyWindow = scene.keyWindow
        let window = UIWindow(windowScene: scene)
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        defer {
            window.isHidden = true
            previousKeyWindow?.makeKey()
        }
        body(scene)
    }

    @Test
    func presentsFromTheRootViewController() throws {
        let root = RecordingPresenter()
        let alert = UIAlertController(title: "Title", message: nil, preferredStyle: .alert)
        try withKeyWindow(rootViewController: root) { scene in
            #expect(alert.show(in: scene))
        }
        #expect(root.presented.count == 1)
        #expect(root.presented.first?.viewController === alert)
        #expect(root.presented.first?.animated == true)
    }

    @Test
    func presentsFromTheTopMostPresentedViewController() throws {
        let root = RecordingPresenter()
        let middle = RecordingPresenter()
        let top = RecordingPresenter()
        root.stubbedPresentedViewController = middle
        middle.stubbedPresentedViewController = top
        let alert = UIAlertController(title: nil, message: "Message", preferredStyle: .alert)
        try withKeyWindow(rootViewController: root) { scene in
            #expect(alert.show(in: scene, animated: false))
        }
        #expect(root.presented.isEmpty)
        #expect(middle.presented.isEmpty)
        #expect(top.presented.first?.viewController === alert)
        #expect(top.presented.first?.animated == false)
    }

    @Test
    func callsTheCompletion() throws {
        let root = RecordingPresenter()
        var completed = false
        try withKeyWindow(rootViewController: root) { scene in
            UIAlertController(title: "Title", message: nil, preferredStyle: .alert).show(in: scene) {
                completed = true
            }
        }
        #expect(completed)
    }

    @Test
    func returnsFalseWithoutRootViewController() throws {
        let alert = UIAlertController(title: "Title", message: nil, preferredStyle: .alert)
        try withKeyWindow(rootViewController: nil) { scene in
            #expect(!alert.show(in: scene))
        }
    }

    @Test
    func returnsFalseForAnAlertThatIsAlreadyPresented() throws {
        let root = RecordingPresenter()
        let alert = PresentedAlert(title: "Title", message: nil, preferredStyle: .alert)
        try withKeyWindow(rootViewController: root) { scene in
            #expect(!alert.show(in: scene))
        }
        #expect(root.presented.isEmpty)
    }

    @Test
    func returnsFalseForAChildAlert() throws {
        let root = RecordingPresenter()
        let parent = UIViewController()
        let alert = UIAlertController(title: "Title", message: nil, preferredStyle: .alert)
        parent.addChild(alert)
        try withKeyWindow(rootViewController: root) { scene in
            #expect(!alert.show(in: scene))
        }
        #expect(root.presented.isEmpty)
    }

    @Test
    func returnsFalseForTheRootAlert() throws {
        let alert = UIAlertController(title: "Title", message: nil, preferredStyle: .alert)
        try withKeyWindow(rootViewController: alert) { scene in
            #expect(!alert.show(in: scene))
        }
    }
}
#endif
