// UIColorExtensions.swift - Copyright 2020 SwifterSwift

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


public extension UIColor {
  convenience init(red: Int, green: Int, blue: Int) {
    assert(red >= 0 && red <= 255, "Invalid red component")
    assert(green >= 0 && green <= 255, "Invalid green component")
    assert(blue >= 0 && blue <= 255, "Invalid blue component")
    
    self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
  }
  
  convenience init(rgb: Int) {
    self.init(
      red: (rgb >> 16) & 0xFF,
      green: (rgb >> 8) & 0xFF,
      blue: rgb & 0xFF
    )
  }
}

#endif
