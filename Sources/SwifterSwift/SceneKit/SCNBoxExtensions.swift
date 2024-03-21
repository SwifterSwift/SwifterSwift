// SCNBoxExtensions.swift - Copyright 2024 SwifterSwift

#if canImport(SceneKit)
import SceneKit

// MARK: - Methods

public extension SCNBox {
    /// SwifterSwift: Creates a box geometry with the specified width, height, and length.
    ///
    /// - Parameters:
    ///   - width: The width of the box along the x-axis of its local coordinate space.
    ///   - height: The height of the box along the y-axis of its local coordinate space.
    ///   - length: The length of the box along the z-axis of its local coordinate space.
    convenience init(width: CGFloat, height: CGFloat, length: CGFloat) {
        self.init(width: width, height: height, length: length, chamferRadius: 0)
    }

    /// SwifterSwift: Creates a cube geometry with the specified side length, and chamfer radius.
    ///
    /// - Parameters:
    ///   - sideLength: The width, height, and length of the box in its local coordinate space.
    ///   - chamferRadius: The radius of curvature for the edges and corners of the box.
    convenience init(sideLength: CGFloat, chamferRadius: CGFloat = 0) {
        self.init(width: sideLength, height: sideLength, length: sideLength, chamferRadius: chamferRadius)
    }

    /// SwifterSwift: Creates a box geometry with the specified width, height, length, chamfer radius, and material.
    ///
    /// - Parameters:
    ///   - width: The width of the box along the x-axis of its local coordinate space.
    ///   - height: The height of the box along the y-axis of its local coordinate space.
    ///   - length: The length of the box along the z-axis of its local coordinate space.
    ///   - chamferRadius: The radius of curvature for the edges and corners of the box.
    ///   - material: The material of the geometry.
    convenience init(
        width: CGFloat,
        height: CGFloat,
        length: CGFloat,
        chamferRadius: CGFloat = 0,
        material: SCNMaterial) {
        self.init(width: width, height: height, length: length, chamferRadius: chamferRadius)
        materials = [material]
    }

    /// SwifterSwift: Creates a cube geometry with the specified side length, chamfer radius, and material.
    ///
    /// - Parameters:
    ///   - sideLength: The width, height, and length of the box in its local coordinate space.
    ///   - chamferRadius: The radius of curvature for the edges and corners of the box.
    ///   - material: The material of the geometry.
    convenience init(sideLength: CGFloat, chamferRadius: CGFloat = 0, material: SCNMaterial) {
        self.init(width: sideLength, height: sideLength, length: sideLength, chamferRadius: chamferRadius)
        materials = [material]
    }

    /// SwifterSwift: Creates a box geometry with the specified width, height, length, chamfer radius, and material
    /// color.
    ///
    /// - Parameters:
    ///   - width: The width of the box along the x-axis of its local coordinate space.
    ///   - height: The height of the box along the y-axis of its local coordinate space.
    ///   - length: The length of the box along the z-axis of its local coordinate space.
    ///   - chamferRadius: The radius of curvature for the edges and corners of the box.
    ///   - color: The color of the geometry's material.
    convenience init(width: CGFloat, height: CGFloat, length: CGFloat, chamferRadius: CGFloat = 0, color: SFColor) {
        self.init(width: width, height: height, length: length, chamferRadius: chamferRadius)
        materials = [SCNMaterial(color: color)]
    }

    /// SwifterSwift: Creates a cube geometry with the specified side length, chamfer radius, and material color.
    ///
    /// - Parameters:
    ///   - sideLength: The width, height, and length of the box in its local coordinate space.
    ///   - chamferRadius: The radius of curvature for the edges and corners of the box.
    ///   - color: The color of the geometry's material.
    convenience init(sideLength: CGFloat, chamferRadius: CGFloat = 0, color: SFColor) {
        self.init(width: sideLength, height: sideLength, length: sideLength, chamferRadius: chamferRadius)
        materials = [SCNMaterial(color: color)]
    }
}

#endif
