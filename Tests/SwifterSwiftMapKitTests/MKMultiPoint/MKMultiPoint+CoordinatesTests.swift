// MKMultiPoint+CoordinatesTests.swift - Copyright 2026 SwifterSwift

#if canImport(MapKit)
import CoreLocation
import MapKit
import SwifterSwiftMapKit
import Testing

struct MKMultiPointCoordinatesTests {
    let route = [
        CLLocationCoordinate2D(latitude: 37.330514, longitude: -121.888863),
        CLLocationCoordinate2D(latitude: 37.330832, longitude: -121.888337),
        CLLocationCoordinate2D(latitude: 37.329599, longitude: -121.886859),
        CLLocationCoordinate2D(latitude: 37.330019, longitude: -121.885993),
        CLLocationCoordinate2D(latitude: 37.329767, longitude: -121.885813)
    ]

    func expectCoordinates(
        _ actual: [CLLocationCoordinate2D],
        equal expected: [CLLocationCoordinate2D],
        sourceLocation: SourceLocation = #_sourceLocation
    ) {
        #expect(actual.count == expected.count, sourceLocation: sourceLocation)
        let mismatches = zip(actual, expected).filter { lhs, rhs in
            // -180 and 180 are the same meridian.
            let longitudeDifference = abs(lhs.longitude - rhs.longitude)
            return abs(lhs.latitude - rhs.latitude) > 1e-9
                || min(longitudeDifference, abs(longitudeDifference - 360)) > 1e-9
        }
        #expect(mismatches.isEmpty, sourceLocation: sourceLocation)
    }

    @Test
    func returnsPolylineCoordinatesInOrder() {
        let polyline = MKPolyline(coordinates: route, count: route.count)
        expectCoordinates(polyline.coordinates, equal: route)
    }

    @Test
    func returnsPolygonCoordinatesInOrder() {
        let polygon = MKPolygon(coordinates: route, count: route.count)
        expectCoordinates(polygon.coordinates, equal: route)
    }

    @Test
    func leavesOutInteriorPolygons() {
        let hole = MKPolygon(coordinates: Array(route.prefix(3)), count: 3)
        let polygon = MKPolygon(coordinates: route, count: route.count, interiorPolygons: [hole])
        expectCoordinates(polygon.coordinates, equal: route)
    }

    @Test
    func returnsEmptyArrayForShapeWithoutPoints() {
        #expect(MKPolyline().coordinates.isEmpty)
        #expect(MKPolyline(coordinates: [], count: 0).coordinates.isEmpty)
        #expect(MKPolygon(coordinates: [], count: 0).coordinates.isEmpty)
    }

    @Test
    func returnsSinglePoint() {
        let polyline = MKPolyline(coordinates: [route[0]], count: 1)
        expectCoordinates(polyline.coordinates, equal: [route[0]])
    }

    @Test
    func keepsRepeatedPoints() {
        let points = [route[0], route[0], route[1], route[0]]
        let polyline = MKPolyline(coordinates: points, count: points.count)
        expectCoordinates(polyline.coordinates, equal: points)
    }

    @Test
    func keepsCoordinatesOnBothSidesOfTheAntimeridian() {
        let points = [
            CLLocationCoordinate2D(latitude: -17, longitude: 179.5),
            CLLocationCoordinate2D(latitude: -14, longitude: -172),
            CLLocationCoordinate2D(latitude: 60, longitude: -180),
            CLLocationCoordinate2D(latitude: -60, longitude: 0)
        ]
        let polyline = MKPolyline(coordinates: points, count: points.count)
        expectCoordinates(polyline.coordinates, equal: points)
    }

    @Test
    func clampsPolarLatitudesToTheMapProjection() throws {
        let points = [
            CLLocationCoordinate2D(latitude: 90, longitude: 0),
            CLLocationCoordinate2D(latitude: -90, longitude: 0)
        ]
        let polyline = MKPolyline(coordinates: points, count: points.count)
        let north = try #require(polyline.coordinates.first)
        let south = try #require(polyline.coordinates.last)
        #expect(north.latitude > 84 && north.latitude < 85.1)
        #expect(south.latitude < -84 && south.latitude > -85.1)
    }

    @Test
    func includesIntermediatePointsOfGeodesicPolyline() throws {
        let endpoints = [
            CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060),
            CLLocationCoordinate2D(latitude: 51.5074, longitude: -0.1278)
        ]
        let geodesic = MKGeodesicPolyline(coordinates: endpoints, count: endpoints.count)
        let coordinates = geodesic.coordinates
        #expect(coordinates.count == geodesic.pointCount)
        #expect(coordinates.count > 2)
        let first = try #require(coordinates.first)
        let last = try #require(coordinates.last)
        expectCoordinates([first, last], equal: endpoints)
    }

    @Test
    func handlesManyPoints() {
        let points = (0..<10_000).map {
            CLLocationCoordinate2D(latitude: Double($0 % 160) - 80, longitude: Double($0 % 360) - 180)
        }
        let polyline = MKPolyline(coordinates: points, count: points.count)
        expectCoordinates(polyline.coordinates, equal: points)
    }
}
#endif
