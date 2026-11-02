// UIViewController+PresentPopoverTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS) && !os(tvOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIViewControllerPresentPopoverTests {
    final class PopoverDelegate: NSObject, UIPopoverPresentationControllerDelegate {
        func adaptivePresentationStyle(
            for controller: UIPresentationController,
            traitCollection: UITraitCollection
        ) -> UIModalPresentationStyle {
            .none
        }
    }

    /// Records the popover's configuration when it's asked to present, instead of presenting, so it needs no window.
    final class RecordingPresenter: UIViewController {
        struct Presentation {
            var viewController: UIViewController
            var animated: Bool
            var sourceView: UIView?
            var sourceRect: CGRect?
            var delegate: (any UIPopoverPresentationControllerDelegate)?
        }

        var presented: [Presentation] = []

        override func present(
            _ viewControllerToPresent: UIViewController,
            animated flag: Bool,
            completion: (() -> Void)? = nil
        ) {
            let popover = viewControllerToPresent.popoverPresentationController
            presented.append(
                Presentation(
                    viewController: viewControllerToPresent,
                    animated: flag,
                    sourceView: popover?.sourceView,
                    sourceRect: popover?.sourceRect,
                    delegate: popover?.delegate
                )
            )
            completion?()
        }
    }

    @Test
    func presentsPopoverAnchoredToSourcePoint() throws {
        let presenter = RecordingPresenter()
        let content = UIViewController()
        let delegate = PopoverDelegate()
        presenter.presentPopover(content, sourcePoint: CGPoint(x: 40, y: 60), delegate: delegate, animated: false)
        let presentation = try #require(presenter.presented.first)
        #expect(presenter.presented.count == 1)
        #expect(presentation.viewController === content)
        #expect(!presentation.animated)
        #expect(content.modalPresentationStyle == .popover)
        #expect(presentation.sourceView === presenter.view)
        #expect(presentation.sourceRect == CGRect(x: 40, y: 60, width: 0, height: 0))
        #expect(presentation.delegate === delegate)
    }

    @Test
    func animatesByDefaultWithoutDelegate() throws {
        let presenter = RecordingPresenter()
        presenter.presentPopover(UIViewController(), sourcePoint: .zero)
        let presentation = try #require(presenter.presented.first)
        #expect(presentation.animated)
        #expect(presentation.delegate == nil)
        #expect(presentation.sourceRect == .zero)
    }

    @Test
    func setsPreferredContentSize() {
        let content = UIViewController()
        RecordingPresenter().presentPopover(content, sourcePoint: .zero, size: CGSize(width: 300, height: 200))
        #expect(content.preferredContentSize == CGSize(width: 300, height: 200))
    }

    @Test
    func keepsPreferredContentSizeWithoutSize() {
        let content = UIViewController()
        content.preferredContentSize = CGSize(width: 120, height: 80)
        RecordingPresenter().presentPopover(content, sourcePoint: .zero)
        #expect(content.preferredContentSize == CGSize(width: 120, height: 80))
    }

    @Test
    func acceptsPointsOutsideTheView() throws {
        let presenter = RecordingPresenter()
        presenter.presentPopover(UIViewController(), sourcePoint: CGPoint(x: -500, y: 10_000))
        let presentation = try #require(presenter.presented.first)
        #expect(presentation.sourceRect?.origin == CGPoint(x: -500, y: 10_000))
    }

    @Test
    func callsCompletionAfterPresenting() {
        let presenter = RecordingPresenter()
        var completionCalls = 0
        presenter.presentPopover(UIViewController(), sourcePoint: .zero) {
            completionCalls += 1
        }
        #expect(completionCalls == 1)
    }
}
#endif
