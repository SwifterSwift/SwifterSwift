//
//  UINavigationBarExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/22/16.
//  Copyright © 2016 SwifterSwift
//

#if canImport(UIKit) && !os(watchOS)
import UIKit

// MARK: - Methods
public extension UINavigationBar {

    /// SwifterSwift: Set Navigation Bar title, title color and font.
    ///
    /// - Parameters:
    ///   - font: title font
    ///   - color: title text color (default is .black).
    func setTitleFont(_ font: UIFont, color: UIColor = .black) {
        var attrs = [NSAttributedString.Key: Any]()
        attrs[.font] = font
        attrs[.foregroundColor] = color
        titleTextAttributes = attrs
    }

    /// SwifterSwift: Make navigation bar transparent.
    ///
    /// - Parameter tint: tint color (default is .white).
    func makeTransparent(withTint tint: UIColor = .white) {
        isTranslucent = true
        backgroundColor = .clear
        barTintColor = .clear
        setBackgroundImage(UIImage(), for: .default)
        tintColor = tint
        titleTextAttributes = [.foregroundColor: tint]
        shadowImage = UIImage()
    }

    /// SwifterSwift: Set navigationBar background and text colors
    ///
    /// - Parameters:
    ///   - background: backgound color
    ///   - text: text color
    func setColors(background: UIColor, text: UIColor) {
        isTranslucent = false
        backgroundColor = background
        barTintColor = background
        setBackgroundImage(UIImage(), for: .default)
        tintColor = text
        titleTextAttributes = [.foregroundColor: text]
    }

}

// MARK: NavigationBar's bottom line
public extension UINavigationBar {
    
    /// Show bottom Border
    func showBottomBorder() {
        if let border = viewWithTag(1234) {
            border.isHidden = false
        } else {
            let bottomBorderRect = CGRect(x: 0, y: frame.height, width: frame.width, height: 1 / UIScreen.main.scale)
            let bottomBorderView = UIView(frame: bottomBorderRect)
            bottomBorderView.tag = 1234
            addSubview(bottomBorderView)
        }
    }
    
    /// Hidden bottom Border
    func hideBottomBorder() {
        if let border = viewWithTag(1234) {
            border.isHidden = true
        }
    }
    
    /// Hidden bottom line
    func hideBottomHairline() {
        let navigationBarImageView = hairlineImageViewInNavigationBar(view: self)
        navigationBarImageView?.isHidden = true
        hideBottomBorder()
    }
    
    /// Show bottom line
    func showBottomHairline() {
        let navigationBarImageView = hairlineImageViewInNavigationBar(view: self)
        navigationBarImageView?.isHidden = true
        showBottomBorder()
    }
    
    
    /// Get Hairline Image View In NavigationBar
    /// - Parameter view: view description
    /// - Returns: description
    private func hairlineImageViewInNavigationBar(view: UIView) -> UIImageView? {
        if let imageView = view as? UIImageView, view.bounds.height <= 1.0 {
            return imageView
        }
        
        for subview in view.subviews {
            if let imageView = hairlineImageViewInNavigationBar(view: subview) {
                return imageView
            }
        }
        return nil
    }
}


#endif
