// UIView+AnchorCenterSuperviewTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIViewAnchorCenterSuperviewTests {
    @Test
    func centersViewInSuperview() {
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        let view = UIView()
        container.addSubview(view)
        let constraints = view.anchorCenterSuperview()
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 20),
            view.heightAnchor.constraint(equalToConstant: 10)
        ])
        container.layoutIfNeeded()
        #expect(view.frame == CGRect(x: 90, y: 45, width: 20, height: 10))
        #expect(constraints.map(\.firstAttribute) == [.centerX, .centerY])
        #expect(constraints.allSatisfy { $0.isActive && $0.constant == 0 })
        #expect(!view.translatesAutoresizingMaskIntoConstraints)
    }

    @Test
    func returnsEmptyArrayWithoutSuperview() {
        let view = UIView()
        #expect(view.anchorCenterSuperview().isEmpty)
        #expect(view.translatesAutoresizingMaskIntoConstraints)
        #expect(view.constraints.isEmpty)
    }
}
#endif
