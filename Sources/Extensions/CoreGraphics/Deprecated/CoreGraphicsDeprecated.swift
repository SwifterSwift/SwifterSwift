//
//  CoreGraphicsDeprecated.swift
//  SwifterSwift
//
//  Created by Luciano Almeida on 9/18/18.
//  Copyright © 2018 SwifterSwift
//
#if canImport(CoreGraphics)
import CoreGraphics

// MARK: - Methods
public extension CGFloat {

    /// SwifterSwift: Random CGFloat between two CGFloat values.
    ///
    /// - Parameters:
    ///   - min: minimum number to start random from.
    ///   - max: maximum number random number end before.
    /// - Returns: random CGFloat between two CGFloat values.
    @available(*, deprecated, message: "Use CGFloat.random(in: min...max)")
    static func randomBetween(min: CGFloat, max: CGFloat) -> CGFloat {
        return CGFloat.random(in: min...max)
    }

}
#endif
