// SCNCapsuleExtensions.swift - Copyright 2020 SwifterSwift

#if canImport(SceneKit)
import SceneKit

// MARK: - Methods

public extension SCNCapsule {
    /// SwifterSwift: Creates a capsule geometry with the specified diameter and height.
    ///
    /// - Parameters:
    ///   - capDiameter: The diameter both of the capsule’s cylindrical body and of its hemispherical ends.
    ///   - height: The height of the capsule along the y-axis of its local coordinate space.
    convenience init(capDiameter: CGFloat, height: CGFloat) {
        self.init(capRadius: capDiameter / 2, height: height)
    }

    /// SwifterSwift: Creates a capsule geometry with the specified radius and height.
    ///
    /// - Parameters:
    ///   - capRadius: The radius both of the capsule’s cylindrical body and of its hemispherical ends.
    ///   - height: The height of the capsule along the y-axis of its local coordinate space.
    ///   - material: The material of the geometry.
    convenience init(capRadius: CGFloat, height: CGFloat, material: SCNMaterial) {
        self.init(capRadius: capRadius, height: height)
        materials = [material]
    }

    /// SwifterSwift: Creates a capsule geometry with the specified diameter and height.
    ///
    /// - Parameters:
    ///   - capDiameter: The diameter both of the capsule’s cylindrical body and of its hemispherical ends.
    ///   - height: The height of the capsule along the y-axis of its local coordinate space.
    ///   - material: The material of the geometry.
    convenience init(capDiameter: CGFloat, height: CGFloat, material: SCNMaterial) {
        self.init(capRadius: capDiameter / 2, height: height)
        materials = [material]
    }

    /// SwifterSwift: Creates a capsule geometry with the specified radius and height.
    ///
    /// - Parameters:
    ///   - capRadius: The radius both of the capsule’s cylindrical body and of its hemispherical ends.
    ///   - height: The height of the capsule along the y-axis of its local coordinate space.
    ///   - material: The material of the geometry.
    convenience init(capRadius: CGFloat, height: CGFloat, color: Color) {
        self.init(capRadius: capRadius, height: height)
        materials = [SCNMaterial(color: color)]
    }

    /// SwifterSwift: Creates a capsule geometry with the specified diameter and height.
    ///
    /// - Parameters:
    ///   - capDiameter: The diameter both of the capsule’s cylindrical body and of its hemispherical ends.
    ///   - height: The height of the capsule along the y-axis of its local coordinate space.
    ///   - material: The material of the geometry.
    convenience init(capDiameter: CGFloat, height: CGFloat, color: Color) {
        self.init(capRadius: capDiameter / 2, height: height)
        materials = [SCNMaterial(color: color)]
    }
}

#endif
