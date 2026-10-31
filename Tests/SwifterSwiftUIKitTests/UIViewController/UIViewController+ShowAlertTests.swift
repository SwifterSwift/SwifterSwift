// UIViewController+ShowAlertTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import Foundation
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIViewControllerShowAlertTests {
    /// Records presentation requests instead of presenting, so presenting needs no window.
    final class RecordingPresenter: UIViewController {
        var presented: [(viewController: UIViewController, animated: Bool)] = []

        override func present(
            _ viewControllerToPresent: UIViewController,
            animated flag: Bool,
            completion: (() -> Void)? = nil
        ) {
            presented.append((viewControllerToPresent, flag))
            completion?()
        }
    }

    @Test
    func createsAlertWithButtonsInOrder() {
        let viewController = UIViewController()
        let alert = viewController.showAlert(
            title: "Delete photo?",
            message: "This can't be undone.",
            buttonTitles: ["Cancel", "Delete"]
        )
        #expect(alert.preferredStyle == .alert)
        #expect(alert.title == "Delete photo?")
        #expect(alert.message == "This can't be undone.")
        #expect(alert.actions.map(\.title) == ["Cancel", "Delete"])
        #expect(alert.actions.allSatisfy { $0.style == .default })
        #expect(alert.preferredAction == nil)
    }

    @Test
    func showsLocalizedOKWithoutButtonTitles() {
        let alert = UIViewController().showAlert(title: nil, message: nil)
        #expect(alert.title == nil)
        #expect(alert.message == nil)
        #expect(alert.actions.map(\.title) == [String(localized: "OK")])
    }

    @Test
    func highlightsGivenButton() {
        let alert = UIViewController().showAlert(
            title: "Title",
            message: nil,
            buttonTitles: ["One", "Two", "Three"],
            highlightedButtonIndex: 2
        )
        #expect(alert.preferredAction === alert.actions[2])
    }

    @Test
    func highlightsDefaultOKButton() {
        let alert = UIViewController().showAlert(title: "Title", message: nil, highlightedButtonIndex: 0)
        #expect(alert.preferredAction === alert.actions.first)
    }

    @Test(arguments: [-1, 2, 100, Int.max, Int.min])
    func ignoresOutOfRangeHighlightedIndex(_ index: Int) {
        let alert = UIViewController().showAlert(
            title: "Title",
            message: nil,
            buttonTitles: ["One", "Two"],
            highlightedButtonIndex: index
        )
        #expect(alert.actions.count == 2)
        #expect(alert.preferredAction == nil)
    }

    @Test
    func keepsDuplicateAndUnicodeTitles() {
        let titles = ["OK", "OK", "", "👍🏽", "e\u{301}", "حسناً"]
        let alert = UIViewController().showAlert(title: nil, message: nil, buttonTitles: titles)
        #expect(alert.actions.map(\.title) == titles)
    }

    @Test
    func presentsAlertAnimatedFromReceiver() throws {
        let presenter = RecordingPresenter()
        let alert = presenter.showAlert(title: "Title", message: "Message")
        let presentation = try #require(presenter.presented.first)
        #expect(presenter.presented.count == 1)
        #expect(presentation.viewController === alert)
        #expect(presentation.animated)
    }
}
#endif
