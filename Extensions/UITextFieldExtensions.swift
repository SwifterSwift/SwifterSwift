//
//  UITextFieldExtensions.swift
//  SwiftierSwift
//
//  Created by Omar Albeik on 8/5/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import UIKit
public extension UITextField {
    
    /// Return true if text field is empty
    public var isEmpty: Bool {
        if let text = self.text {
            return text.characters.isEmpty
        }
        return true
    }
}
