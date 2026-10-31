// UIView+RemoveBlurTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIViewRemoveBlurTests {
    @Test
    func removesEveryBlurView() {
        let view = UIView()
        let first = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        let second = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        view.addSubview(first)
        view.addSubview(second)
        view.removeBlur()
        #expect(view.subviews.isEmpty)
        #expect(first.superview == nil)
        #expect(second.superview == nil)
    }

    @Test
    func keepsOtherSubviews() {
        let view = UIView()
        let label = UILabel()
        let vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: UIBlurEffect(style: .light)))
        let emptyEffectView = UIVisualEffectView(effect: nil)
        view.addSubview(label)
        view.addSubview(UIVisualEffectView(effect: UIBlurEffect(style: .light)))
        view.addSubview(vibrancyView)
        view.addSubview(emptyEffectView)
        view.removeBlur()
        #expect(view.subviews == [label, vibrancyView, emptyEffectView])
    }

    @Test
    func keepsNestedBlurViews() {
        let view = UIView()
        let container = UIView()
        let nestedBlur = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        view.addSubview(container)
        container.addSubview(nestedBlur)
        view.removeBlur()
        #expect(nestedBlur.superview === container)
    }

    @Test
    func doesNothingWithoutSubviews() {
        let view = UIView()
        view.removeBlur()
        #expect(view.subviews.isEmpty)
    }
}
#endif
