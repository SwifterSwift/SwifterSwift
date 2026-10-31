// UIView+RotateByAngle.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import Foundation
import UIKit

public extension UIView {
    /// SwifterSwift: Rotates the view by the given angle, relative to its current rotation.
    ///
    /// The rotation is added to the view's `transform`, around its center, and keeps any scale or translation the
    /// transform already has. A positive angle rotates clockwise on screen. The angle can use any `UnitAngle`, such as
    /// `.degrees` or `.radians`.
    ///
    /// When `animated` is `false`, the transform changes at once and `completion` runs before the method returns.
    /// Otherwise the change is animated with a linear curve. UIKit animates between the start and end transforms, so an
    /// animated rotation of a full turn or more doesn't spin the view; use a `CABasicAnimation` on
    /// `transform.rotation.z` for that.
    ///
    /// ```swift
    /// arrowView.rotate(byAngle: Measurement(value: 90, unit: .degrees))
    /// arrowView.rotate(byAngle: Measurement(value: .pi / 2, unit: .radians))
    /// atan2(arrowView.transform.b, arrowView.transform.a)  // 3.141592653589793
    ///
    /// arrowView.rotate(byAngle: Measurement(value: -45, unit: .degrees), animated: true, duration: 0.3)
    /// ```
    ///
    /// - Parameters:
    ///   - angle: The angle to rotate the view by.
    ///   - animated: Whether to animate the rotation.
    ///   - duration: The duration of the animation, in seconds. It's ignored when `animated` is `false`.
    ///   - completion: A closure to run when the rotation ends. Its argument is `false` if the animation was
    ///     interrupted.
    func rotate(
        byAngle angle: Measurement<UnitAngle>,
        animated: Bool = false,
        duration: TimeInterval = 1,
        completion: ((Bool) -> Void)? = nil
    ) {
        let radians = CGFloat(angle.converted(to: .radians).value)
        guard animated else {
            transform = transform.rotated(by: radians)
            completion?(true)
            return
        }
        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: .curveLinear,
            animations: { self.transform = self.transform.rotated(by: radians) },
            completion: completion
        )
    }
}
#endif
