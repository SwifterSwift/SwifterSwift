// UIView+RotateByAngleTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import Foundation
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIViewRotateByAngleTests {
    @Test(
        arguments: [
            (Measurement(value: 1, unit: .radians), 1),
            (Measurement(value: 90, unit: .degrees), CGFloat.pi / 2),
            (Measurement(value: -45, unit: .degrees), -CGFloat.pi / 4),
            (Measurement(value: 0.25, unit: .revolutions), CGFloat.pi / 2),
            (Measurement(value: 100, unit: .gradians), CGFloat.pi / 2),
            (Measurement(value: 0, unit: .degrees), 0)
        ] as [(Measurement<UnitAngle>, CGFloat)]
    )
    func rotatesByAngleInAnyUnit(_ angle: Measurement<UnitAngle>, _ radians: CGFloat) {
        let view = UIView()
        view.rotate(byAngle: angle)
        let expected = CGAffineTransform(rotationAngle: radians)
        #expect(abs(view.transform.a - expected.a) < 1e-12)
        #expect(abs(view.transform.b - expected.b) < 1e-12)
        #expect(abs(view.transform.c - expected.c) < 1e-12)
        #expect(abs(view.transform.d - expected.d) < 1e-12)
    }

    @Test
    func addsToCurrentRotation() {
        let view = UIView()
        view.rotate(byAngle: Measurement(value: 1, unit: .radians))
        view.rotate(byAngle: Measurement(value: 1, unit: .radians))
        #expect(abs(atan2(view.transform.b, view.transform.a) - 2) < 1e-12)
    }

    @Test
    func keepsScaleAndTranslation() {
        let view = UIView()
        view.transform = CGAffineTransform(translationX: 10, y: 20).scaledBy(x: 2, y: 2)
        view.rotate(byAngle: Measurement(value: 90, unit: .degrees))
        #expect(abs(hypot(view.transform.a, view.transform.b) - 2) < 1e-12)
        #expect(view.transform.tx == 10)
        #expect(view.transform.ty == 20)
        #expect(abs(atan2(view.transform.b, view.transform.a) - .pi / 2) < 1e-12)
    }

    @Test
    func keepsBoundsAndCenter() {
        let view = UIView(frame: CGRect(x: 10, y: 10, width: 40, height: 20))
        view.rotate(byAngle: Measurement(value: 90, unit: .degrees))
        #expect(view.bounds.size == CGSize(width: 40, height: 20))
        #expect(view.center == CGPoint(x: 30, y: 20))
    }

    @Test
    func callsCompletionImmediatelyWhenNotAnimated() {
        let view = UIView()
        var result: Bool?
        view.rotate(byAngle: Measurement(value: 30, unit: .degrees)) { result = $0 }
        #expect(result == true)
    }

    @Test(.timeLimit(.minutes(5)))
    func setsFinalTransformAndCallsCompletionWhenAnimated() async {
        let view = UIView()
        await withCheckedContinuation { continuation in
            view.rotate(byAngle: Measurement(value: 2, unit: .radians), animated: true, duration: 0.05) { _ in
                continuation.resume()
            }
            #expect(abs(atan2(view.transform.b, view.transform.a) - 2) < 1e-12)
        }
        #expect(abs(atan2(view.transform.b, view.transform.a) - 2) < 1e-12)
    }
}
#endif
