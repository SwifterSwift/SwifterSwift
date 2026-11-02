// UIView+AddBottomSeparator.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import QuartzCore
import UIKit

public extension UIView {
    /// SwifterSwift: Adds a horizontal line along the bottom edge of the view, inside its bounds.
    ///
    /// The line is a new subview, pinned with Auto Layout to the view's leading and trailing edges and placed `spacing`
    /// points above its bottom edge. Its ends are rounded with a corner radius of half its height. A dynamic color,
    /// like the default `.separator`, follows the appearance. Each call adds another line.
    ///
    /// ```swift
    /// let cell = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 44))
    /// let line = cell.addBottomSeparator(color: .lightGray, height: 1, spacing: 4)
    /// cell.layoutIfNeeded()
    /// line.frame  // (0.0, 39.0, 320.0, 1.0)
    /// ```
    ///
    /// - Parameters:
    ///   - color: The color of the line.
    ///   - height: The thickness of the line, in points.
    ///   - spacing: The distance between the bottom of the line and the bottom edge of the view, in points.
    /// - Returns: The view that draws the line.
    @discardableResult
    func addBottomSeparator(color: UIColor = .separator, height: CGFloat = 1, spacing: CGFloat = 0) -> UIView {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = color
        line.layer.cornerRadius = height / 2
        addSubview(line)
        NSLayoutConstraint.activate([
            line.heightAnchor.constraint(equalToConstant: height),
            line.leadingAnchor.constraint(equalTo: leadingAnchor),
            line.trailingAnchor.constraint(equalTo: trailingAnchor),
            line.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -spacing)
        ])
        return line
    }
}
#endif
