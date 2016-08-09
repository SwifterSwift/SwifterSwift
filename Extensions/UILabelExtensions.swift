//
//  UILabelExtensions.swift
//  SwiftierSwift
//
//  Created by Omar Albeik on 8/6/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

//FIXME:
import UIKit
public extension UILabel {

<<<<<<< HEAD
    /// Create smooth cross-dissolve transition to text changes; default duration is 0.5s.
    public func addTransitionAnimation(_duration : Double = 0.5) {
        let animation = CATransition()
        animation.duration = _duration
        animation.type = kCATransitionFade
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
        self.layer.add(animation, forKey: "changeTextTransition")

    }

    /// Set character spacing.
    public func characterSpacing(spacing:Double) {
        self.attributedText = AttributedString( string: self.text!, attributes:[NSKernAttributeName: spacing])

    }


=======
>>>>>>> testing
}
