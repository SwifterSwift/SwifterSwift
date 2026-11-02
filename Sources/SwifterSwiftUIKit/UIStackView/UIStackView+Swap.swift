// UIStackView+Swap.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import Foundation
import UIKit

public extension UIStackView {
    /// SwifterSwift: Exchanges the positions of two arranged subviews.
    ///
    /// Nothing moves when either view isn't one of the stack view's arranged subviews, or when both are the same
    /// view; `completion` still runs. When `animated` is `true`, the swap and the resulting layout are animated.
    /// Otherwise the views are swapped at once and `completion` runs before the method returns.
    ///
    /// ```swift
    /// let stack = UIStackView(arrangedSubviews: [first, second, third])
    /// stack.swap(first, third)
    /// stack.arrangedSubviews  // [third, second, first]
    /// stack.swap(second, third, animated: true, duration: 0.3)
    /// ```
    ///
    /// - Parameters:
    ///   - view1: The first view to move.
    ///   - view2: The second view to move.
    ///   - animated: Whether to animate the swap.
    ///   - duration: The duration of the animation, in seconds. It's ignored when `animated` is `false`.
    ///   - delay: The delay before the animation starts, in seconds. It's ignored when `animated` is `false`.
    ///   - options: The options of the animation. They're ignored when `animated` is `false`.
    ///   - completion: A closure to run when the swap ends. Its argument is `false` if the animation was interrupted.
    /// - Complexity: O(*n*), where *n* is the number of arranged subviews.
    func swap(
        _ view1: UIView,
        _ view2: UIView,
        animated: Bool = false,
        duration: TimeInterval = 0.25,
        delay: TimeInterval = 0,
        options: UIView.AnimationOptions = .curveLinear,
        completion: ((Bool) -> Void)? = nil
    ) {
        let exchange = {
            guard let index1 = self.arrangedSubviews.firstIndex(where: { $0 === view1 }),
                let index2 = self.arrangedSubviews.firstIndex(where: { $0 === view2 })
            else { return }
            self.removeArrangedSubview(view1)
            self.insertArrangedSubview(view1, at: index2)
            self.removeArrangedSubview(view2)
            self.insertArrangedSubview(view2, at: index1)
        }
        guard animated else {
            exchange()
            completion?(true)
            return
        }
        UIView.animate(
            withDuration: duration,
            delay: delay,
            options: options,
            animations: {
                exchange()
                self.layoutIfNeeded()
            },
            completion: completion
        )
    }
}
#endif
