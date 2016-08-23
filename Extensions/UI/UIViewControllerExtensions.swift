//
//  UIViewControllerExtensions.swift
//  SwiftierSwift
//
//  Created by Emirhan Erdogan on 07/08/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    // FIXME:
    public var navigationBar: UINavigationBar? {
        return navigationController?.navigationBar
    }
    
    // FIXME:
    public func addNotificationObServer(name: Notification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
    }
    
    // FIXME:
    public func removeNotificationObServer(name: Notification.Name) {
        NotificationCenter.default.removeObserver(self, name: name, object: nil)
    }
    
    // FIXME:
    public func removeNotificationObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    // FIXME:
    public var isVisible: Bool {
        // http://stackoverflow.com/questions/2777438/how-to-tell-if-uiviewcontrollers-view-is-visible
        return self.isViewLoaded && view.window != nil
    }
    
    
}
