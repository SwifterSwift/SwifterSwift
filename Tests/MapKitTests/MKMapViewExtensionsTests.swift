// MKMapViewExtensionsTests.swift - Copyright 2024 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(MapKit)
import struct CoreLocation.CLLocationCoordinate2D
import MapKit

final class MKMapViewExtensionsTests: XCTestCase {
    func testRegister() {
        let mapView = MKMapView()

        mapView.register(annotationViewWithClass: annotationViewType)
        let annotationView = mapView.dequeueReusableAnnotationView(withClass: annotationViewType)
        XCTAssertNotNil(annotationView)
    }

    func testRegisterAndDequeue() {
        let mapView = MKMapView()
        let annotation = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))

        mapView.register(annotationViewWithClass: annotationViewType)
        let annotationViewWithAnnotation = mapView.dequeueReusableAnnotationView(
            withClass: annotationViewType,
            for: annotation)
        XCTAssertNotNil(annotationViewWithAnnotation)
    }

    func testWithEmptyItemArray() {
        let mapView = MKMapView()
        let meter = 500.0
        let edgePadding = SFEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
        let previous = mapView.visibleMapRect
        mapView.zoom(to: [], meter: meter, edgePadding: edgePadding, animated: true)

        XCTAssert(mapView.visibleMapRect.contains(previous))
    }

    func testWithOneItemArray() {
        let mapView = MKMapView()
        let meter = 500.0
        let oneItemArray = [CLLocationCoordinate2D(latitude: 36.9751, longitude: 38.4243)]
        let edgePadding = SFEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
        mapView.zoom(to: oneItemArray, meter: meter, edgePadding: edgePadding, animated: true)

        let firstPoint = MKMapPoint(oneItemArray.first!)
        XCTAssert(mapView.visibleMapRect.contains(firstPoint))
    }

    func testWithMultiItemArray() {
        let mapView = MKMapView()
        let meter = 500.0
        let edgePadding = SFEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
        let multiItemArray = [CLLocationCoordinate2D(latitude: 36.9751, longitude: 38.4243),
                              CLLocationCoordinate2D(latitude: 37.06622, longitude: 37.38332),
                              CLLocationCoordinate2D(latitude: 41.00527, longitude: 28.97696)]
        mapView.zoom(to: multiItemArray, meter: meter, edgePadding: edgePadding, animated: true)

        for location in multiItemArray {
            XCTAssert(mapView.visibleMapRect.contains(MKMapPoint(location)))
        }
    }

    private var annotationViewType: MKAnnotationView.Type {
        if #available(macOS 13, iOS 16, *) {
            return MKMarkerAnnotationView.self
        } else {
            return MKPinAnnotationView.self
        }
    }
}

#endif
