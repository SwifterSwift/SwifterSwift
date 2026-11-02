// MKMapView+ZoomTests.swift - Copyright 2026 SwifterSwift

#if canImport(MapKit) && !os(watchOS)
import CoreGraphics
import CoreLocation
import MapKit
import SwifterSwiftMapKit
import Testing
#if canImport(UIKit)
import UIKit
#else
import Foundation
#endif

@MainActor
struct MKMapViewZoomTests {
    /// Records the calls `zoom(to:meters:edgePadding:animated:)` makes, and still forwards them to the map view.
    final class RecordingMapView: MKMapView {
        struct VisibleMapRectCall {
            let mapRect: MKMapRect
            let padding: [CGFloat]
            let animated: Bool
        }

        struct CenterCall {
            let coordinate: CLLocationCoordinate2D
            let animated: Bool
        }

        var visibleMapRectCalls: [VisibleMapRectCall] = []
        var centerCalls: [CenterCall] = []

        #if canImport(UIKit)
        override func setVisibleMapRect(
            _ mapRect: MKMapRect,
            edgePadding insets: UIEdgeInsets,
            animated animate: Bool
        ) {
            let padding = [insets.top, insets.left, insets.bottom, insets.right]
            visibleMapRectCalls.append(VisibleMapRectCall(mapRect: mapRect, padding: padding, animated: animate))
            super.setVisibleMapRect(mapRect, edgePadding: insets, animated: animate)
        }
        #else
        override func setVisibleMapRect(
            _ mapRect: MKMapRect,
            edgePadding insets: NSEdgeInsets,
            animated animate: Bool
        ) {
            let padding = [insets.top, insets.left, insets.bottom, insets.right]
            visibleMapRectCalls.append(VisibleMapRectCall(mapRect: mapRect, padding: padding, animated: animate))
            super.setVisibleMapRect(mapRect, edgePadding: insets, animated: animate)
        }
        #endif

        override func setCenter(_ coordinate: CLLocationCoordinate2D, animated: Bool) {
            centerCalls.append(CenterCall(coordinate: coordinate, animated: animated))
            super.setCenter(coordinate, animated: animated)
        }
    }

    #if canImport(UIKit)
    let padding = UIEdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
    #else
    let padding = NSEdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
    #endif

    let gaziantep = CLLocationCoordinate2D(latitude: 36.9751, longitude: 38.4243)
    let kilis = CLLocationCoordinate2D(latitude: 36.7184, longitude: 37.1212)
    let istanbul = CLLocationCoordinate2D(latitude: 41.00527, longitude: 28.97696)

    func makeMapView() -> RecordingMapView {
        RecordingMapView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
    }

    /// The size of a map rectangle, in meters, at its center.
    func sizeInMeters(of rect: MKMapRect) -> (width: Double, height: Double) {
        let center = MKMapPoint(x: rect.midX, y: rect.midY)
        let pointsPerMeter = MKMapPointsPerMeterAtLatitude(center.coordinate.latitude)
        return (rect.width / pointsPerMeter, rect.height / pointsPerMeter)
    }

    @Test
    func doesNothingForNoCoordinates() {
        let mapView = makeMapView()
        let before = mapView.visibleMapRect
        mapView.zoom(to: [], meters: 500, animated: false)
        #expect(mapView.visibleMapRectCalls.isEmpty)
        #expect(mapView.centerCalls.isEmpty)
        #expect(MKMapRectEqualToRect(mapView.visibleMapRect, before))
    }

    @Test
    func doesNothingWhenEveryCoordinateIsInvalid() {
        let mapView = makeMapView()
        let invalid = [
            kCLLocationCoordinate2DInvalid,
            CLLocationCoordinate2D(latitude: 100, longitude: 0),
            CLLocationCoordinate2D(latitude: .nan, longitude: 0),
            CLLocationCoordinate2D(latitude: 0, longitude: .infinity)
        ]
        mapView.zoom(to: invalid, meters: 500, animated: false)
        #expect(mapView.visibleMapRectCalls.isEmpty)
        #expect(mapView.centerCalls.isEmpty)
    }

    @Test
    func showsMetersAroundASingleCoordinate() throws {
        let mapView = makeMapView()
        mapView.zoom(to: [gaziantep], meters: 500, animated: false)
        let call = try #require(mapView.visibleMapRectCalls.last)
        let size = sizeInMeters(of: call.mapRect)
        #expect(abs(size.width - 500) < 1e-6)
        #expect(abs(size.height - 500) < 1e-6)
        let center = MKMapPoint(x: call.mapRect.midX, y: call.mapRect.midY).coordinate
        #expect(abs(center.latitude - gaziantep.latitude) < 1e-9)
        #expect(abs(center.longitude - gaziantep.longitude) < 1e-9)
        #expect(mapView.visibleMapRect.contains(MKMapPoint(gaziantep)))
        let visible = sizeInMeters(of: mapView.visibleMapRect)
        #expect(abs(visible.width - 500) < 25)
    }

    @Test(arguments: [true, false])
    func passesTheAnimatedFlagForASingleCoordinate(_ animated: Bool) throws {
        let mapView = makeMapView()
        mapView.zoom(to: [gaziantep], meters: 500, animated: animated)
        let call = try #require(mapView.visibleMapRectCalls.last)
        #expect(call.animated == animated)
    }

    @Test(arguments: [true, false])
    func passesTheAnimatedFlagForSeveralCoordinates(_ animated: Bool) throws {
        let mapView = makeMapView()
        mapView.zoom(to: [gaziantep, kilis, istanbul], meters: 500, animated: animated)
        let call = try #require(mapView.visibleMapRectCalls.last)
        #expect(call.animated == animated)
    }

    @Test
    func passesTheEdgePaddingForASingleCoordinate() throws {
        let mapView = makeMapView()
        mapView.zoom(to: [gaziantep], meters: 500, edgePadding: padding, animated: false)
        let call = try #require(mapView.visibleMapRectCalls.last)
        #expect(call.padding == [10, 20, 30, 40])
    }

    @Test
    func passesTheEdgePaddingForSeveralCoordinates() throws {
        let mapView = makeMapView()
        mapView.zoom(to: [gaziantep, istanbul], meters: 500, edgePadding: padding, animated: false)
        let call = try #require(mapView.visibleMapRectCalls.last)
        #expect(call.padding == [10, 20, 30, 40])
    }

    @Test
    func usesNoEdgePaddingByDefault() throws {
        let mapView = makeMapView()
        mapView.zoom(to: [gaziantep, istanbul], meters: 500, animated: false)
        let call = try #require(mapView.visibleMapRectCalls.last)
        #expect(call.padding == [0, 0, 0, 0])
    }

    @Test
    func showsEveryCoordinate() throws {
        let mapView = makeMapView()
        let coordinates = [gaziantep, kilis, istanbul]
        mapView.zoom(to: coordinates, meters: 500, edgePadding: padding, animated: false)
        let call = try #require(mapView.visibleMapRectCalls.last)
        for coordinate in coordinates {
            #expect(call.mapRect.contains(MKMapPoint(coordinate)))
            #expect(mapView.visibleMapRect.contains(MKMapPoint(coordinate)))
        }
    }

    @Test
    func requestsTheBoundingRectangleOfDistantCoordinates() throws {
        let mapView = makeMapView()
        mapView.zoom(to: [gaziantep, kilis, istanbul], meters: 1, animated: false)
        let call = try #require(mapView.visibleMapRectCalls.last)
        let points = [gaziantep, kilis, istanbul].map(MKMapPoint.init)
        #expect(call.mapRect.minX == points.map(\.x).min())
        #expect(call.mapRect.maxX == points.map(\.x).max())
        #expect(call.mapRect.minY == points.map(\.y).min())
        #expect(call.mapRect.maxY == points.map(\.y).max())
    }

    @Test
    func appliesTheMinimumSizeToCloseCoordinates() throws {
        let mapView = makeMapView()
        let nearby = CLLocationCoordinate2D(latitude: gaziantep.latitude, longitude: gaziantep.longitude + 0.0001)
        mapView.zoom(to: [gaziantep, nearby], meters: 1_000, animated: false)
        let call = try #require(mapView.visibleMapRectCalls.last)
        let size = sizeInMeters(of: call.mapRect)
        #expect(abs(size.width - 1_000) < 1e-6)
        #expect(abs(size.height - 1_000) < 1e-6)
        #expect(call.mapRect.contains(MKMapPoint(gaziantep)))
        #expect(call.mapRect.contains(MKMapPoint(nearby)))
    }

    @Test
    func appliesTheMinimumSizeToEachSideSeparately() throws {
        let mapView = makeMapView()
        let east = CLLocationCoordinate2D(latitude: gaziantep.latitude, longitude: gaziantep.longitude + 1)
        mapView.zoom(to: [gaziantep, east], meters: 1_000, animated: false)
        let call = try #require(mapView.visibleMapRectCalls.last)
        let size = sizeInMeters(of: call.mapRect)
        #expect(size.width > 80_000)
        #expect(abs(size.height - 1_000) < 1e-6)
    }

    @Test
    func treatsRepeatedCoordinatesLikeOne() throws {
        let mapView = makeMapView()
        mapView.zoom(to: [gaziantep, gaziantep, gaziantep], meters: 500, animated: false)
        let repeated = try #require(mapView.visibleMapRectCalls.last)
        mapView.zoom(to: [gaziantep], meters: 500, animated: false)
        let single = try #require(mapView.visibleMapRectCalls.last)
        #expect(MKMapRectEqualToRect(repeated.mapRect, single.mapRect))
    }

    @Test
    func ignoresInvalidCoordinatesAmongValidOnes() throws {
        let mapView = makeMapView()
        mapView.zoom(to: [gaziantep, kCLLocationCoordinate2DInvalid, istanbul], meters: 500, animated: false)
        let withInvalid = try #require(mapView.visibleMapRectCalls.last)
        mapView.zoom(to: [gaziantep, istanbul], meters: 500, animated: false)
        let validOnly = try #require(mapView.visibleMapRectCalls.last)
        #expect(MKMapRectEqualToRect(withInvalid.mapRect, validOnly.mapRect))
    }

    @Test(arguments: [0.0, -500, .nan, .infinity, -.infinity])
    func centersASingleCoordinateWhenMetersIsInvalid(_ meters: Double) throws {
        let mapView = makeMapView()
        mapView.zoom(to: [gaziantep], meters: meters, animated: true)
        #expect(mapView.visibleMapRectCalls.isEmpty)
        let call = try #require(mapView.centerCalls.last)
        #expect(abs(call.coordinate.latitude - gaziantep.latitude) < 1e-9)
        #expect(abs(call.coordinate.longitude - gaziantep.longitude) < 1e-9)
        #expect(call.animated)
    }

    @Test(arguments: [0.0, -500, .nan, .infinity])
    func showsSeveralCoordinatesWhenMetersIsInvalid(_ meters: Double) throws {
        let mapView = makeMapView()
        mapView.zoom(to: [gaziantep, istanbul], meters: meters, animated: false)
        let call = try #require(mapView.visibleMapRectCalls.last)
        #expect(call.mapRect.contains(MKMapPoint(gaziantep)))
        #expect(call.mapRect.contains(MKMapPoint(istanbul)))
    }

    @Test
    func acceptsCoordinatesOnBothSidesOfTheAntimeridian() throws {
        let mapView = makeMapView()
        let west = CLLocationCoordinate2D(latitude: -17, longitude: 179)
        let east = CLLocationCoordinate2D(latitude: -14, longitude: -172)
        mapView.zoom(to: [west, east], meters: 500, animated: false)
        let call = try #require(mapView.visibleMapRectCalls.last)
        #expect(call.mapRect.contains(MKMapPoint(west)))
        #expect(call.mapRect.contains(MKMapPoint(east)))
    }
}
#endif
