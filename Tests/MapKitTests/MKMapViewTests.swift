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
        let edgePadding = EdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
        let previous = mapView.visibleMapRect
        mapView.zoom(to: [], meter: meter, edgePadding: edgePadding, animated: true)

        XCTAssert(mapView.visibleMapRect.contains(previous))
    }

    func testWithOneItemArray() {
        let mapView = MKMapView()
        let meter = 500.0
        let oneItemArray = [CLLocationCoordinate2D(latitude: 36.9751, longitude: 38.4243)]
        let edgePadding = EdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
        mapView.zoom(to: oneItemArray, meter: meter, edgePadding: edgePadding, animated: true)

        let firstPoint = MKMapPoint(oneItemArray.first!)
        XCTAssert(mapView.visibleMapRect.contains(firstPoint))
    }

    func testWithMultiItemArray() {
        let mapView = MKMapView()
        let meter = 500.0
        let edgePadding = EdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
        let multiItemArray = [CLLocationCoordinate2D(latitude: 36.9751, longitude: 38.4243),
                              CLLocationCoordinate2D(latitude: 37.06622, longitude: 37.38332),
                              CLLocationCoordinate2D(latitude: 41.00527, longitude: 28.97696)]
        mapView.zoom(to: multiItemArray, meter: meter, edgePadding: edgePadding, animated: true)

        for location in multiItemArray {
            XCTAssert(mapView.visibleMapRect.contains(MKMapPoint(location)))
        }
    }
}

#endif

#endif
