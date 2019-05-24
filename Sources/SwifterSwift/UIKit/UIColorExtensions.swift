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
    public convenience init?(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }

}
