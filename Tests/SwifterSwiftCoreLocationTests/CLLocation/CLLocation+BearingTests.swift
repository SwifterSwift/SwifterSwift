// CLLocation+BearingTests.swift - Copyright 2026 SwifterSwift

#if canImport(CoreLocation)
import CoreLocation
import SwifterSwiftCoreLocation
import Testing

struct CLLocationBearingTests {
    @Test
    func returnsInitialBearing() throws {
        let start = CLLocation(latitude: 38.6318909290283, longitude: -90.2828979492187)
        let end = CLLocation(latitude: 38.5352759115441, longitude: -89.8448181152343)
        let bearing = try #require(start.bearing(to: end))
        #expect(abs(bearing - 105.619) < 0.001)
    }

    @Test(arguments: [(10.0, 0.0, 0.0), (0, 10, 90), (-10, 0, 180), (0, -10, 270), (90, 0, 0), (-90, 0, 180)])
    func returnsCardinalDirections(latitude: Double, longitude: Double, expected: Double) throws {
        let origin = CLLocation(latitude: 0, longitude: 0)
        let bearing = try #require(origin.bearing(to: CLLocation(latitude: latitude, longitude: longitude)))
        #expect(abs(bearing - expected) < 1e-9)
    }

    @Test
    func takesTheShortWayAcrossTheAntimeridian() throws {
        let west = CLLocation(latitude: 0, longitude: 179)
        let east = CLLocation(latitude: 0, longitude: -179)
        let eastward = try #require(west.bearing(to: east))
        let westward = try #require(east.bearing(to: west))
        #expect(abs(eastward - 90) < 1e-9)
        #expect(abs(westward - 270) < 1e-9)
    }

    @Test
    func isNotTheOppositeOfTheBearingBackOnALongPath() throws {
        let newYork = CLLocation(latitude: 40.7128, longitude: -74.0060)
        let london = CLLocation(latitude: 51.5074, longitude: -0.1278)
        let there = try #require(newYork.bearing(to: london))
        let back = try #require(london.bearing(to: newYork))
        #expect(abs(there - 51.2126) < 1e-4)
        #expect(abs(back - 288.3297) < 1e-4)
    }

    @Test(arguments: [
        (0.0, 0.0, 10.0, -1e-13),
        (0, 0, -10, 1e-13),
        (45, 90, 45, 89.999999),
        (-45, -90, -44, -90),
        (89.9, 0, 89.9, 180),
        (-89.9, 10, -89.9, -170)
    ])
    func staysInHalfOpenRange(latitude1: Double, longitude1: Double, latitude2: Double, longitude2: Double) throws {
        let start = CLLocation(latitude: latitude1, longitude: longitude1)
        let end = CLLocation(latitude: latitude2, longitude: longitude2)
        let bearing = try #require(start.bearing(to: end))
        #expect(bearing >= 0)
        #expect(bearing < 360)
    }

    @Test(arguments: [(0.0, 0.0), (38.6, -90.3), (-33.86, 151.2), (90, 0), (0, 180)])
    func returnsNilForTheSameCoordinate(latitude: Double, longitude: Double) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        #expect(location.bearing(to: location) == nil)
        #expect(location.bearing(to: CLLocation(latitude: latitude, longitude: longitude)) == nil)
    }

    @Test(arguments: [
        CLLocationCoordinate2D(latitude: 100, longitude: 0),
        CLLocationCoordinate2D(latitude: 0, longitude: -180.000001),
        CLLocationCoordinate2D(latitude: .nan, longitude: 0),
        CLLocationCoordinate2D(latitude: 0, longitude: .nan),
        CLLocationCoordinate2D(latitude: -.infinity, longitude: 0),
        kCLLocationCoordinate2DInvalid
    ])
    func returnsNilForInvalidCoordinates(_ invalid: CLLocationCoordinate2D) {
        let valid = CLLocation(latitude: 10, longitude: 10)
        let location = CLLocation(latitude: invalid.latitude, longitude: invalid.longitude)
        #expect(valid.bearing(to: location) == nil)
        #expect(location.bearing(to: valid) == nil)
    }
}
#endif
