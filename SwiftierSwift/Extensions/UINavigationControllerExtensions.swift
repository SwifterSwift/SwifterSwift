//
//  UINavigationControllerExtensions.swift
//  SwiftierSwift
//
//  Created by Omar Albeik on 8/6/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import UIKit
public extension UINavigationController {
    
    public func popViewControllerWithHandler(completion: ()->()) {
        // https://github.com/cotkjaer/UserInterface/blob/master/UserInterface/UIViewController.swift
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popViewController(animated: true)
        CATransaction.commit()
    }
    
    func pushViewController(viewController: UIViewController, completion: ()->()) {
        // https://github.com/cotkjaer/UserInterface/blob/master/UserInterface/UIViewController.swift
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        pushViewController(viewController, animated: true)
        CATransaction.commit()
    }
    
}
