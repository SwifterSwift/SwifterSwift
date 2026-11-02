// UISlider+SetValueDurationTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS) && !os(tvOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UISliderSetValueDurationTests {
    func makeSlider() -> UISlider {
        let slider = UISlider(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        slider.minimumValue = 0
        slider.maximumValue = 100
        return slider
    }

    /// UISlider stores its value with a little floating-point error, so compare with a tolerance.
    func isClose(_ value: Float, to expected: Float) -> Bool {
        abs(value - expected) < 0.001
    }

    @Test
    func setsValueAndCallsCompletionImmediatelyWhenNotAnimated() {
        let slider = makeSlider()
        var completionCalls = 0
        slider.setValue(42, animated: false, duration: 5) {
            completionCalls += 1
        }
        #expect(isClose(slider.value, to: 42))
        #expect(completionCalls == 1)
    }

    @Test
    func callsCompletionAfterAnimationWithNewValue() async {
        let slider = makeSlider()
        var completionCalls = 0
        await withCheckedContinuation { continuation in
            slider.setValue(90, duration: 0.05) {
                completionCalls += 1
                continuation.resume()
            }
            #expect(completionCalls == 0)
        }
        #expect(completionCalls == 1)
        #expect(isClose(slider.value, to: 90))
    }

    @Test(
        arguments: [(150, 100), (-20, 0), (.greatestFiniteMagnitude, 100), (-.greatestFiniteMagnitude, 0)]
            as [(Float, Float)])
    func clampsValueToRange(_ value: Float, _ expected: Float) {
        let slider = makeSlider()
        slider.setValue(value, animated: false, duration: 0)
        #expect(isClose(slider.value, to: expected))
    }

    @Test
    func keepsValueInRangeForNaN() {
        let slider = makeSlider()
        slider.setValue(.nan, animated: false, duration: 0)
        #expect((0...100).contains(slider.value))
    }

    @Test(arguments: [0, -1] as [TimeInterval])
    func completesWithZeroAndNegativeDurations(_ duration: TimeInterval) async {
        let slider = makeSlider()
        await withCheckedContinuation { continuation in
            slider.setValue(10, duration: duration) {
                continuation.resume()
            }
        }
        #expect(isClose(slider.value, to: 10))
    }

    @Test
    func worksWithoutCompletion() {
        let slider = makeSlider()
        slider.setValue(30, animated: false, duration: 0)
        #expect(isClose(slider.value, to: 30))
    }

    @Test
    func doesNotSendValueChangedActions() {
        let slider = makeSlider()
        var actionCalls = 0
        slider.addAction(UIAction { _ in actionCalls += 1 }, for: .valueChanged)
        slider.setValue(55, animated: false, duration: 0)
        #expect(isClose(slider.value, to: 55))
        #expect(actionCalls == 0)
    }
}
#endif
