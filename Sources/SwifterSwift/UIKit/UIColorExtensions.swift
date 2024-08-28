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

    /// SwifterSwift: Initializes and returns a color object using the specified hexadecimal string.
    ///
    /// This initializer allows you to create a `UIColor` instance from a hexadecimal string representation
    /// of a color. The string can optionally start with a `#`, and it must contain exactly 6 characters
    /// corresponding to the red, green, and blue components of the color.
    ///
    /// - Parameter hex: A string in the format `"#RRGGBB"` or `"RRGGBB"`.
    ///
    /// Example:
    /// ```
    /// let color = UIColor(hex: "#ff0000")
    /// // Creates a red color
    /// ```
    ///
    /// If the input string does not contain exactly 6 characters, the initializer will trigger a runtime
    /// error with a precondition failure.
    ///
    /// - Note: The alpha component is set to 1.0 (fully opaque) by default.
    convenience init?(hex: String) {
        var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if cString.hasPrefix("#") {
            cString.removeFirst()
        }
        guard cString.count == 6 else {
            return nil
        }
        let validHexCharacters = CharacterSet(charactersIn: "0123456789ABCDEF")
        guard cString.rangeOfCharacter(from: validHexCharacters.inverted) == nil else {
            return nil
        }
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

#endif
