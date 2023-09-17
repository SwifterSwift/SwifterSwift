// SCNPlaneExtensions.swift - Copyright 2023 SwifterSwift

#if canImport(SceneKit)
import SceneKit

// MARK: - Methods

public extension SCNPlane {
    /// SwifterSwift: Creates a square plane geometry with the specified width.
    ///
    /// - Parameter width: The width and height of the plane along the x-axis and y-axis of its local coordinate space.
    convenience init(width: CGFloat) {
        self.init(width: width, height: width)
    }

    /// SwifterSwift: Creates a plane geometry with the specified width, height and material.
    ///
    /// - Parameters:
    ///   - width: The width of the plane along the x-axis of its local coordinate space.
    ///   - height: The height of the plane along the y-axis of its local coordinate space.
    ///   - material: The material of the geometry.
    convenience init(width: CGFloat, height: CGFloat, material: SCNMaterial) {
        self.init(width: width, height: height)
        materials = [material]
    }

    /// SwifterSwift: Creates a square plane geometry with the specified width and material.
    ///
    /// - Parameters:
    ///   - width: The width and height of the plane along the x-axis and y-axis of its local coordinate space.
    ///   - material: The material of the geometry.
    convenience init(width: CGFloat, material: SCNMaterial) {
        self.init(width: width, height: width)
        materials = [material]
    }

    /// SwifterSwift: Creates a plane geometry with the specified width, height and material color.
    ///
    /// - Parameters:
    ///   - width: The width of the plane along the x-axis of its local coordinate space.
    ///   - height: The height of the plane along the y-axis of its local coordinate space.
    ///   - color: The color of the geometry's material.
    convenience init(width: CGFloat, height: CGFloat, color: SFColor) {
        self.init(width: width, height: height)
        materials = [SCNMaterial(color: color)]
    }

    /// SwifterSwift: Creates a square plane geometry with the specified width and material color.
    ///
    /// - Parameters:
    ///   - width: The width and height of the plane along the x-axis and y-axis of its local coordinate space.
    ///   - color: The color of the geometry's material.
    convenience init(width: CGFloat, color: SFColor) {
        self.init(width: width, height: width)
        materials = [SCNMaterial(color: color)]
    }
}

#endif
