//
//  CGAffineTransformExtensions.swift
//  SwifterSwift
//
//  Created by Steven on 2/12/17.
//  Copyright © 2017 omaralbeik. All rights reserved.
//

#if os(macOS)
    import Cocoa
#else
    import UIKit
#endif

// MARK: - Methods
extension CGAffineTransform {
    
    /// SwifterSwift: Subtract CGAffineTransform from existing transform
    ///
    /// - Parameter transform: The tranform to remove
    /// - Returns: A new transform with the specified transform removed by concatening its inverse.
    ///            If the transform cannot be inverted, the original transform is returned.
    
    public func subtracting(transform: CGAffineTransform) -> CGAffineTransform {
        return transform.inverted() == transform ? self : self.concatenating(transform.inverted())
    }
}
