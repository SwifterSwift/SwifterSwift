// NSColorExtensions.swift - Copyright 2025 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

public extension NSColor {
    /// SwifterSwift: Create an NSColor with different colors for light and dark mode.
    ///
    /// - Parameters:
    ///     - light: Color to use in light/unspecified mode.
    ///     - dark: Color to use in dark mode.
    @available(OSX 10.15, *)
    convenience init(light: NSColor, dark: NSColor) {
        self.init(name: nil, dynamicProvider: { $0.name == .darkAqua ? dark : light })
    }
    
    /// SwifterSwift: Create a NSColor with hex && alpha value.
    ///
    /// - Parameters:
    ///     - hex: hex value.
    ///     - alpha: alpha value.
    static func colorWithHex(_ hex: String, _ alpha: CGFloat = 1.0) -> NSColor {
        // Force conversion to lowercase
        var hexString = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).lowercased()

        // If the passed hexadecimal color has a 0x prefix, remove the prefix
        if hexString.hasPrefix("0x") {
            hexString = String(hexString[hexString.index(hexString.startIndex, offsetBy: 2)...])
        }
        // If the passed hexadecimal color has a # prefix, remove the prefix
        if hexString.hasPrefix("#") {
            hexString = String(hexString[hexString.index(hexString.startIndex, offsetBy: 1)...])
        }
        
        // If the number of characters passed in is less than 6, all the characters after that will be treated as 0
        if hexString.count < 6 {
            for _ in 0..<6-hexString.count {
                hexString += "0"
            }
        }
        
        // Store the converted value
        var red: UInt64 = 0, green: UInt64 = 0, blue: UInt64 = 0
        
        // red
        Scanner(string: String(hexString[..<hexString.index(hexString.startIndex, offsetBy: 2)])).scanHexInt64(&red)
        
        // green
        Scanner(string: String(hexString[hexString.index(hexString.startIndex, offsetBy: 2)..<hexString.index(hexString.startIndex, offsetBy: 4)])).scanHexInt64(&green)
        
        // blue
        Scanner(string: String(hexString[hexString.index(hexString.startIndex, offsetBy: 4)...])).scanHexInt64(&blue)
        
        // Return the color
        return NSColor(red: (CGFloat(red) / 255.0), green: (CGFloat(green) / 255.0), blue: (CGFloat(blue) / 255.0), alpha: alpha)
    }
}

#endif
