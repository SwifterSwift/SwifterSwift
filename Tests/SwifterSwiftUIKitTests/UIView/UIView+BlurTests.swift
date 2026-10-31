// UIView+BlurTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIViewBlurTests {
    @Test
    func addsBlurViewThatFillsBounds() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 100))
        view.addSubview(UILabel())
        let blurView = view.blur(withStyle: .dark)
        #expect(view.subviews.last === blurView)
        #expect(blurView.effect is UIBlurEffect)
        #expect(blurView.frame == view.bounds)
        #expect(blurView.autoresizingMask == [.flexibleWidth, .flexibleHeight])
    }

    @Test
    func resizesWithTheView() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 100))
        let blurView = view.blur()
        view.frame.size = CGSize(width: 80, height: 40)
        view.layoutIfNeeded()
        #expect(blurView.frame == view.bounds)
    }

    @Test
    func reusesBlurViewOnRepeatedCalls() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 100))
        let first = view.blur(withStyle: .light)
        let firstEffect = first.effect
        let second = view.blur(withStyle: .dark)
        #expect(first === second)
        #expect(view.subviews.count { $0 is UIVisualEffectView } == 1)
        #expect(second.effect is UIBlurEffect)
        #expect(second.effect !== firstEffect)
    }

    @Test
    func ignoresVisualEffectViewsWithOtherEffects() {
        let view = UIView()
        let vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: UIBlurEffect(style: .light)))
        view.addSubview(vibrancyView)
        let blurView = view.blur()
        #expect(blurView !== vibrancyView)
        #expect(view.subviews == [vibrancyView, blurView])
    }

    @Test
    func doesNotChangeClipping() {
        let view = UIView()
        view.blur()
        #expect(!view.clipsToBounds)
    }

    @Test
    func worksForZeroSizeView() {
        let view = UIView()
        let blurView = view.blur()
        #expect(blurView.frame == .zero)
        #expect(blurView.superview === view)
    }
}
#endif
