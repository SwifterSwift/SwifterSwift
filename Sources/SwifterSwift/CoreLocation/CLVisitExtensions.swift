//
//  CLVisitExtensions.swift
//  SwifterSwift
//
//  Created by Trevor Phillips on 09/01/20.
//  Copyright © 2020 SwifterSwift
//

#if canImport(CoreLocation)
import CoreLocation

// MARK: - Properties
@available(iOS 8.0, *)
public extension CLVisit {

    /// SwifterSwift: Retrieves a visit's location.
    ///
    /// - Returns: CLLocation
    var location: CLLocation {
        return CLLocation(latitude: self.coordinate.latitude, longitude: self.coordinate.longitude)
    }

}

#endif
