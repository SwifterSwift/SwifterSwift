// SCNConeExtensions.swift - Copyright 2024 SwifterSwift

#if canImport(SceneKit)
import SceneKit

// MARK: - Methods

public extension SCNCone {
    /// SwifterSwift: Creates a cone geometry with the given top diameter, bottom diameter, and height.
    ///
    /// - Parameters:
    ///   - topDiameter: The diameter of the cone’s top, forming a circle in the x- and z-axis dimensions of its local
    /// coordinate space.
    ///   - bottomDiameter: The diameter of the cone’s base, forming a circle in the x- and z-axis dimensions of its
    /// local coordinate space.
    ///   - height: The height of the cone along the y-axis of its local coordinate space.
    convenience init(topDiameter: CGFloat, bottomDiameter: CGFloat, height: CGFloat) {
        self.init(topRadius: topDiameter / 2, bottomRadius: bottomDiameter / 2, height: height)
    }

    /// SwifterSwift: Creates a cone geometry with the given top radius, bottom radius, height, and material.
    ///
    /// - Parameters:
    ///   - topRadius: The radius of the cone’s top, forming a circle in the x- and z-axis dimensions of its local
    /// coordinate space.
    ///   - bottomRadius: The radius of the cone’s base, forming a circle in the x- and z-axis dimensions of its local
    /// coordinate space.
    ///   - height: The height of the cone along the y-axis of its local coordinate space.
    ///   - material: The material of the geometry.
    convenience init(topRadius: CGFloat, bottomRadius: CGFloat, height: CGFloat, material: SCNMaterial) {
        self.init(topRadius: topRadius, bottomRadius: bottomRadius, height: height)
        materials = [material]
    }

    /// SwifterSwift: Creates a cone geometry with the given top diameter, bottom diameter, height, and material.
    ///
    /// - Parameters:
    ///   - topDiameter: The diameter of the cone’s top, forming a circle in the x- and z-axis dimensions of its local
    /// coordinate space.
    ///   - bottomDiameter: The diameter of the cone’s base, forming a circle in the x- and z-axis dimensions of its
    /// local coordinate space.
    ///   - height: The height of the cone along the y-axis of its local coordinate space.
    ///   - material: The material of the geometry.
    convenience init(topDiameter: CGFloat, bottomDiameter: CGFloat, height: CGFloat, material: SCNMaterial) {
        self.init(topRadius: topDiameter / 2, bottomRadius: bottomDiameter / 2, height: height)
        materials = [material]
    }

    /// SwifterSwift: Creates a cone geometry with the given top radius, bottom radius, height, and material.
    ///
    /// - Parameters:
    ///   - topRadius: The radius of the cone’s top, forming a circle in the x- and z-axis dimensions of its local
    /// coordinate space.
    ///   - bottomRadius: The radius of the cone’s base, forming a circle in the x- and z-axis dimensions of its local
    /// coordinate space.
    ///   - height: The height of the cone along the y-axis of its local coordinate space.
    ///   - color: The color of the geometry's material.
    convenience init(topRadius: CGFloat, bottomRadius: CGFloat, height: CGFloat, color: SFColor) {
        self.init(topRadius: topRadius, bottomRadius: bottomRadius, height: height)
        materials = [SCNMaterial(color: color)]
    }

    /// SwifterSwift: Creates a cone geometry with the given top diameter, bottom diameter, height, and material.
    ///
    /// - Parameters:
    ///   - topDiameter: The diameter of the cone’s top, forming a circle in the x- and z-axis dimensions of its local
    /// coordinate space.
    ///   - bottomDiameter: The diameter of the cone’s base, forming a circle in the x- and z-axis dimensions of its
    /// local coordinate space.
    ///   - height: The height of the cone along the y-axis of its local coordinate space.
    ///   - color: The color of the geometry's material.
    convenience init(topDiameter: CGFloat, bottomDiameter: CGFloat, height: CGFloat, color: SFColor) {
        self.init(topRadius: topDiameter / 2, bottomRadius: bottomDiameter / 2, height: height)
        materials = [SCNMaterial(color: color)]
    }
}

#endif
