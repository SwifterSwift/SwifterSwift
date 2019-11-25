//
//  CGVectorExtensions.swift
//  SwifterSwift
//
//  Created by Robbie Moyer on 7/25/18.
//  Copyright © 2018 SwifterSwift
//

#if canImport(CoreGraphics)
import CoreGraphics

// MARK: - Properties
public extension CGVector {

    /// SwifterSwift: The angle of rotation (in radians) of the vector. The range of the angle is -π to π; an angle of 0 points to the right.
    ///
    /// https://en.wikipedia.org/wiki/Atan2
    var angle: CGFloat {
        return atan2(dy, dx)
    }

    /// SwifterSwift: The magnitude (or length) of the vector.
    ///
    /// https://en.wikipedia.org/wiki/Euclidean_vector#Length
    var magnitude: CGFloat {
        return sqrt((dx * dx) + (dy * dy))
    }

}

// MARK: - Initializers
public extension CGVector {

    /// SwifterSwift: Creates a vector with the given magnitude and angle.
    ///
    ///     let vector = CGVector(angle: .pi, magnitude: 1)
    ///
    /// - Parameters:
    ///     - angle: The angle of rotation (in radians) counterclockwise from the positive x-axis.
    ///     - magnitude: The lenth of the vector.
    ///
    init(angle: CGFloat, magnitude: CGFloat) {
        // https://www.grc.nasa.gov/WWW/K-12/airplane/vectpart.html
        self.init(dx: magnitude * cos(angle), dy: magnitude * sin(angle))
    }

}

// MARK: - Operators
public extension CGVector {

    /// SwifterSwift: Multiplies a scalar and a vector (commutative).
    ///
    ///     let vector = CGVector(dx: 1, dy: 1)
    ///     let largerVector = vector * 2
    ///
    /// - Parameters:
    ///   - vector: The vector to be multiplied
    ///   - scalar: The scale by which the vector will be multiplied
    /// - Returns: The vector with its magnitude scaled
    static func * (vector: CGVector, scalar: CGFloat) -> CGVector {
        return CGVector(dx: vector.dx * scalar, dy: vector.dy * scalar)
    }

    /// SwifterSwift: Multiplies a scalar and a vector (commutative).
    ///
    ///     let vector = CGVector(dx: 1, dy: 1)
    ///     let largerVector = 2 * vector
    ///
    /// - Parameters:
    ///   - scalar: The scalar by which the vector will be multiplied
    ///   - vector: The vector to be multiplied
    /// - Returns: The vector with its magnitude scaled
    static func * (scalar: CGFloat, vector: CGVector) -> CGVector {
        return CGVector(dx: scalar * vector.dx, dy: scalar * vector.dy)
    }

    /// SwifterSwift: Compound assignment operator for vector-scalr multiplication
    ///
    ///     var vector = CGVector(dx: 1, dy: 1)
    ///     vector *= 2
    ///
    /// - Parameters:
    ///   - vector: The vector to be multiplied
    ///   - scalar: The scale by which the vector will be multiplied
    static func *= (vector: inout CGVector, scalar: CGFloat) {
        // swiftlint:disable:next shorthand_operator
        vector = vector * scalar
    }

    /// SwifterSwift: Negates the vector. The direction is reversed, but magnitude remains the same.
    ///
    ///     let vector = CGVector(dx: 1, dy: 1)
    ///     let reversedVector = -vector
    ///
    /// - Parameter vector: The vector to be negated
    /// - Returns: The negated vector
    static prefix func - (vector: CGVector) -> CGVector {
        return CGVector(dx: -vector.dx, dy: -vector.dy)
    }

}

#endif
