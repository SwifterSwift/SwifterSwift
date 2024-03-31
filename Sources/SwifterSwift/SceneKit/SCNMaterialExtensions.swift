// SCNMaterialExtensions.swift - Copyright 2024 SwifterSwift

#if canImport(SceneKit)
import SceneKit

// MARK: - Methods

public extension SCNMaterial {
    /// SwifterSwift: Initializes a SCNMaterial with a specific diffuse color.
    ///
    /// - Parameter color: diffuse color.
    convenience init(color: SFColor) {
        self.init()
        diffuse.contents = color
    }
}

#endif
