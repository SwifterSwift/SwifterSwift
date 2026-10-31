// UIView+FadeOutTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIViewFadeOutTests {
    @Test(.timeLimit(.minutes(1)))
    func fadesOutThenHidesView() async {
        let view = UIView()
        await withCheckedContinuation { continuation in
            view.fadeOut(duration: 0.05) { _ in
                #expect(view.isHidden)
                continuation.resume()
            }
            #expect(view.alpha == 0)
            #expect(!view.isHidden)
        }
        #expect(view.isHidden)
        #expect(view.alpha == 0)
    }

    @Test(.timeLimit(.minutes(1)))
    func neverShowsHiddenView() async {
        final class HiddenRecordingView: UIView {
            var hiddenValues: [Bool] = []
            override var isHidden: Bool {
                didSet { hiddenValues.append(isHidden) }
            }
        }
        let view = HiddenRecordingView()
        view.isHidden = true
        view.hiddenValues = []
        await withCheckedContinuation { continuation in
            view.fadeOut(duration: 0.05) { _ in continuation.resume() }
        }
        #expect(view.isHidden)
        #expect(!view.hiddenValues.contains(false))
    }

    @Test(.timeLimit(.minutes(1)))
    func doesNotHideViewWhoseAlphaChangedAgain() async {
        let view = UIView()
        await withCheckedContinuation { continuation in
            view.fadeOut(duration: 0.05) { _ in continuation.resume() }
            view.alpha = 1
        }
        #expect(!view.isHidden)
        #expect(view.alpha == 1)
    }

    @Test(.timeLimit(.minutes(1)))
    func fadeInBeforeCompletionKeepsViewVisible() async {
        let view = UIView()
        await withCheckedContinuation { continuation in
            view.fadeOut(duration: 0.05) { _ in continuation.resume() }
            view.fadeIn(duration: 0.05)
        }
        #expect(!view.isHidden)
        #expect(view.alpha == 1)
    }
}
#endif
