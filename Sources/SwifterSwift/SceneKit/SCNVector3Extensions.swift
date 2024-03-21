// SCNVector3Extensions.swift - Copyright 2024 SwifterSwift

#if os(OSX)
/// SwifterSwift: CGFloat.
public typealias SceneKitFloat = CGFloat
#else
/// SwifterSwift: Float.
public typealias SceneKitFloat = Float
#endif

#if canImport(SceneKit)
import SceneKit

// MARK: - Methods

public extension SCNVector3 {
    /// SwifterSwift: Returns the absolute values of the vector's components.
    ///
    ///         SCNVector3(2, -3, -6).abs -> SCNVector3(2, 3, 6)
    ///
    var absolute: SCNVector3 {
        return SCNVector3(abs(x), abs(y), abs(z))
    }

    /// SwifterSwift: Returns the length of the vector.
    ///
    ///         SCNVector3(2, 3, 6).length -> 7
    ///
    var length: SceneKitFloat {
        return sqrt(pow(x, 2) + pow(y, 2) + pow(z, 2))
    }

    /// SwifterSwift: Returns the unit or normalized vector where `length = 1`.
    ///
    ///     SCNVector3(2, 3, 6).normalized  -> SCNVector3(2/7, 3/7, 6/7)
    ///
    var normalized: SCNVector3 {
        let length = sqrt(pow(x, 2) + pow(y, 2) + pow(z, 2))
        return SCNVector3(x / length, y / length, z / length)
    }
}

// MARK: - Operators

public extension SCNVector3 {
    /// SwifterSwift: Add two SCNVector3s.
    ///
    ///     SCNVector3(10, 10, 10) + SCNVector3(10, 20, -30) -> SCNVector3(20, 30, -20)
    ///
    /// - Parameters:
    ///   - lhs: SCNVector3 to add to.
    ///   - rhs: SCNVector3 to add.
    /// - Returns: result of addition of the two given SCNVector3s.
    static func + (lhs: SCNVector3, rhs: SCNVector3) -> SCNVector3 {
        return SCNVector3(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z)
    }

    /// SwifterSwift: Add a SCNVector3 to self.
    ///
    ///     SCNVector3(10, 10, 10) += SCNVector3(10, 20, -30) -> SCNVector3(20, 30, -20)
    ///
    /// - Parameters:
    ///   - lhs: `self`.
    ///   - rhs: SCNVector3 to add.
    static func += (lhs: inout SCNVector3, rhs: SCNVector3) {
        lhs.x += rhs.x
        lhs.y += rhs.y
        lhs.z += rhs.z
    }

    /// SwifterSwift: Subtract two SCNVector3s.
    ///
    ///     SCNVector3(10, 10, 10) - SCNVector3(10, 20, -30) -> SCNVector3(0, -10, 40)
    ///
    /// - Parameters:
    ///   - lhs: SCNVector3 to subtract from.
    ///   - rhs: SCNVector3 to subtract.
    /// - Returns: result of subtract of the two given SCNVector3s.
    static func - (lhs: SCNVector3, rhs: SCNVector3) -> SCNVector3 {
        return SCNVector3(lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z)
    }

    /// SwifterSwift: Subtract a SCNVector3 from self.
    ///
    ///     SCNVector3(10, 10, 10) -= SCNVector3(10, 20, -30) -> SCNVector3(0, -10, 40)
    ///
    /// - Parameters:
    ///   - lhs: `self`.
    ///   - rhs: SCNVector3 to subtract.
    static func -= (lhs: inout SCNVector3, rhs: SCNVector3) {
        lhs.x -= rhs.x
        lhs.y -= rhs.y
        lhs.z -= rhs.z
    }

    /// SwifterSwift: Multiply a SCNVector3 with a scalar
    ///
    ///     SCNVector3(10, 20, -30) * 3 -> SCNVector3(30, 60, -90)
    ///
    /// - Parameters:
    ///   - vector: SCNVector3 to multiply.
    ///   - scalar: scalar value.
    /// - Returns: result of multiplication of the given SCNVector3 with the scalar.
    static func * (vector: SCNVector3, scalar: SceneKitFloat) -> SCNVector3 {
        return SCNVector3(vector.x * scalar, vector.y * scalar, vector.z * scalar)
    }

    /// SwifterSwift: Multiply self with a scalar
    ///
    ///     SCNVector3(10, 20, -30) *= 3 -> SCNVector3(30, 60, -90)
    ///
    /// - Parameters:
    ///   - vector: `self`.
    ///   - scalar: scalar value.
    /// - Returns: result of multiplication of the given CGPoint with the scalar.
    static func *= (vector: inout SCNVector3, scalar: SceneKitFloat) {
        vector.x *= scalar
        vector.y *= scalar
        vector.z *= scalar
    }

    /// SwifterSwift: Multiply a scalar with a SCNVector3.
    ///
    ///     3 * SCNVector3(10, 20, -30) -> SCNVector3(30, 60, -90)
    ///
    /// - Parameters:
    ///   - scalar: scalar value.
    ///   - vector: SCNVector3 to multiply.
    /// - Returns: result of multiplication of the given CGPoint with the scalar.
    static func * (scalar: SceneKitFloat, vector: SCNVector3) -> SCNVector3 {
        return SCNVector3(vector.x * scalar, vector.y * scalar, vector.z * scalar)
    }

    /// SwifterSwift: Divide a SCNVector3 with a scalar.
    ///
    ///     SCNVector3(10, 20, -30) / 3 -> SCNVector3(3/10, 0.15, -30)
    ///
    /// - Parameters:
    ///   - vector: SCNVector3 to divide.
    ///   - scalar: scalar value.
    /// - Returns: result of division of the given SCNVector3 with the scalar.
    static func / (vector: SCNVector3, scalar: SceneKitFloat) -> SCNVector3 {
        return SCNVector3(vector.x / scalar, vector.y / scalar, vector.z / scalar)
    }

    /// SwifterSwift: Divide self with a scalar.
    ///
    ///     SCNVector3(10, 20, -30) /= 3 -> SCNVector3(3/10, 0.15, -30)
    ///
    /// - Parameters:
    ///   - vector: `self`.
    ///   - scalar: scalar value.
    /// - Returns: result of division of the given CGPoint with the scalar.
    static func /= (vector: inout SCNVector3, scalar: SceneKitFloat) {
        vector = SCNVector3(vector.x / scalar, vector.y / scalar, vector.z / scalar)
    }
}

#endif
