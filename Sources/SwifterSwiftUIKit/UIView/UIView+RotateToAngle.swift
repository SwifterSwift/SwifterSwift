// UIView+RotateToAngle.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import Foundation
import UIKit

public extension UIView {
    /// SwifterSwift: Rotates the view to the given angle, whatever its current rotation.
    ///
    /// The view's current rotation is read from its `transform`, and the difference to `angle` is added to it, around
    /// the view's center. Any scale or translation the transform already has is kept. A positive angle is clockwise on
    /// screen, and an angle of `0` removes the rotation. The angle can use any `UnitAngle`, such as `.degrees` or
    /// `.radians`.
    ///
    /// When `animated` is `false`, the transform changes at once and `completion` runs before the method returns.
    /// Otherwise the change is animated. UIKit animates between the start and end transforms, so the view turns the
    /// shorter way, and angles a full turn apart look the same.
    ///
    /// ```swift
    /// arrowView.rotate(toAngle: Measurement(value: 45, unit: .degrees))
    /// arrowView.rotate(toAngle: Measurement(value: 90, unit: .degrees))
    /// atan2(arrowView.transform.b, arrowView.transform.a)  // 1.5707963267948966
    /// ```
    ///
    /// - Parameters:
    ///   - angle: The angle the view should be rotated to.
    ///   - animated: Whether to animate the rotation.
    ///   - duration: The duration of the animation, in seconds. It's ignored when `animated` is `false`.
    ///   - completion: A closure to run when the rotation ends. Its argument is `false` if the animation was
    ///     interrupted.
    func rotate(
        toAngle angle: Measurement<UnitAngle>,
        animated: Bool = false,
        duration: TimeInterval = 1,
        completion: ((Bool) -> Void)? = nil
    ) {
        let target = CGFloat(angle.converted(to: .radians).value)
        let rotation = target - atan2(transform.b, transform.a)
        guard animated else {
            transform = transform.rotated(by: rotation)
            completion?(true)
            return
        }
        UIView.animate(
            withDuration: duration,
            animations: { self.transform = self.transform.rotated(by: rotation) },
            completion: completion
        )
    }
}
#endif
