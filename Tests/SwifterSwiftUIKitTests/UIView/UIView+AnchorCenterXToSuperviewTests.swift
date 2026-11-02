// UIView+AnchorCenterXToSuperviewTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIViewAnchorCenterXToSuperviewTests {
    @Test(arguments: [0, 10, -25])
    func centersHorizontallyWithOffset(_ constant: CGFloat) throws {
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        let view = UIView()
        container.addSubview(view)
        let constraint = try #require(view.anchorCenterXToSuperview(constant: constant))
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 20),
            view.heightAnchor.constraint(equalToConstant: 20),
            view.topAnchor.constraint(equalTo: container.topAnchor)
        ])
        container.layoutIfNeeded()
        #expect(view.frame.midX == 100 + constant)
        #expect(constraint.isActive)
        #expect(constraint.constant == constant)
        #expect(constraint.firstAttribute == .centerX)
        #expect(!view.translatesAutoresizingMaskIntoConstraints)
    }

    @Test
    func keepsCenterInRightToLeftLayout() throws {
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        container.semanticContentAttribute = .forceRightToLeft
        let view = UIView()
        container.addSubview(view)
        _ = try #require(view.anchorCenterXToSuperview(constant: 10))
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 20),
            view.heightAnchor.constraint(equalToConstant: 20),
            view.topAnchor.constraint(equalTo: container.topAnchor)
        ])
        container.layoutIfNeeded()
        #expect(view.frame.midX == 110)
    }

    @Test
    func returnsNilWithoutSuperview() {
        let view = UIView()
        #expect(view.anchorCenterXToSuperview() == nil)
        #expect(view.translatesAutoresizingMaskIntoConstraints)
        #expect(view.constraints.isEmpty)
    }
}
#endif
