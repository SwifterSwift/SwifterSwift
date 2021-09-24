// UINavigationBarExtensions.swift - Copyright 2020 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

// MARK: - Methods

public extension UINavigationBar {
    /// SwifterSwift: Set Navigation Bar title, title color and font.
    ///
    /// - Parameters:
    ///   - font: title font.
    ///   - color: title text color (default is .black).
    func setTitleFont(_ font: UIFont, color: UIColor = .black) {
        var attrs = [NSAttributedString.Key: Any]()
        attrs[.font] = font
        attrs[.foregroundColor] = color
        if #available(iOS 13.0, *) {
            let standardApp = standardAppearance
            standardApp.titleTextAttributes = attrs
            standardAppearance = standardApp
            if let scrollApp = scrollEdgeAppearance {
                scrollApp.titleTextAttributes = attrs
                scrollEdgeAppearance = scrollApp
            }
        }else{
            titleTextAttributes = attrs
        }
    }

    /// SwifterSwift: Make navigation bar transparent.
    ///
    /// - Parameter tint: tint color (default is .white).
    func makeTransparent(withTint tint: UIColor = .white) {
        isTranslucent = true
        if #available(iOS 13.0, *) {
            standardAppearance.configureWithTransparentBackground()
            scrollEdgeAppearance?.configureWithTransparentBackground()
        }else{
            backgroundColor = .clear
            barTintColor = .clear
            setBackgroundImage(UIImage(), for: .default)
            tintColor = tint
            titleTextAttributes = [.foregroundColor: tint]
            shadowImage = UIImage()
        }
    }

    /// SwifterSwift: Set navigationBar background and text colors.
    ///
    /// - Parameters:
    ///   - background: background color.
    ///   - text: text color.
    func setColors(background: UIColor, text: UIColor) {
        isTranslucent = false
        barTintColor = background
        if #available(iOS 13.0, *) {
            let standardApp = standardAppearance
            standardApp.backgroundColor = background
            standardApp.backgroundImage = UIImage()
            standardApp.titleTextAttributes = [.foregroundColor: text]
            standardAppearance = standardApp
            if let scrollApp = scrollEdgeAppearance {
                scrollApp.backgroundColor = background
                scrollApp.backgroundImage = UIImage()
                scrollApp.titleTextAttributes = [.foregroundColor: text]
            }
        } else{
            backgroundColor = background
            setBackgroundImage(UIImage(), for: .default)
            tintColor = text
            titleTextAttributes = [.foregroundColor: text]
        }
    }
}

#endif
