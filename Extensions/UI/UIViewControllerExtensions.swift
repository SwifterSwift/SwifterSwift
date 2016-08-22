//
//  UIViewControllerExtensions.swift
//  SwiftierSwift
//
//  Created by Emirhan Erdogan on 07/08/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    public var navigationBar: UINavigationBar? {
        return navigationController?.navigationBar
    }
    
    public func addNotificationObServer(name: Notification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
    }
    
    public func removeNotificationObServer(name: Notification.Name) {
        NotificationCenter.default.removeObserver(self, name: name, object: nil)
    }
    
    public func removeNotificationObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    
}
