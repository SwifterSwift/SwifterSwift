//
//  UIViewControllerExtensions.swift
//  SwifterSwift
//
//  Created by Emirhan Erdogan on 07/08/16.
//  Copyright © 2016 SwifterSwift
//

#if os(iOS) || os(tvOS)
import UIKit

// MARK: - Properties
public extension UIViewController {
	
	/// SwifterSwift: Check if ViewController is onscreen and not hidden.
	public var isVisible: Bool {
		// http://stackoverflow.com/questions/2777438/how-to-tell-if-uiviewcontrollers-view-is-visible
		return self.isViewLoaded && view.window != nil
	}
	
}

// MARK: - Methods
public extension UIViewController {
	
	/// SwifterSwift: Assign as listener to notification.
	///
	/// - Parameters:
	///   - name: notification name.
	///   - selector: selector to run with notified.
	public func addNotificationObserver(name: Notification.Name, selector: Selector) {
		NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
	}
	
	/// SwifterSwift: Unassign as listener to notification.
	///
	/// - Parameter name: notification name.
	public func removeNotificationObserver(name: Notification.Name) {
		NotificationCenter.default.removeObserver(self, name: name, object: nil)
	}
	
	/// SwifterSwift: Unassign as listener from all notifications.
	public func removeNotificationsObserver() {
		NotificationCenter.default.removeObserver(self)
	}
	
    /// SwifterSwift: Helper method to display an alert on any UIViewController subclass. Uses UIAlertController to show an alert
    ///
    /// - Parameters:
    ///   - title: title of the alert
    ///   - message: message/body of the alert
    ///   - buttonTitles: (Optional)list of button titles for the alert. Default button i.e "OK" will be shown if this paramter is nil
    ///   - highlightedButtonIndex: (Optional) index of the button from buttonTitles that should be highlighted. If this parameter is nil no button will be highlighted
    ///   - completion: (Optional) completion block to be invoked when any one of the buttons is tapped. It passes the index of the tapped button as an argument
    /// - Returns: UIAlertController object (discardable).
    @discardableResult public func showAlert(title: String?, message: String?, buttonTitles: [String]? = nil, highlightedButtonIndex: Int? = nil, completion: ((Int) -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        var allButtons = buttonTitles ?? [String]()
        if allButtons.count == 0 {
            allButtons.append("OK")
        }
        
        for index in 0..<allButtons.count {
            let buttonTitle = allButtons[index]
            let action = UIAlertAction(title: buttonTitle, style: .default, handler: { (_) in
                completion?(index)
            })
            alertController.addAction(action)
            // Check which button to highlight
            if let highlightedButtonIndex = highlightedButtonIndex, index == highlightedButtonIndex {
                if #available(iOS 9.0, *) {
                    alertController.preferredAction = action
                }
            }
        }
        present(alertController, animated: true, completion: nil)
        return alertController
    }
}
    
    // MARK: Instance Loader
    extension UIViewController {
        
        /// instance from storyboard
        /// ViewControllerClassName.instanceFromStoryboard()
        ///
        public class func instanceFromStoryboard(_ storyboardName: String? = nil) -> Self? {
            let className = String(describing: self)
            func fromStoryboardHelper<T>(_ storyboardName: String?) -> T? where T : UIViewController {
                if let sbName = storyboardName {
                    let storyboard = UIStoryboard(name: sbName, bundle: Bundle(for: T.self))
                    return storyboard.instantiateViewController(withIdentifier: className) as? T
                }
                else {
                    return self.getInstanceFromStoryboard(className) as? T
                }
            }
            return fromStoryboardHelper(storyboardName)
        }
        
        private class func getInstanceFromStoryboard (_ identifier : String) -> UIViewController? {
            guard let resourcePath = Bundle(for: self).resourcePath else { return nil }
            let storyboardPaths : Array = UIViewController.storyboardPaths(resourcePath)
            for storyboardPath : String in storyboardPaths {
                let storyboardContents : Array = try! FileManager.default.contentsOfDirectory(atPath: storyboardPath)
                if storyboardContents.filter({ $0 == identifier + ".nib"}).first != nil { // did find storyboard.
                    if let sbName : String = storyboardPath.components(separatedBy: "/").last?.components(separatedBy: ".").first {
                        let sb = UIStoryboard(name: sbName, bundle: Bundle.main)
                        return sb.instantiateViewController(withIdentifier: identifier)
                    }
                }
            }
            return nil;
        }
        
        private class func storyboardPaths(_ resourcePath: String ) -> Array<String> {
            var fileNames : [String] = []
            let resourceContents : Array = try! FileManager.default.contentsOfDirectory(atPath: resourcePath)
            for itemPath : String  in resourceContents {
                if let fileExtention = itemPath.components(separatedBy: ".").last, fileExtention == "storyboardc"  {
                    fileNames.append(resourcePath + "/" + itemPath)
                }
                else {
                    let filePath : String = resourcePath + "/" + itemPath
                    var isDirectory : ObjCBool = false
                    let fileExistsAtPath : Bool = FileManager.default.fileExists(atPath: filePath, isDirectory: &isDirectory)
                    // 디렉터리고 파일이 존재하면 재귀호출
                    if (isDirectory.boolValue && fileExistsAtPath) {
                        let tempPaths : Array = UIViewController.storyboardPaths(filePath)
                        if tempPaths.count > 0 {
                            fileNames.append(contentsOf: tempPaths)
                        }
                    }
                }
            }
            return fileNames
        }
    }

#endif
