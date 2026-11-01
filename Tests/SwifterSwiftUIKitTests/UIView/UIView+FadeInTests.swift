// UIView+FadeInTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIViewFadeInTests {
    @Test(.timeLimit(.minutes(5)))
    func showsHiddenViewAndCallsCompletion() async {
        let view = UIView()
        view.isHidden = true
        await withCheckedContinuation { continuation in
            view.fadeIn(duration: 0.05) { _ in continuation.resume() }
            #expect(!view.isHidden)
            #expect(view.alpha == 1)
        }
        #expect(!view.isHidden)
        #expect(view.alpha == 1)
    }

    @Test
    func startsHiddenViewFromTransparent() {
        final class AlphaRecordingView: UIView {
            var alphaValues: [CGFloat] = []
            override var alpha: CGFloat {
                didSet { alphaValues.append(alpha) }
            }
        }
        let view = AlphaRecordingView()
        view.isHidden = true
        view.alphaValues = []
        view.fadeIn(duration: 0)
        #expect(view.alphaValues == [0, 1])
    }

    @Test
    func fadesVisibleViewFromCurrentAlpha() {
        final class AlphaRecordingView: UIView {
            var alphaValues: [CGFloat] = []
            override var alpha: CGFloat {
                didSet { alphaValues.append(alpha) }
            }
        }
        let view = AlphaRecordingView()
        view.alpha = 0.3
        view.alphaValues = []
        view.fadeIn(duration: 0)
        #expect(view.alphaValues == [1])
        #expect(!view.isHidden)
    }

    @Test(.timeLimit(.minutes(5)))
    func completesForViewThatIsAlreadyVisible() async {
        let view = UIView()
        await withCheckedContinuation { continuation in
            view.fadeIn(duration: 0) { _ in continuation.resume() }
        }
        #expect(view.alpha == 1)
    }
}
#endif
