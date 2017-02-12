//
//  UIStoryboardExtensions.swift
//  SwifterSwift
//
//  Created by Steven on 2/6/17.
//  Copyright © 2017 omaralbeik. All rights reserved.
//

#if os(iOS) || os(tvOS)
import UIKit

// MARK: - Methods
extension UIStoryboard {
    
    /// SwifterSwift: Instantiate a UIViewController using its class name
    ///
    /// - Parameter name: UIViewController type
    /// - Returns: The view controller corresponding to specified class name
    public func instantiateViewController<T: UIViewController>(withClass name: T.Type) -> T {
        return instantiateViewController(withIdentifier: String(describing: name)) as! T
    }
}
#endif
