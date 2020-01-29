//
//  CLVisitExtensions.swift
//  SwifterSwift
//
//  Created by Trevor Phillips on 09/01/20.
//  Copyright © 2020 SwifterSwift
//

#if canImport(CoreLocation) && (os(iOS) || targetEnvironment(macCatalyst))
import CoreLocation

// MARK: - Properties
public extension CLVisit {

    /// SwifterSwift: Retrieves a visit's location.
    ///
    /// - Returns: CLLocation
    var location: CLLocation {
        return CLLocation(latitude: self.coordinate.latitude, longitude: self.coordinate.longitude)
    }

}

#endif
