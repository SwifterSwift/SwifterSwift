// CATransform3DExtensions.swift - Copyright 2023 SwifterSwift

// swiftlint:disable identifier_name

#if canImport(QuartzCore)

import QuartzCore

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
    @inlinable
    public static func == (lhs: CATransform3D, rhs: CATransform3D) -> Bool {
        CATransform3DEqualToTransform(lhs, rhs)
    }

    // swiftlint:enable missing_swifterswift_prefix
}

// MARK: - Static Properties

public extension CATransform3D {
    /// SwifterSwift: The identity transform: [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1].
    @inlinable
    static var identity: CATransform3D { CATransform3DIdentity }
}

// MARK: - Codable

extension CATransform3D: Codable {
    // swiftlint:disable missing_swifterswift_prefix

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or if the data read is corrupted or
    /// otherwise invalid.
    /// - Parameter decoder: The decoder to read data from.
    @inlinable
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        try self.init(m11: container.decode(CGFloat.self),
                      m12: container.decode(CGFloat.self),
                      m13: container.decode(CGFloat.self),
                      m14: container.decode(CGFloat.self),
                      m21: container.decode(CGFloat.self),
                      m22: container.decode(CGFloat.self),
                      m23: container.decode(CGFloat.self),
                      m24: container.decode(CGFloat.self),
                      m31: container.decode(CGFloat.self),
                      m32: container.decode(CGFloat.self),
                      m33: container.decode(CGFloat.self),
                      m34: container.decode(CGFloat.self),
                      m41: container.decode(CGFloat.self),
                      m42: container.decode(CGFloat.self),
                      m43: container.decode(CGFloat.self),
                      m44: container.decode(CGFloat.self))
    }

    /// Encodes this value into the given encoder.
    ///
    /// If the value fails to encode anything, encoder will encode an empty keyed container in its place.
    ///
    /// This function throws an error if any values are invalid for the given encoder’s format.
    /// - Parameter encoder: The encoder to write data to.
    @inlinable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(m11)
        try container.encode(m12)
        try container.encode(m13)
        try container.encode(m14)
        try container.encode(m21)
        try container.encode(m22)
        try container.encode(m23)
        try container.encode(m24)
        try container.encode(m31)
        try container.encode(m32)
        try container.encode(m33)
        try container.encode(m34)
        try container.encode(m41)
        try container.encode(m42)
        try container.encode(m43)
        try container.encode(m44)
    }

    // swiftlint:enable missing_swifterswift_prefix
}

// MARK: - Initializers

public extension CATransform3D {
    /// SwifterSwift: Returns a transform that translates by `(tx, ty, tz)`.
    /// - Parameters:
    ///   - tx: x-axis translation
    ///   - ty: y-axis translation
    ///   - tz: z-axis translation
    @inlinable
    init(translationX tx: CGFloat, y ty: CGFloat, z tz: CGFloat) {
        self = CATransform3DMakeTranslation(tx, ty, tz)
    }

    /// SwifterSwift: Returns a transform that scales by `(sx, sy, sz)`.
    /// - Parameters:
    ///   - sx: x-axis scale
    ///   - sy: y-axis scale
    ///   - sz: z-axis scale
    @inlinable
    init(scaleX sx: CGFloat, y sy: CGFloat, z sz: CGFloat) {
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
    @inlinable
    init(rotationAngle angle: CGFloat, x: CGFloat, y: CGFloat, z: CGFloat) {
        self = CATransform3DMakeRotation(angle, x, y, z)
    }
}

// MARK: - Properties

public extension CATransform3D {
    /// SwifterSwift: Returns `true` if the receiver is the identity transform.
    @inlinable
    var isIdentity: Bool { CATransform3DIsIdentity(self) }
}

// MARK: - Methods

public extension CATransform3D {
    /// SwifterSwift: Translate the receiver by `(tx, ty, tz)`.
    /// - Parameters:
    ///   - tx: x-axis translation
    ///   - ty: y-axis translation
    ///   - tz: z-axis translation
    /// - Returns: The translated matrix.
    @inlinable
    func translatedBy(x tx: CGFloat, y ty: CGFloat,
                      z tz: CGFloat) -> CATransform3D {
        CATransform3DTranslate(self, tx, ty, tz)
    }

    /// SwifterSwift: Scale the receiver by `(sx, sy, sz)`.
    /// - Parameters:
    ///   - sx: x-axis scale
    ///   - sy: y-axis scale
    ///   - sz: z-axis scale
    /// - Returns: The scaled matrix.
    @inlinable
    func scaledBy(x sx: CGFloat, y sy: CGFloat,
                  z sz: CGFloat) -> CATransform3D {
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
    @inlinable
    func rotated(by angle: CGFloat, x: CGFloat, y: CGFloat, z: CGFloat) -> CATransform3D {
        CATransform3DRotate(self, angle, x, y, z)
    }

    /// SwifterSwift: Invert the receiver.
    ///
    /// Returns the original matrix if the receiver has no inverse.
    /// - Returns: The inverted matrix of the receiver.
    @inlinable
    func inverted() -> CATransform3D {
        CATransform3DInvert(self)
    }

    /// SwifterSwift: Concatenate `transform` to the receiver.
    /// - Parameter t2: The transform to concatenate on to the receiver
    /// - Returns: The concatenated matrix.
    @inlinable
    func concatenating(_ t2: CATransform3D) -> CATransform3D {
        CATransform3DConcat(self, t2)
    }

    /// SwifterSwift: Translate the receiver by `(tx, ty, tz)`.
    /// - Parameters:
    ///   - tx: x-axis translation
    ///   - ty: y-axis translation
    ///   - tz: z-axis translation
    @inlinable
    mutating func translateBy(x tx: CGFloat, y ty: CGFloat, z tz: CGFloat) {
        self = CATransform3DTranslate(self, tx, ty, tz)
    }

    /// SwifterSwift: Scale the receiver by `(sx, sy, sz)`.
    /// - Parameters:
    ///   - sx: x-axis scale
    ///   - sy: y-axis scale
    ///   - sz: z-axis scale
    @inlinable
    mutating func scaleBy(x sx: CGFloat, y sy: CGFloat, z sz: CGFloat) {
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
    @inlinable
    mutating func rotate(by angle: CGFloat, x: CGFloat, y: CGFloat, z: CGFloat) {
        self = CATransform3DRotate(self, angle, x, y, z)
    }

    /// SwifterSwift: Invert the receiver.
    ///
    /// Returns the original matrix if the receiver has no inverse.
    @inlinable
    mutating func invert() {
        self = CATransform3DInvert(self)
    }

    /// SwifterSwift: Concatenate `transform` to the receiver.
    /// - Parameter t2: The transform to concatenate on to the receiver
    @inlinable
    mutating func concatenate(_ t2: CATransform3D) {
        self = CATransform3DConcat(self, t2)
    }
}

#if canImport(CoreGraphics)

import CoreGraphics

// MARK: - CGAffineTransform

public extension CATransform3D {
    /// SwifterSwift: Returns true if the receiver can be represented exactly by an affine transform.
    @inlinable
    var isAffine: Bool { CATransform3DIsAffine(self) }

    /// SwifterSwift: Returns the affine transform represented by the receiver.
    ///
    /// If the receiver can not be represented exactly by an affine transform the returned value is undefined.
    @inlinable
    func affineTransform() -> CGAffineTransform {
        CATransform3DGetAffineTransform(self)
    }
}

#endif

#endif

// swiftlint:enable identifier_name
