//
//  UIColorExtensions.swift
//  SwifterSwift
//
//  Created by freedom on 5/24/19.
//  Copyright © 2019 SwifterSwift
//

import Foundation
import UIKit

extension UIColor {
    /// SwifterSwift: Simple UIColor init.
    ///
    ///    loginButton.color = UIColor(r: 255, g: 0, b: 70, a: 1)
    ///
    /// - Parameters:
    ///   - r: Red Value.
    ///   - b: Blue Value.
    ///   - g: Green Value.
    public convenience init?(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }

}
