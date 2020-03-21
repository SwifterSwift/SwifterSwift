//
//  CLLocationArrayExtensions.swift
//  SwifterSwift
//
//  Created by Trevor Phillips on 09/01/20.
//  Copyright © 2020 SwifterSwift
//

#if canImport(CoreLocation)
import CoreLocation

// MARK: - Methods
public extension Array where Element: CLLocation {

    /// SwifterSwift: Calculates the sum of distances between each location in the array based on the curvature of the earth.
    ///
    /// - Parameter unitLength: The unit of length to return the distance in.
    /// - Returns: The distance in the specified unit.
    @available(tvOS 10.0, macOS 10.12, watchOS 3.0, *)
    func distance(unitLength unit: UnitLength) -> Measurement<UnitLength> {
        guard count > 1 else {
          return Measurement(value: 0.0, unit: unit)
        }
        var distance = 0.0
        for idx in 0..<count-1 {
            distance += self[idx].distance(from: self[idx + 1])
        }
        return Measurement(value: distance, unit: UnitLength.meters).converted(to: unit)
    }

}

#endif
