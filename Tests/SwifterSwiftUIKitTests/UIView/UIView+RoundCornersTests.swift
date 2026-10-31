// UIView+RoundCornersTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import QuartzCore
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIViewRoundCornersTests {
    @Test(
        arguments: [
            (.topLeft, .layerMinXMinYCorner),
            (.topRight, .layerMaxXMinYCorner),
            (.bottomLeft, .layerMinXMaxYCorner),
            (.bottomRight, .layerMaxXMaxYCorner),
            ([.topLeft, .topRight], [.layerMinXMinYCorner, .layerMaxXMinYCorner]),
            ([.bottomLeft, .bottomRight], [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]),
            ([.topLeft, .bottomRight], [.layerMinXMinYCorner, .layerMaxXMaxYCorner]),
            (.allCorners, [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]),
            ([], [])
        ] as [(UIRectCorner, CACornerMask)]
    )
    func mapsCornersToMaskedCorners(_ corners: UIRectCorner, _ maskedCorners: CACornerMask) {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        view.roundCorners(corners, radius: 12)
        #expect(view.layer.maskedCorners == maskedCorners)
        #expect(view.layer.cornerRadius == 12)
    }

    @Test
    func replacesTheCornersOfAnEarlierCall() {
        let view = UIView()
        view.roundCorners(.allCorners, radius: 20)
        view.roundCorners(.bottomLeft, radius: 4)
        #expect(view.layer.maskedCorners == .layerMinXMaxYCorner)
        #expect(view.layer.cornerRadius == 4)
    }

    @Test(arguments: [CGFloat(-5), -.infinity, -.leastNonzeroMagnitude, .nan, 0])
    func treatsNegativeAndNaNRadiusesAsZero(_ radius: CGFloat) {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.roundCorners(.allCorners, radius: radius)
        #expect(view.layer.cornerRadius == 0)
    }

    @Test
    func leavesTheMaskAndClippingAlone() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let mask = CALayer()
        view.layer.mask = mask
        view.layer.shadowOpacity = 0.5
        view.roundCorners([.topLeft], radius: 10)
        #expect(view.layer.mask === mask)
        #expect(!view.clipsToBounds)
        #expect(view.layer.shadowOpacity == 0.5)

        let clippingView = UIView()
        clippingView.clipsToBounds = true
        clippingView.roundCorners(.allCorners, radius: 10)
        #expect(clippingView.clipsToBounds)
    }

    @Test
    func keepsTheCornersWhenTheSizeChanges() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        view.roundCorners([.topRight, .bottomRight], radius: 6)
        view.frame = CGRect(x: 10, y: 10, width: 60, height: 30)
        view.bounds.size = CGSize(width: 200, height: 5)
        #expect(view.layer.maskedCorners == [.layerMaxXMinYCorner, .layerMaxXMaxYCorner])
        #expect(view.layer.cornerRadius == 6)
        #expect(view.layer.mask == nil)
    }

    @Test
    func passesRadiusesLargerThanTheViewThrough() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        view.roundCorners(.allCorners, radius: 1000)
        #expect(view.layer.cornerRadius == 1000)
    }
}
#endif
