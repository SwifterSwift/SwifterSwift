//
//  CATransform3DExtensions.swift
//  SwifterSwift
//
//  Created by Guy Kogus on 19/3/20.
//  Copyright © 2020 SwifterSwift
//

#if canImport(QuartzCore)

import QuartzCore

// MARK: - Properties
public extension CATransform3D {

    /// SwifterSwift: The identity transform: [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1].
    static var identity: CATransform3D { CATransform3DIdentity }

    /// SwifterSwift: Returns `true` if the receiver is the identity transform.
    var isIdentity: Bool { CATransform3DIsIdentity(self) }

}

// MARK: - Initializers
public extension CATransform3D {

    /// SwifterSwift: Returns a transform that translates by `(tx, ty, tz)`.
    /// - Parameters:
    ///   - tx: x-axis translation
    ///   - ty: y-axis translation
    ///   - tz: z-axis translation
    init(translation tx: CGFloat, _ ty: CGFloat, _ tz: CGFloat) { // swiftlint:disable:this identifier_name
        self = CATransform3DMakeTranslation(tx, ty, tz)
    }

    /// SwifterSwift: Returns a transform that scales by `(sx, sy, sz)`.
    /// - Parameters:
    ///   - sx: x-axis scale
    ///   - sy: y-axis scale
    ///   - sz: z-axis scale
    init(scale sx: CGFloat, _ sy: CGFloat, _ sz: CGFloat) { // swiftlint:disable:this identifier_name
        self = CATransform3DMakeScale(sx, sy, sz)
    }

    /// SwifterSwift: Returns a transform that rotates by `angle` radians about the vector `(x, y, z)`.
    ///
    /// If the vector has zero length the behavior is undefined.
    /// - Parameters:
    ///   - angle: The angle of rotation
    ///   - x: x position of the vector
    ///   - y: y position of the vector
    ///   - z: z position of the vector
    init(rotation angle: CGFloat, _ x: CGFloat, _ y: CGFloat, _ z: CGFloat) { // swiftlint:disable:this identifier_name
        self = CATransform3DMakeRotation(angle, x, y, z)
    }

}

// MARK: - Methods
public extension CATransform3D {

    /// SwifterSwift: Translate the receiver by `(tx, ty, tz)`.
    /// - Parameters:
    ///   - tx: x-axis translation
    ///   - ty: y-axis translation
    ///   - tz: z-axis translation
    /// - Returns: The translated matrix.
    func translated(tx: CGFloat, ty: CGFloat, tz: CGFloat) -> CATransform3D { // swiftlint:disable:this identifier_name
        CATransform3DTranslate(self, tx, ty, tz)
    }

    /// SwifterSwift: Scale the receiver by `(sx, sy, sz)`.
    /// - Parameters:
    ///   - sx: x-axis scale
    ///   - sy: y-axis scale
    ///   - sz: z-axis scale
    /// - Returns: The scaled matrix.
    func scaled(sx: CGFloat, sy: CGFloat, sz: CGFloat) -> CATransform3D { // swiftlint:disable:this identifier_name
        CATransform3DScale(self, sx, sy, sz)
    }

    /// SwifterSwift: Rotate the receiver by `angle` radians about the vector `(x, y, z)`.
    ///
    /// If the vector has zero length the behavior is undefined.
    /// - Parameters:
    ///   - angle: The angle of rotation
    ///   - x: x position of the vector
    ///   - y: y position of the vector
    ///   - z: z position of the vector
    /// - Returns: The rotated matrix.
    func rotated(angle: CGFloat, x: CGFloat, y: CGFloat, z: CGFloat) -> CATransform3D { // swiftlint:disable:this identifier_name
        CATransform3DRotate(self, angle, x, y, z)
    }

    /// SwifterSwift: Concatenate `transform` to the receiver.
    /// - Parameter transform: The transform to concatenate on to the receiver
    /// - Returns: The concatenated matrix.
    func concatenated(transform: CATransform3D) -> CATransform3D {
        CATransform3DConcat(self, transform)
    }

    /// SwifterSwift: Invert the receiver.
    ///
    /// Returns the original matrix if the receiver has no inverse.
    /// - Returns: The inverted matrix of the receiver.
    func inverted() -> CATransform3D {
        CATransform3DInvert(self)
    }

    /// SwifterSwift: Translate the receiver by `(tx, ty, tz)`.
    /// - Parameters:
    ///   - tx: x-axis translation
    ///   - ty: y-axis translation
    ///   - tz: z-axis translation
    mutating func translate(tx: CGFloat, ty: CGFloat, tz: CGFloat) { // swiftlint:disable:this identifier_name
        self = CATransform3DTranslate(self, tx, ty, tz)
    }

    /// SwifterSwift: Scale the receiver by `(sx, sy, sz)`.
    /// - Parameters:
    ///   - sx: x-axis scale
    ///   - sy: y-axis scale
    ///   - sz: z-axis scale
    mutating func scale(sx: CGFloat, sy: CGFloat, sz: CGFloat) { // swiftlint:disable:this identifier_name
        self = CATransform3DScale(self, sx, sy, sz)
    }

    /// SwifterSwift: Rotate the receiver by `angle` radians about the vector `(x, y, z)`.
    ///
    /// If the vector has zero length the behavior is undefined.
    /// - Parameters:
    ///   - angle: The angle of rotation
    ///   - x: x position of the vector
    ///   - y: y position of the vector
    ///   - z: z position of the vector
    mutating func rotate(angle: CGFloat, x: CGFloat, y: CGFloat, z: CGFloat) { // swiftlint:disable:this identifier_name
        self = CATransform3DRotate(self, angle, x, y, z)
    }

    /// SwifterSwift: Concatenate `transform` to the receiver.
    /// - Parameter transform: The transform to concatenate on to the receiver
    mutating func concatenate(transform: CATransform3D) {
        self = CATransform3DConcat(self, transform)
    }

    /// SwifterSwift: Invert the receiver.
    ///
    /// Returns the original matrix if the receiver has no inverse.
    mutating func invert() {
        self = CATransform3DInvert(self)
    }

}

// MARK: - Equatable
extension CATransform3D: Equatable {

    // swiftlint:disable missing_swifterswift_prefix

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (lhs: CATransform3D, rhs: CATransform3D) -> Bool {
        CATransform3DEqualToTransform(lhs, rhs)
    }

    // swiftlint:disable missing_swifterswift_prefix

}

#if canImport(CoreGraphics)

import CoreGraphics

// MARK: - CGAffineTransform
public extension CATransform3D {

    /// SwifterSwift: Returns true if the receiver can be represented exactly by an affine transform.
    var isAffine: Bool { CATransform3DIsAffine(self) }

    /// SwifterSwift: Returns the affine transform represented by the receiver.
    ///
    /// If the receiver can not be represented exactly by an affine transform the returned value is undefined.
    func affineTransform() -> CGAffineTransform {
        CATransform3DGetAffineTransform(self)
    }

}

#endif

#endif
