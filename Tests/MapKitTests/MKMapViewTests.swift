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

#if !os(watchOS)
@available(tvOS 9.2, *)
final class MKMapViewTests: XCTestCase {

    @available(iOS 11.0, tvOS 11.0, macOS 10.13, *)
    func testRegister() {
        let mapView = MKMapView()

        mapView.register(annotationViewWithClass: MKPinAnnotationView.self)
        let annotationView = mapView.dequeueReusableAnnotationView(withClass: MKPinAnnotationView.self)
        XCTAssertNotNil(annotationView)
    }

    @available(iOS 11.0, tvOS 11.0, macOS 10.13, *)
    func testRegisterAndDequeue() {
        let mapView = MKMapView()
        let annotation = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))

        mapView.register(annotationViewWithClass: MKPinAnnotationView.self)
        let annotationViewWithAnnotation = mapView.dequeueReusableAnnotationView(withClass: MKPinAnnotationView.self, for: annotation)
        XCTAssertNotNil(annotationViewWithAnnotation)
    }
    
    func testWithEmptyItemArray() {
        let mapView = MKMapView()
        
        let meter = 500.0
        let emptyItemArray: [CLLocationCoordinate2D] = []
        let edgePadding: UIEdgeInsets = .init(top: 50, left: 50, bottom: 50, right: 50)
        
        let emptyItemInMapView: Void = mapView.zoom(coordinates: emptyItemArray, meter: meter, edgePadding: edgePadding, animated: true)
        XCTAssertNotNil(emptyItemInMapView)
    }
    
    func testWithOneItemArray() {
        let mapView = MKMapView()
        
        let meter = 500.0
        let oneItemArray: [CLLocationCoordinate2D] = [.init(latitude: 36.9751, longitude: 38.4243)]
        let edgePadding: UIEdgeInsets = .init(top: 50, left: 50, bottom: 50, right: 50)
        
        let oneItemInMapView: Void = mapView.zoom(coordinates: oneItemArray, meter: meter, edgePadding: edgePadding, animated: true)
        XCTAssertNotNil(oneItemInMapView)
    }
}

#endif

#endif
