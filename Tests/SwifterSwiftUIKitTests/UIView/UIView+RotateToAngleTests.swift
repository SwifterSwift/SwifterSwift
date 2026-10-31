// UIView+RotateToAngleTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import Foundation
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIViewRotateToAngleTests {
    @Test(
        arguments: [
            (Measurement(value: 1, unit: .radians), 1),
            (Measurement(value: 90, unit: .degrees), CGFloat.pi / 2),
            (Measurement(value: -30, unit: .degrees), -CGFloat.pi / 6),
            (Measurement(value: 0.5, unit: .revolutions), CGFloat.pi)
        ] as [(Measurement<UnitAngle>, CGFloat)]
    )
    func rotatesToAngleInAnyUnit(_ angle: Measurement<UnitAngle>, _ radians: CGFloat) {
        let view = UIView()
        view.transform = CGAffineTransform(rotationAngle: 0.3)
        view.rotate(toAngle: angle)
        let expected = CGAffineTransform(rotationAngle: radians)
        #expect(abs(view.transform.a - expected.a) < 1e-12)
        #expect(abs(view.transform.b - expected.b) < 1e-12)
        #expect(abs(view.transform.c - expected.c) < 1e-12)
        #expect(abs(view.transform.d - expected.d) < 1e-12)
    }

    @Test
    func ignoresCurrentRotation() {
        let view = UIView()
        view.rotate(toAngle: Measurement(value: 45, unit: .degrees))
        view.rotate(toAngle: Measurement(value: 90, unit: .degrees))
        #expect(abs(atan2(view.transform.b, view.transform.a) - .pi / 2) < 1e-12)
        view.rotate(toAngle: Measurement(value: 90, unit: .degrees))
        #expect(abs(atan2(view.transform.b, view.transform.a) - .pi / 2) < 1e-12)
    }

    @Test
    func zeroAngleRemovesRotation() {
        let view = UIView()
        view.transform = CGAffineTransform(rotationAngle: 1.2)
        view.rotate(toAngle: Measurement(value: 0, unit: .degrees))
        #expect(abs(view.transform.a - 1) < 1e-12)
        #expect(abs(view.transform.b) < 1e-12)
        #expect(abs(view.transform.c) < 1e-12)
        #expect(abs(view.transform.d - 1) < 1e-12)
    }

    @Test
    func keepsScaleAndTranslation() {
        let view = UIView()
        view.transform = CGAffineTransform(translationX: 10, y: 20).scaledBy(x: 3, y: 3).rotated(by: 0.4)
        view.rotate(toAngle: Measurement(value: -90, unit: .degrees))
        #expect(abs(hypot(view.transform.a, view.transform.b) - 3) < 1e-12)
        #expect(view.transform.tx == 10)
        #expect(view.transform.ty == 20)
        #expect(abs(atan2(view.transform.b, view.transform.a) + .pi / 2) < 1e-12)
    }

    @Test
    func callsCompletionImmediatelyWhenNotAnimated() {
        let view = UIView()
        var result: Bool?
        view.rotate(toAngle: Measurement(value: 30, unit: .degrees)) { result = $0 }
        #expect(result == true)
    }

    @Test(.timeLimit(.minutes(1)))
    func setsFinalTransformAndCallsCompletionWhenAnimated() async {
        let view = UIView()
        view.transform = CGAffineTransform(rotationAngle: 1)
        await withCheckedContinuation { continuation in
            view.rotate(toAngle: Measurement(value: 2, unit: .radians), animated: true, duration: 0.05) { _ in
                continuation.resume()
            }
        }
        #expect(abs(atan2(view.transform.b, view.transform.a) - 2) < 1e-12)
    }
}
#endif
