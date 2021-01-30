// SCNCylinderExtensions.swift - Copyright 2020 SwifterSwift

#if canImport(SceneKit)
import SceneKit

// MARK: - Methods

public extension SCNCylinder {
    /// SwifterSwift: Creates a cylinder geometry with the specified diameter and height.
    ///
    /// - Parameters:
    ///   - diameter: The diameter of the cylinder’s circular cross section in the x- and z-axis dimensions of its local coordinate space.
    ///   - height: The height of the cylinder along the y-axis of its local coordinate space.
    convenience init(diameter: CGFloat, height: CGFloat) {
        self.init(radius: diameter / 2, height: height)
    }

    /// SwifterSwift: Creates a cylinder geometry with the specified radius, height and material.
    ///
    /// - Parameters:
    ///   - radius: The radius of the cylinder’s circular cross section in the x- and z-axis dimensions of its local coordinate space.
    ///   - height: The height of the cylinder along the y-axis of its local coordinate space.
    ///   - material: The material of the geometry.
    convenience init(radius: CGFloat, height: CGFloat, material: SCNMaterial) {
        self.init(radius: radius, height: height)
        materials = [material]
    }

    /// SwifterSwift: Creates a cylinder geometry with the specified diameter, height and material.
    ///
    /// - Parameters:
    ///   - diameter: The diameter of the cylinder’s circular cross section in the x- and z-axis dimensions of its local coordinate space.
    ///   - height: The height of the cylinder along the y-axis of its local coordinate space.
    ///   - material: The material of the geometry.
    convenience init(diameter: CGFloat, height: CGFloat, material: SCNMaterial) {
        self.init(radius: diameter / 2, height: height)
        materials = [material]
    }

    /// SwifterSwift: Creates a cylinder geometry with the specified radius, height, and material color.
    ///
    /// - Parameters:
    ///   - radius: The radius of the cylinder’s circular cross section in the x- and z-axis dimensions of its local coordinate space.
    ///   - height: The height of the cylinder along the y-axis of its local coordinate space.
    ///   - color: The color of the geometry's material.
    convenience init(radius: CGFloat, height: CGFloat, color: Color) {
        self.init(radius: radius, height: height)
        materials = [SCNMaterial(color: color)]
    }

    /// SwifterSwift: Creates a cylinder geometry with the specified diameter, height, and material color.
    ///
    /// - Parameters:
    ///   - diameter: The diameter of the cylinder’s circular cross section in the x- and z-axis dimensions of its local coordinate space.
    ///   - height: The height of the cylinder along the y-axis of its local coordinate space.
    ///   - color: The color of the geometry's material.
    convenience init(diameter: CGFloat, height: CGFloat, color: Color) {
        self.init(radius: diameter / 2, height: height)
        materials = [SCNMaterial(color: color)]
    }
}

#endif
