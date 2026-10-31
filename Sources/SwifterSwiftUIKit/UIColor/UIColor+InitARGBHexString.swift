// UIColor+InitARGBHexString.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import UIKit

public extension UIColor {
    /// SwifterSwift: Creates a color from an alpha-first sRGB hex string, or returns `nil` if the string is invalid.
    ///
    /// Use this initializer for hex colors that put the alpha component first, the order used by Android, .NET (XAML)
    /// and Flutter, and by many design tools. The string has 3, 4, 6 or 8 hexadecimal digits, in either case,
    /// optionally preceded by `#`, `0x` or `0X`:
    ///
    /// - `RGB` and `ARGB` are short forms where each digit is repeated, so `8F80` means `88FF8800`.
    /// - `RRGGBB` is an opaque color.
    /// - `AARRGGBB` puts the alpha component first, unlike the CSS `RRGGBBAA` order read by `UIColor(hexString:)`.
    ///
    /// The 3- and 6-digit forms have no alpha component, so they give the same color in both orders. Any other length,
    /// a non-hexadecimal character, a sign, whitespace or a second prefix returns `nil`.
    ///
    /// ```swift
    /// UIColor(argbHexString: "#80FF8000")  // orange, (1.0, 0.502, 0.0), alpha 0.502
    /// UIColor(argbHexString: "0xFF1f2d3c")  // (0.122, 0.176, 0.235)
    /// UIColor(argbHexString: "#8F80")  // (1.0, 0.533, 0.0), alpha 0.533
    /// UIColor(argbHexString: "#FF8000")  // orange, (1.0, 0.502, 0.0)
    /// UIColor(argbHexString: "#F")  // nil
    /// UIColor(argbHexString: "FFFFFFF")  // nil
    /// ```
    ///
    /// - Parameter argbHexString: The hexadecimal representation of the color, such as `"#80FF8000"`.
    convenience init?(argbHexString: String) {
        var digits = Substring(argbHexString)
        if digits.hasPrefix("#") {
            digits = digits.dropFirst()
        } else if digits.hasPrefix("0x") || digits.hasPrefix("0X") {
            digits = digits.dropFirst(2)
        }
        guard digits.allSatisfy({ $0.isASCII && $0.isHexDigit }), let value = UInt32(digits, radix: 16) else {
            return nil
        }
        let channels: [UInt32]
        switch digits.count {
        case 3: channels = [0xF, value >> 8, value >> 4, value].map { ($0 & 0xF) * 0x11 }
        case 4: channels = [value >> 12, value >> 8, value >> 4, value].map { ($0 & 0xF) * 0x11 }
        case 6: channels = [0xFF, value >> 16, value >> 8, value].map { $0 & 0xFF }
        case 8: channels = [value >> 24, value >> 16, value >> 8, value].map { $0 & 0xFF }
        default: return nil
        }
        self.init(
            red: CGFloat(channels[1]) / 255,
            green: CGFloat(channels[2]) / 255,
            blue: CGFloat(channels[3]) / 255,
            alpha: CGFloat(channels[0]) / 255
        )
    }
}
#endif
