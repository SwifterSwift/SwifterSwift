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
    @available(iOS 10.0, tvOS 10.0, macOS 10.12, watchOS 3.0, *)
    func distance(unitLength unit: UnitLength) -> Measurement<UnitLength> {
        let distance = self.enumerated().reduce(0.0) { (sum, position) in
            let (index, location) = position
            if location == self.last { return sum }
            return sum + location.distance(from: self[index + 1])
        }
        return Measurement(value: distance, unit: UnitLength.meters).converted(to: unit)
    }

}

#endif
