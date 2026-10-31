// CLLocation+IsWithinTests.swift - Copyright 2026 SwifterSwift

#if canImport(CoreLocation)
import CoreLocation
import Foundation
import SwifterSwiftCoreLocation
import Testing

struct CLLocationIsWithinTests {
    let gate = CLLocation(latitude: 37.575803, longitude: 126.976807)
    let visitor = CLLocation(latitude: 37.572931, longitude: 126.976834)

    @Test(arguments: [
        (320.0, UnitLength.meters, true),
        (300, .meters, false),
        (1_050, .feet, true),
        (1_000, .feet, false),
        (0.2, .miles, true),
        (0.3, .kilometers, false),
        (1, .kilometers, true)
    ])
    func comparesDistanceInAnyUnit(value: Double, unit: UnitLength, expected: Bool) {
        let distance = Measurement(value: value, unit: unit)
        #expect(gate.isWithin(distance, of: visitor) == expected)
        #expect(visitor.isWithin(distance, of: gate) == expected)
    }

    @Test
    func switchesAtTheDistanceBetweenTheLocations() {
        // A margin of a micrometer either side, rather than the exact boundary, so the test doesn't depend on
        // `distance(from:)` returning bit-identical results on every call. `treatsTheSameLocationAsWithinZero()`
        // covers the inclusive boundary exactly.
        let meters = gate.distance(from: visitor)
        #expect(gate.isWithin(Measurement(value: meters + 1e-6, unit: .meters), of: visitor))
        #expect(!gate.isWithin(Measurement(value: meters - 1e-6, unit: .meters), of: visitor))
    }

    @Test
    func treatsTheSameLocationAsWithinZero() {
        let sameCoordinate = CLLocation(latitude: 37.575803, longitude: 126.976807)
        #expect(gate.isWithin(Measurement(value: 0, unit: .meters), of: gate))
        #expect(gate.isWithin(Measurement(value: 0, unit: .meters), of: sameCoordinate))
    }

    @Test(arguments: [-1.0, -.ulpOfOne, -.infinity, .nan])
    func returnsFalseForNegativeOrNaNDistance(_ value: Double) {
        #expect(!gate.isWithin(Measurement(value: value, unit: .meters), of: gate))
        #expect(!gate.isWithin(Measurement(value: value, unit: .meters), of: visitor))
    }

    @Test
    func returnsTrueForInfiniteDistance() {
        let antipode = CLLocation(latitude: -37.575803, longitude: -53.023193)
        #expect(gate.isWithin(Measurement(value: .infinity, unit: .meters), of: antipode))
        #expect(gate.isWithin(Measurement(value: .greatestFiniteMagnitude, unit: .meters), of: antipode))
    }

    @Test
    func measuresTheShortWayAcrossTheAntimeridian() {
        let west = CLLocation(latitude: 0, longitude: 179.999)
        let east = CLLocation(latitude: 0, longitude: -179.999)
        #expect(west.isWithin(Measurement(value: 300, unit: .meters), of: east))
    }

    @Test(arguments: [
        CLLocationCoordinate2D(latitude: 100, longitude: 0),
        CLLocationCoordinate2D(latitude: 0, longitude: 181),
        CLLocationCoordinate2D(latitude: .nan, longitude: 0),
        CLLocationCoordinate2D(latitude: 0, longitude: .infinity),
        kCLLocationCoordinate2DInvalid
    ])
    func returnsFalseForInvalidCoordinates(_ invalid: CLLocationCoordinate2D) {
        let location = CLLocation(latitude: invalid.latitude, longitude: invalid.longitude)
        let anyDistance = Measurement(value: Double.infinity, unit: UnitLength.meters)
        #expect(!gate.isWithin(anyDistance, of: location))
        #expect(!location.isWithin(anyDistance, of: gate))
        #expect(!location.isWithin(anyDistance, of: location))
    }
}
#endif
