//
//  UIViewControllerExtensions.swift
//  SwiftierSwift
//
//  Created by Emirhan Erdogan on 07/08/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import UIKit

public extension UIViewController {

    /// Return navigationBar of a ViewController.
    public var navigationBar: UINavigationBar? {
        return navigationController?.navigationBar
    }

    /// Assign as listener to notification.
    public func addNotificationObserver(name: Notification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
    }

    /// Unassign as listener to notification.
    public func removeNotificationObserver(name: Notification.Name) {
        NotificationCenter.default.removeObserver(self, name: name, object: nil)
    }

    /// Unassign as listener from all notifications.
    public func removeNotificationsObserver() {
        NotificationCenter.default.removeObserver(self)
    }

    /// Return true if ViewController is onscreen and not hidden.
    public var isVisible: Bool {
        // http://stackoverflow.com/questions/2777438/how-to-tell-if-uiviewcontrollers-view-is-visible
        return self.isViewLoaded && view.window != nil
    }


}
