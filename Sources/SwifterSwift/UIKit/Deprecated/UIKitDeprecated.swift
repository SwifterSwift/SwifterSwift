// UIKitDeprecated.swift - Copyright 2021 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

public extension UIView {
    /// SwifterSwift: Angle units.
    ///
    /// - degrees: degrees.
    /// - radians: radians.
    @available(*, deprecated, message: "Use UnitAngle instead.")
    enum AngleUnit {
        /// SwifterSwift: degrees.
        case degrees

        /// SwifterSwift: radians.
        case radians
    }

    /// SwifterSwift: Rotate view by angle on relative axis.
    ///
    /// - Parameters:
    ///   - angle: Angle to rotate view by.
    ///   - type: Type of the rotation angle.
    ///   - animated: Set `true` to animate rotation (default is `false`).
    ///   - duration: Animation duration in seconds (default is `1` second).
    ///   - completion: Optional completion handler to run with animation finishes (default is `nil`).
    @available(*, deprecated, message: "Use rotate(by:animated:duration:completion:) instead.")
    func rotate(
        byAngle angle: CGFloat,
        ofType type: AngleUnit,
        animated: Bool = false,
        duration: TimeInterval = 1,
        completion: ((Bool) -> Void)? = nil) {
        let angleWithType = (type == .degrees) ? .pi * angle / 180.0 : angle
        let aDuration = animated ? duration : 0
        UIView.animate(withDuration: aDuration, delay: 0, options: .curveLinear, animations: { () -> Void in
            self.transform = self.transform.rotated(by: angleWithType)
        }, completion: completion)
    }

    /// SwifterSwift: Rotate view to angle on fixed axis.
    ///
    /// - Parameters:
    ///   - angle: Angle to rotate view to.
    ///   - type: Type of the rotation angle.
    ///   - animated: Set `true` to animate rotation (default is `false`).
    ///   - duration: Animation duration in seconds (default is `1` second).
    ///   - completion: Optional completion handler to run with animation finishes (default is `nil`).
    @available(*, deprecated, message: "Use rotate(by:animated:duration:completion:) instead.")
    func rotate(
        toAngle angle: CGFloat,
        ofType type: AngleUnit,
        animated: Bool = false,
        duration: TimeInterval = 1,
        completion: ((Bool) -> Void)? = nil) {
        let angleWithType = (type == .degrees) ? .pi * angle / 180.0 : angle
        let aDuration = animated ? duration : 0
        UIView.animate(withDuration: aDuration, animations: {
            self.transform = self.transform.concatenating(CGAffineTransform(rotationAngle: angleWithType))
        }, completion: completion)
    }
}
#endif
