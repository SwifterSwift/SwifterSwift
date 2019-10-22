//
//  CAGradientLayerExtensions.swift
//  SwifterSwift
//
//  Created by Jay Mehta on 11/10/19.
//  Copyright © 2019 SwifterSwift
//

#if !os(watchOS) && !os(Linux) && canImport(QuartzCore)
import QuartzCore

extension CAGradientLayer {

    /// SwifterSwift: Creates a CAGradientLayer with the specified colors, location, startPoint, endPoint, and type.
    /// - Parameter colors: An array of colors defining the color of each gradient stop
    /// - Parameter locations: An array of NSNumber defining the location of each
    ///                gradient stop as a value in the range [0,1]. The values must be
    ///                monotonically increasing. If a nil array is given, the stops are
    ///                assumed to spread uniformly across the [0,1] range. When rendered,
    ///                the colors are mapped to the output colorspace before being
    ///                interpolated. (default is nil)
    /// - Parameter startPoint: start point corresponds to the first gradient stop (I.e. [0,0] is the bottom-corner of the layer, [1,1] is the top-right corner.)
    /// - Parameter endPoint: end point corresponds to the last gradient stop
    /// - Parameter type: The kind of gradient that will be drawn. Currently, the only allowed values are `axial' (the default value), `radial', and `conic'.
    convenience init(colors: [Color], locations: [CGFloat]? = nil, startPoint: CGPoint, endPoint: CGPoint, type: CAGradientLayerType = .axial) {
        self.init()
        self.colors =  colors.map { $0.cgColor }
        self.locations = locations?.map { NSNumber(value: Double($0)) }
        self.startPoint = startPoint
        self.endPoint = endPoint
        self.type = type
    }

}

#endif
