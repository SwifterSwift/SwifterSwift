//
//  UIColorExtensions.swift
//  SwifterSwift
//
//  Created by Max Haertwig on 10/06/19.
//  Copyright © 2019 SwifterSwift
//

#if canImport(UIKit)
import UIKit

public extension UIColor {

    #if !os(watchOS)
    /// SwifterSwift: Create a UIColor with different colors for light and dark mode.
    ///
    /// - Parameters:
    ///     - light: Color to use in light/unspecified mode.
    ///     - dark: Color to use in dark mode.
    @available(iOS 13.0, tvOS 13.0, *)
    convenience init(light: UIColor, dark: UIColor) {
        self.init(dynamicProvider: { $0.userInterfaceStyle == .dark ? dark : light })
    }
    #endif

}

#endif
