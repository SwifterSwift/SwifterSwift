// MKMapView+DequeueReusableAnnotationViewWithClassTests.swift - Copyright 2026 SwifterSwift

#if canImport(MapKit) && !os(watchOS)
import MapKit
import SwifterSwiftMapKit
import Testing

@MainActor
struct MKMapViewDequeueReusableAnnotationViewWithClassTests {
    final class BadgeAnnotationView: MKAnnotationView {}

    @Test
    func returnsNilWhenNothingIsRegistered() {
        let mapView = MKMapView()
        #expect(mapView.dequeueReusableAnnotationView(withClass: MKMarkerAnnotationView.self) == nil)
    }

    @Test
    func returnsViewOfTheRegisteredClass() {
        let mapView = MKMapView()
        mapView.register(BadgeAnnotationView.self, forAnnotationViewWithReuseIdentifier: "BadgeAnnotationView")
        let view = mapView.dequeueReusableAnnotationView(withClass: BadgeAnnotationView.self)
        #expect(view != nil)
        #expect(view?.reuseIdentifier == "BadgeAnnotationView")
    }

    @Test
    func leavesTheAnnotationUnset() {
        let mapView = MKMapView()
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: "MKMarkerAnnotationView")
        let view = mapView.dequeueReusableAnnotationView(withClass: MKMarkerAnnotationView.self)
        #expect(view != nil)
        #expect(view?.annotation == nil)
    }

    @Test
    func returnsNilWhenAnotherClassIsRegisteredUnderTheName() {
        let mapView = MKMapView()
        mapView.register(MKAnnotationView.self, forAnnotationViewWithReuseIdentifier: "MKMarkerAnnotationView")
        #expect(mapView.dequeueReusableAnnotationView(withClass: MKMarkerAnnotationView.self) == nil)
    }

    @Test
    func acceptsASubclassOfTheRequestedClass() {
        let mapView = MKMapView()
        mapView.register(BadgeAnnotationView.self, forAnnotationViewWithReuseIdentifier: "MKAnnotationView")
        let view = mapView.dequeueReusableAnnotationView(withClass: MKAnnotationView.self)
        #expect(view is BadgeAnnotationView)
    }

    @Test
    func looksUpTheDynamicTypeOfTheClass() {
        let mapView = MKMapView()
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: "MKMarkerAnnotationView")
        let viewClass: MKAnnotationView.Type = MKMarkerAnnotationView.self
        #expect(mapView.dequeueReusableAnnotationView(withClass: viewClass) is MKMarkerAnnotationView)
    }
}
#endif
