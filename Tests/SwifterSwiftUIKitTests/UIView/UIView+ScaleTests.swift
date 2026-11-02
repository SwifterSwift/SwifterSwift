// UIView+ScaleTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIViewScaleTests {
    @Test(arguments: [(CGFloat(2), CGFloat(0.5)), (1, 1), (0.25, 3), (-1, 1), (0, 0)])
    func scalesByFactors(_ x: CGFloat, _ y: CGFloat) {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        view.scale(byX: x, y: y)
        #expect(view.transform == CGAffineTransform(scaleX: x, y: y))
        #expect(view.bounds.size == CGSize(width: 20, height: 20))
    }

    @Test
    func changesFrameAroundCenter() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        view.scale(byX: 2, y: 0.5)
        #expect(view.frame == CGRect(x: -10, y: 5, width: 40, height: 10))
    }

    @Test
    func multipliesCurrentScale() {
        let view = UIView()
        view.scale(byX: 2, y: 3)
        view.scale(byX: 2, y: 0.5)
        #expect(view.transform == CGAffineTransform(scaleX: 4, y: 1.5))
    }

    @Test
    func keepsTranslation() {
        let view = UIView()
        view.transform = CGAffineTransform(translationX: 10, y: -5)
        view.scale(byX: 2, y: 2)
        #expect(view.transform == CGAffineTransform(translationX: 10, y: -5).scaledBy(x: 2, y: 2))
        #expect(view.transform.tx == 10)
        #expect(view.transform.ty == -5)
    }

    @Test
    func callsCompletionImmediatelyWhenNotAnimated() {
        let view = UIView()
        var result: Bool?
        view.scale(byX: 2, y: 2) { result = $0 }
        #expect(result == true)
    }

    @Test(.timeLimit(.minutes(5)))
    func setsFinalTransformAndCallsCompletionWhenAnimated() async {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        await withCheckedContinuation { continuation in
            view.scale(byX: 0.5, y: 2, animated: true, duration: 0.05) { _ in continuation.resume() }
            #expect(view.transform == CGAffineTransform(scaleX: 0.5, y: 2))
        }
        #expect(view.transform == CGAffineTransform(scaleX: 0.5, y: 2))
    }
}
#endif
