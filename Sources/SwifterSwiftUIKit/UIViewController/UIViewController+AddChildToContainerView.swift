// UIViewController+AddChildToContainerView.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

public extension UIViewController {
    /// SwifterSwift: Adds a child view controller and pins its view to the edges of a container view.
    ///
    /// This performs the full containment sequence: `addChild(_:)`, adding the child's view as a subview of
    /// `containerView`, then `didMove(toParent:)`. The child's view gets Auto Layout constraints to all four edges of
    /// the container, so it always fills it, and the container can size itself from the child's content.
    ///
    /// The container view should be this view controller's view or one of its descendants. Undo it with
    /// `removeViewAndControllerFromParent()`.
    ///
    /// ```swift
    /// let player = PlayerViewController()
    /// addChild(player, toContainerView: playerContainer)
    /// children.contains(player)  // true
    /// player.view.superview === playerContainer  // true
    /// ```
    ///
    /// - Parameters:
    ///   - child: The view controller to add as a child.
    ///   - containerView: The view that hosts the child's view.
    func addChild(_ child: UIViewController, toContainerView containerView: UIView) {
        addChild(child)
        let childView: UIView = child.view
        childView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(childView)
        NSLayoutConstraint.activate([
            childView.topAnchor.constraint(equalTo: containerView.topAnchor),
            childView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            childView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            childView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
        child.didMove(toParent: self)
    }
}
#endif
