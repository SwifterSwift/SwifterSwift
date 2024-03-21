// UIColorExtensions.swift - Copyright 2024 SwifterSwift

#if canImport(UIKit)
import UIKit

public extension UIColor {
    #if !os(watchOS)
    /// SwifterSwift: Create a UIColor with different colors for light and dark mode.
    ///
    /// - Parameters:
    ///     - light: Color to use in light/unspecified mode.
    ///     - dark: Color to use in dark mode.
    convenience init(light: UIColor, dark: UIColor) {
        if #available(iOS 13.0, tvOS 13.0, *) {
            self.init(dynamicProvider: { $0.userInterfaceStyle == .dark ? dark : light })
        } else {
            self.init(cgColor: light.cgColor)
        }
    }
    #endif
}

#endif
