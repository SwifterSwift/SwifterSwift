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
    /// - Parameter unit: The unit of length to return the distance in.
    /// - Returns: The distance in the specified unit.
    @available(iOS 10.0, *)
    func distance(unit: UnitLength) -> Measurement<UnitLength> {
        let distance = self.enumerated().reduce(0.0) {
            if $1.1 == self.last { return $0 }
            return $0 + $1.1.distance(from: self[$1.0 + 1])
        }
        return Measurement(value: distance, unit: UnitLength.meters).converted(to: unit)
    }

}

#endif
