//
//  UINavigationBarExtensions.swift
//  SwiftierSwift
//
//  Created by Omar Albeik on 8/22/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import UIKit

public extension UINavigationBar {
    
    public func setTitle(of font: UIFont, with color: UIColor) {
        var attrs = [String: AnyObject]()
        attrs[NSFontAttributeName] = font
        attrs[NSForegroundColorAttributeName] = color
        titleTextAttributes = attrs
    }
}
