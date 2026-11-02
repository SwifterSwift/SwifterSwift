// UIView+ShakeTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import Foundation
import QuartzCore
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIViewShakeTests {
    @Test
    func addsHorizontalAdditiveKeyframeAnimationByDefault() throws {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        view.shake()
        let animation = try #require(view.layer.animation(forKey: "shake") as? CAKeyframeAnimation)
        let values = try #require(animation.values as? [NSNumber])
        #expect(animation.keyPath == "transform.translation.x")
        #expect(values.map(\.doubleValue) == [-20, 20, -20, 20, -10, 10, -5, 5, 0])
        #expect(animation.duration == 1)
        #expect(animation.isAdditive)
    }

    @Test
    func shakesVertically() throws {
        let view = UIView()
        view.shake(direction: .vertical)
        let animation = try #require(view.layer.animation(forKey: "shake") as? CAKeyframeAnimation)
        #expect(animation.keyPath == "transform.translation.y")
    }

    @Test(arguments: [0, 8, 50.5])
    func scalesMovementByAmplitude(_ amplitude: CGFloat) throws {
        let view = UIView()
        view.shake(amplitude: amplitude, duration: 0.4)
        let animation = try #require(view.layer.animation(forKey: "shake") as? CAKeyframeAnimation)
        let values = try #require(animation.values as? [NSNumber])
        let expected = [-1, 1, -1, 1, -0.5, 0.5, -0.25, 0.25, 0].map { $0 * amplitude }
        #expect(values.map { CGFloat($0.doubleValue) } == expected)
        #expect(animation.duration == 0.4)
    }

    @Test(arguments: [CAMediaTimingFunctionName.linear, .easeIn, .easeOut, .easeInEaseOut, .default])
    func usesTimingFunction(_ name: CAMediaTimingFunctionName) throws {
        let view = UIView()
        view.shake(timingFunction: name)
        let animation = try #require(view.layer.animation(forKey: "shake") as? CAKeyframeAnimation)
        let actual = try #require(animation.timingFunction)
        let expected = CAMediaTimingFunction(name: name)
        for index in 0..<4 {
            var actualPoint: [Float] = [0, 0]
            var expectedPoint: [Float] = [0, 0]
            actual.getControlPoint(at: index, values: &actualPoint)
            expected.getControlPoint(at: index, values: &expectedPoint)
            #expect(actualPoint == expectedPoint)
        }
    }

    @Test
    func leavesFrameAndTransformUnchanged() {
        let view = UIView(frame: CGRect(x: 10, y: 20, width: 100, height: 40))
        view.transform = CGAffineTransform(translationX: 5, y: 0)
        let frame = view.frame
        view.shake()
        #expect(view.frame == frame)
        #expect(view.transform == CGAffineTransform(translationX: 5, y: 0))
    }

    @Test
    func restartsRunningShake() {
        let view = UIView()
        view.shake()
        view.shake(direction: .vertical)
        #expect(view.layer.animationKeys() == ["shake"])
        #expect((view.layer.animation(forKey: "shake") as? CAKeyframeAnimation)?.keyPath == "transform.translation.y")
    }

    @Test(.timeLimit(.minutes(5)))
    func callsCompletionWhenAnimationEnds() async {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        let start = ContinuousClock.now
        await withCheckedContinuation { continuation in
            view.shake(duration: 0.05) { continuation.resume() }
        }
        #expect(ContinuousClock.now - start >= .milliseconds(40))
    }
}
#endif
