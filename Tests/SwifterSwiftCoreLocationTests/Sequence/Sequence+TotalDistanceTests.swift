// Sequence+TotalDistanceTests.swift - Copyright 2026 SwifterSwift

#if canImport(CoreLocation)
import CoreLocation
import Foundation
import SwifterSwiftCoreLocation
import Testing

struct SequenceTotalDistanceTests {
    let track = [
        CLLocation(latitude: 41, longitude: -111),
        CLLocation(latitude: 41, longitude: -112),
        CLLocation(latitude: 41, longitude: -113)
    ]

    @Test
    func returnsZeroForEmptySequence() {
        let distance = [CLLocation]().totalDistance()
        #expect(distance.value == 0)
        #expect(distance.unit == .meters)
    }

    @Test
    func returnsZeroForSingleLocation() {
        let distance = [CLLocation(latitude: 41, longitude: -111)].totalDistance(in: .kilometers)
        #expect(distance.value == 0)
        #expect(distance.unit == .kilometers)
    }

    @Test
    func sumsDistancesBetweenConsecutiveLocations() {
        let expected = track[0].distance(from: track[1]) + track[1].distance(from: track[2])
        #expect(abs(track.totalDistance().value - expected) < 1e-6)
        #expect(abs(track.totalDistance(in: .kilometers).value - 168.27) < 0.01)
    }

    @Test
    func defaultsToMeters() {
        #expect(track.totalDistance().unit == .meters)
    }

    @Test(arguments: [UnitLength.kilometers, .miles, .feet, .nauticalMiles, .meters])
    func convertsToRequestedUnit(_ unit: UnitLength) {
        let distance = track.totalDistance(in: unit)
        let meters = track.totalDistance().value
        #expect(distance.unit == unit)
        #expect(abs(distance.converted(to: .meters).value - meters) < 1e-6)
    }

    @Test
    func followsTheOrderOfTheLocations() {
        let reordered = [track[0], track[2], track[1]]
        #expect(reordered.totalDistance().value > track.totalDistance().value)
    }

    @Test
    func countsRepeatedLocationsAsNoDistance() {
        let repeated = [track[0], track[0], track[1], track[1]]
        #expect(abs(repeated.totalDistance().value - track[0].distance(from: track[1])) < 1e-6)
    }

    @Test
    func returnsToTheStartForAClosedLoop() {
        let loop = track + [track[0]]
        let expected = track.totalDistance().value + track[2].distance(from: track[0])
        #expect(abs(loop.totalDistance().value - expected) < 1e-6)
    }

    @Test(arguments: [
        CLLocationCoordinate2D(latitude: 100, longitude: 0),
        CLLocationCoordinate2D(latitude: 0, longitude: 200),
        CLLocationCoordinate2D(latitude: .nan, longitude: 0),
        CLLocationCoordinate2D(latitude: 0, longitude: .infinity),
        kCLLocationCoordinate2DInvalid
    ])
    func skipsInvalidCoordinates(_ invalid: CLLocationCoordinate2D) {
        let location = CLLocation(latitude: invalid.latitude, longitude: invalid.longitude)
        let withInvalid = [track[0], location, track[1], location]
        #expect(abs(withInvalid.totalDistance().value - track[0].distance(from: track[1])) < 1e-6)
        #expect([location].totalDistance().value == 0)
        #expect([location, location].totalDistance().value == 0)
    }

    @Test
    func acceptsTheBoundariesOfValidCoordinates() {
        let poles = [CLLocation(latitude: 90, longitude: -180), CLLocation(latitude: -90, longitude: 180)]
        // Half of a meridian on the WGS 84 ellipsoid.
        #expect(abs(poles.totalDistance(in: .kilometers).value - 20_004) < 1)
    }

    @Test
    func takesTheShortWayAcrossTheAntimeridian() {
        let path = [CLLocation(latitude: 0, longitude: 179), CLLocation(latitude: 0, longitude: -179)]
        #expect(abs(path.totalDistance(in: .kilometers).value - 222.64) < 0.01)
    }

    @Test
    func worksWithAnySequence() {
        let lazyTrack = (0..<3).lazy.map { CLLocation(latitude: 41, longitude: -111 - Double($0)) }
        #expect(abs(lazyTrack.totalDistance().value - track.totalDistance().value) < 1e-6)
        #expect(abs(track[...].totalDistance().value - track.totalDistance().value) < 1e-6)
    }
}
#endif
