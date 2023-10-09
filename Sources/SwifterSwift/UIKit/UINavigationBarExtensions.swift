// UINavigationBarExtensions.swift - Copyright 2023 SwifterSwift

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
        if #available(iOS 13.0, tvOS 13.0, *) {
            standardAppearance.titleTextAttributes = attrs
            scrollEdgeAppearance?.titleTextAttributes = attrs
            compactAppearance?.titleTextAttributes = attrs
        } else {
            titleTextAttributes = attrs
        }
    }

    /// SwifterSwift: Make navigation bar transparent.
    ///
    /// - Parameter tint: tint color (default is .white).
    func makeTransparent(withTint tint: UIColor = .white) {
        let legacyAppearance = { [self] in
            isTranslucent = true
            backgroundColor = .clear
            barTintColor = .clear
            setBackgroundImage(UIImage(), for: .default)
            titleTextAttributes = [.foregroundColor: tint]
            shadowImage = UIImage()
        }
        #if os(tvOS)
        legacyAppearance()
        #else
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.titleTextAttributes = [.foregroundColor: tint]
            standardAppearance = appearance
            scrollEdgeAppearance = appearance
            compactAppearance = appearance
        } else {
            legacyAppearance()
        }
        #endif
        tintColor = tint
    }

    /// SwifterSwift: Set navigationBar background and text colors.
    ///
    /// - Parameters:
    ///   - background: background color.
    ///   - text: text color.
    func setColors(background: UIColor, text: UIColor) {
        let legacyAppearance = { [self] in
            isTranslucent = false
            backgroundColor = background
            barTintColor = background
            setBackgroundImage(UIImage(), for: .default)
            titleTextAttributes = [.foregroundColor: text]
        }
        #if os(tvOS)
        legacyAppearance()
        #else
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = background
            appearance.titleTextAttributes = [.foregroundColor: text]
            standardAppearance = appearance
            scrollEdgeAppearance = appearance
            compactAppearance = appearance
        } else {
            legacyAppearance()
        }
        #endif
        tintColor = text
    }
}

#endif
