// CGAffineTransformExtensions.swift - Copyright 2024 SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics

#if canImport(QuartzCore) && !os(watchOS)

import QuartzCore

// MARK: - Methods

public extension CGAffineTransform {
    /// SwifterSwift: Returns a transform with the same effect as the receiver.
    @inlinable
    func transform3D() -> CATransform3D { CATransform3DMakeAffineTransform(self) }
}

#endif

#endif
