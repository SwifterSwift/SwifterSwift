//
//  UIAlertControllerExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/23/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import UIKit

public extension UIAlertController {

    /// Create new alert view controller with default OK action.
    public convenience init(title: String, message: String? = nil, defaultActionButtonTitle: String = "OK", tintColor: UIColor? = nil) {
        self.init(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: defaultActionButtonTitle, style: .default, handler: nil)
        self.addAction(defaultAction)
        if let color = tintColor {
            self.view.tintColor = color
        }
    }

    // Present alert view controller in the current view controller.
    public func show() {
        UIApplication.shared.keyWindow?.rootViewController?.present(self, animated: true, completion: nil)
    }
}
