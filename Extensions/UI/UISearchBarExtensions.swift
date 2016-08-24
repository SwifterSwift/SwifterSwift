//
//  UISearchBarExtensions.swift
//  SwiftierSwift
//
//  Created by Omar Albeik on 8/23/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import UIKit

extension UISearchBar {
    
    // FIXME:
    var cancelButton: UIButton? {
        for view in subviews {
            if let button = view as? UIButton {
                return button
            }
        }
        return nil
    }
    
}
