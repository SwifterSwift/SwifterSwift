//
//  CGAffineTransformExtensions.swift
//  SwifterSwift
//
//  Created by Guy Kogus on 19/3/20.
//  Copyright © 2020 SwifterSwift
//

#if canImport(CoreGraphics)
import CoreGraphics

#if canImport(QuartzCore)

import QuartzCore

// MARK: - Methods
public extension CGAffineTransform {

    /// SwifterSwift: Returns a transform with the same effect as the receiver.
    @inlinable
    func transform3D() -> CATransform3D { CATransform3DMakeAffineTransform(self) }

}

#endif

#endif
