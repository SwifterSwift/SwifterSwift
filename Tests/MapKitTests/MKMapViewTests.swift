//
//  MKMapViewTests.swift
//  SwifterSwift
//
//  Created by Hannes Staffler on 24.01.19.
//  Copyright © 2019 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if canImport(MapKit)
import MapKit

import struct CoreLocation.CLLocationCoordinate2D

final class MKMapViewTests: XCTestCase {

    func testRegisterAndDequeue() {
        guard #available(iOS 11.0, *, tvOS 11.0, *, macOS 10.13) else {
            return
        }

        let mapView = MKMapView()
        let annotation = MKPlacemark(coordinate: CLLocationCoordinate2DMake(0, 0))

        mapView.register(annotationViewWithClass: MKPinAnnotationView.self)
        let annotationView = mapView.dequeueReusableAnnotationView(withClass: MKPinAnnotationView.self)
        XCTAssertNotNil(annotationView)
        let annotationViewWithAnnotation = mapView.dequeueReusableAnnotationView(withClass: MKPinAnnotationView.self, for: annotation)
        XCTAssertNotNil(annotationViewWithAnnotation)
    }

}

#endif
