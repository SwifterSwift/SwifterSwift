// CLLocation+MidpointTests.swift - Copyright 2026 SwifterSwift

#if canImport(CoreLocation)
import CoreLocation
import Foundation
import SwifterSwiftCoreLocation
import Testing

struct CLLocationMidpointTests {
    @Test
    func returnsHalfwayPointAlongGreatCircle() throws {
        let start = CLLocation(latitude: -15.822877, longitude: -47.941839)
        let end = CLLocation(latitude: -15.692030, longitude: -47.594397)
        let midpoint = try #require(start.midpoint(to: end))
        #expect(abs(midpoint.coordinate.latitude - -15.7575223324019) < 1e-12)
        #expect(abs(midpoint.coordinate.longitude - -47.7680620274339) < 1e-12)
    }

    @Test
    func isSymmetric() throws {
        let paris = CLLocation(latitude: 48.8566, longitude: 2.3522)
        let newYork = CLLocation(latitude: 40.7128, longitude: -74.0060)
        let there = try #require(paris.midpoint(to: newYork))
        let back = try #require(newYork.midpoint(to: paris))
        #expect(abs(there.coordinate.latitude - back.coordinate.latitude) < 1e-9)
        #expect(abs(there.coordinate.longitude - back.coordinate.longitude) < 1e-9)
        #expect(abs(there.coordinate.latitude - 51.5774) < 1e-4)
        #expect(abs(there.coordinate.longitude - -39.0069) < 1e-4)
    }

    @Test(arguments: [(0.0, 0.0), (48.8566, 2.3522), (-33.86, 151.2), (90, 0), (-90, 0), (0, 180), (0, -180)])
    func returnsSamePointForIdenticalLocations(latitude: Double, longitude: Double) throws {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let midpoint = try #require(location.midpoint(to: location))
        #expect(abs(midpoint.coordinate.latitude - latitude) < 1e-9)
        // -180 and 180 are the same meridian.
        let difference = abs(midpoint.coordinate.longitude - longitude)
        #expect(difference < 1e-9 || abs(difference - 360) < 1e-9)
    }

    @Test
    func averagesTheLatitudeAlongAMeridian() throws {
        let start = CLLocation(latitude: 10, longitude: 20)
        let end = CLLocation(latitude: 30, longitude: 20)
        let midpoint = try #require(start.midpoint(to: end))
        #expect(abs(midpoint.coordinate.latitude - 20) < 1e-9)
        #expect(abs(midpoint.coordinate.longitude - 20) < 1e-9)
    }

    @Test
    func averagesTheLongitudeAlongTheEquator() throws {
        let start = CLLocation(latitude: 0, longitude: -30)
        let end = CLLocation(latitude: 0, longitude: 90)
        let midpoint = try #require(start.midpoint(to: end))
        #expect(abs(midpoint.coordinate.latitude) < 1e-9)
        #expect(abs(midpoint.coordinate.longitude - 30) < 1e-9)
    }

    @Test
    func bulgesTowardThePoleAtTheSameLatitude() throws {
        let start = CLLocation(latitude: 50, longitude: 0)
        let end = CLLocation(latitude: 50, longitude: 40)
        let midpoint = try #require(start.midpoint(to: end))
        #expect(midpoint.coordinate.latitude > 50)
        #expect(abs(midpoint.coordinate.longitude - 20) < 1e-9)

        let southStart = CLLocation(latitude: -50, longitude: 0)
        let southEnd = CLLocation(latitude: -50, longitude: 40)
        let southMidpoint = try #require(southStart.midpoint(to: southEnd))
        #expect(southMidpoint.coordinate.latitude < -50)
    }

    @Test
    func crossesTheAntimeridian() throws {
        let fiji = CLLocation(latitude: -17, longitude: 179)
        let samoa = CLLocation(latitude: -14, longitude: -172)
        let midpoint = try #require(fiji.midpoint(to: samoa))
        #expect(abs(midpoint.coordinate.latitude - -15.5456) < 1e-4)
        #expect(abs(midpoint.coordinate.longitude - -176.4673) < 1e-4)

        let east = CLLocation(latitude: 0, longitude: 175)
        let west = CLLocation(latitude: 0, longitude: -170)
        let equatorMidpoint = try #require(east.midpoint(to: west))
        #expect(abs(equatorMidpoint.coordinate.longitude - -177.5) < 1e-9)
    }

    @Test(arguments: [(0.0, 175.0, 0.0, -175.0), (0, -175, 0, 175), (60, 170, -60, -170), (89, 179, 89, -179)])
    func keepsLongitudeInRange(latitude1: Double, longitude1: Double, latitude2: Double, longitude2: Double) throws {
        let start = CLLocation(latitude: latitude1, longitude: longitude1)
        let end = CLLocation(latitude: latitude2, longitude: longitude2)
        let midpoint = try #require(start.midpoint(to: end))
        #expect((-180...180).contains(midpoint.coordinate.longitude))
        #expect(CLLocationCoordinate2DIsValid(midpoint.coordinate))
    }

    @Test
    func returnsAPointForAntipodalLocations() throws {
        let start = CLLocation(latitude: 0, longitude: 0)
        let end = CLLocation(latitude: 0, longitude: 180)
        let midpoint = try #require(start.midpoint(to: end))
        #expect(CLLocationCoordinate2DIsValid(midpoint.coordinate))

        let northPole = CLLocation(latitude: 90, longitude: 0)
        let southPole = CLLocation(latitude: -90, longitude: 0)
        let equator = try #require(northPole.midpoint(to: southPole))
        #expect(abs(equator.coordinate.latitude) < 1e-9)
    }

    @Test
    func carriesOnlyTheCoordinate() throws {
        let start = CLLocation(
            coordinate: CLLocationCoordinate2D(latitude: 10, longitude: 10),
            altitude: 120,
            horizontalAccuracy: 5,
            verticalAccuracy: 3,
            course: 90,
            speed: 4,
            timestamp: Date(timeIntervalSince1970: 0)
        )
        let end = CLLocation(latitude: 12, longitude: 12)
        let midpoint = try #require(start.midpoint(to: end))
        #expect(midpoint.altitude == 0)
        #expect(midpoint.verticalAccuracy < 0)
        #expect(midpoint.course < 0)
        #expect(midpoint.speed < 0)
        #expect(midpoint.timestamp != start.timestamp)
    }

    @Test(arguments: [
        CLLocationCoordinate2D(latitude: 100, longitude: 0),
        CLLocationCoordinate2D(latitude: -90.000001, longitude: 0),
        CLLocationCoordinate2D(latitude: 0, longitude: 180.000001),
        CLLocationCoordinate2D(latitude: .nan, longitude: 0),
        CLLocationCoordinate2D(latitude: 0, longitude: .nan),
        CLLocationCoordinate2D(latitude: .infinity, longitude: 0),
        kCLLocationCoordinate2DInvalid
    ])
    func returnsNilForInvalidCoordinates(_ invalid: CLLocationCoordinate2D) {
        let valid = CLLocation(latitude: 10, longitude: 10)
        let location = CLLocation(latitude: invalid.latitude, longitude: invalid.longitude)
        #expect(valid.midpoint(to: location) == nil)
        #expect(location.midpoint(to: valid) == nil)
        #expect(location.midpoint(to: location) == nil)
    }
}
#endif
