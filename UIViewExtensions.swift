//
//  UIViewExtensions.swift
//  SwiftyExtensions
//
//  Created by Omar Albeik on 8/4/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import UIKit

public extension UIView {
    
    /// Shake UIView
    public func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}
