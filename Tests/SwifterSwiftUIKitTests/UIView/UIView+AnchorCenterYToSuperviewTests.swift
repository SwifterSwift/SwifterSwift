// UIView+AnchorCenterYToSuperviewTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIViewAnchorCenterYToSuperviewTests {
    @Test(arguments: [0, 10, -25])
    func centersVerticallyWithOffset(_ constant: CGFloat) throws {
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        let view = UIView()
        container.addSubview(view)
        let constraint = try #require(view.anchorCenterYToSuperview(constant: constant))
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 20),
            view.heightAnchor.constraint(equalToConstant: 20),
            view.leadingAnchor.constraint(equalTo: container.leadingAnchor)
        ])
        container.layoutIfNeeded()
        #expect(view.frame.midY == 50 + constant)
        #expect(constraint.isActive)
        #expect(constraint.constant == constant)
        #expect(constraint.firstAttribute == .centerY)
        #expect(!view.translatesAutoresizingMaskIntoConstraints)
    }

    @Test
    func returnsNilWithoutSuperview() {
        let view = UIView()
        #expect(view.anchorCenterYToSuperview() == nil)
        #expect(view.translatesAutoresizingMaskIntoConstraints)
        #expect(view.constraints.isEmpty)
    }
}
#endif
