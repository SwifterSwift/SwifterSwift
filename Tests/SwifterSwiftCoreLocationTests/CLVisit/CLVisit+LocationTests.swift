// CLVisit+LocationTests.swift - Copyright 2026 SwifterSwift

#if canImport(CoreLocation) && !os(tvOS) && !os(watchOS) && !os(visionOS)
import CoreLocation
import Foundation
import SwifterSwiftCoreLocation
import Testing

struct CLVisitLocationTests {
    /// `CLVisit` has no public initializer that sets its values, so the tests use a subclass.
    final class StubVisit: CLVisit {
        let stubCoordinate: CLLocationCoordinate2D
        let stubHorizontalAccuracy: CLLocationAccuracy
        let stubArrivalDate: Date
        let stubDepartureDate: Date

        init(
            coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 51.5007, longitude: -0.1246),
            horizontalAccuracy: CLLocationAccuracy = 35,
            arrivalDate: Date = Date(timeIntervalSince1970: 1_000),
            departureDate: Date = Date(timeIntervalSince1970: 5_000)
        ) {
            stubCoordinate = coordinate
            stubHorizontalAccuracy = horizontalAccuracy
            stubArrivalDate = arrivalDate
            stubDepartureDate = departureDate
            super.init()
        }

        required init?(coder: NSCoder) {
            nil
        }

        override var coordinate: CLLocationCoordinate2D { stubCoordinate }
        override var horizontalAccuracy: CLLocationAccuracy { stubHorizontalAccuracy }
        override var arrivalDate: Date { stubArrivalDate }
        override var departureDate: Date { stubDepartureDate }
    }

    @Test
    func copiesCoordinateAndHorizontalAccuracy() {
        let visit = StubVisit(coordinate: CLLocationCoordinate2D(latitude: -33.8568, longitude: 151.2153))
        let location = visit.location
        #expect(location.coordinate.latitude == -33.8568)
        #expect(location.coordinate.longitude == 151.2153)
        #expect(location.horizontalAccuracy == 35)
    }

    @Test(arguments: [0.0, 5, 100, 10_000])
    func keepsTheRadiusOfTheVisitedRegion(_ accuracy: Double) {
        #expect(StubVisit(horizontalAccuracy: accuracy).location.horizontalAccuracy == accuracy)
    }

    @Test
    func usesArrivalDateAsTimestamp() {
        let visit = StubVisit()
        #expect(visit.location.timestamp == Date(timeIntervalSince1970: 1_000))
    }

    @Test
    func usesArrivalDateWhileTheVisitIsOngoing() {
        let visit = StubVisit(departureDate: .distantFuture)
        #expect(visit.location.timestamp == Date(timeIntervalSince1970: 1_000))
    }

    @Test
    func usesDepartureDateWhenArrivalIsUnknown() {
        let visit = StubVisit(arrivalDate: .distantPast)
        #expect(visit.location.timestamp == Date(timeIntervalSince1970: 5_000))
    }

    @Test
    func hasNoAltitude() {
        let location = StubVisit().location
        #expect(location.altitude == 0)
        #expect(location.verticalAccuracy < 0)
    }

    @Test(arguments: [(90.0, 180.0), (-90, -180), (0, 0)])
    func keepsBoundaryCoordinates(latitude: Double, longitude: Double) {
        let visit = StubVisit(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        #expect(visit.location.coordinate.latitude == latitude)
        #expect(visit.location.coordinate.longitude == longitude)
    }
}
#endif
