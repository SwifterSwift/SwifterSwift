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

    /// SwifterSwift: A computed property that returns the hexadecimal string representation of the color.
    ///
    /// This property converts the color to its RGB components and then formats them as a hex string
    /// in the format `#RRGGBB`. The alpha component is ignored.
    ///
    /// - Returns: A string representing the color in hexadecimal format, prefixed with `#`.
    ///
    /// Example:
    /// ```
    /// let color = UIColor.red
    /// print(color.hexString) // Output: "#ff0000"
    /// ```
    var hexString: String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb: Int32 = (Int32)(r * 255) << 16 | (Int32)(g * 255) << 8 | (Int32)(b * 255) << 0
        return String(format: "#%06x", rgb)
    }
    
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
    convenience init(hex: String) {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        if cString.count != 6 {
            preconditionFailure("The hex string size is != 6")
        }
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

#endif
