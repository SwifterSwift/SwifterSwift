// MKMapView+DequeueReusableAnnotationViewWithClassForTests.swift - Copyright 2026 SwifterSwift

#if canImport(MapKit) && !os(watchOS)
import CoreLocation
import MapKit
import SwifterSwiftMapKit
import Testing

@MainActor
struct MKMapViewDequeueReusableAnnotationViewWithClassForTests {
    final class BadgeAnnotationView: MKAnnotationView {}

    let annotation: MKPointAnnotation = {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 36.9751, longitude: 38.4243)
        annotation.title = "Gaziantep"
        return annotation
    }()

    @Test
    func createsViewWhenNothingIsRegistered() {
        let mapView = MKMapView()
        let view = mapView.dequeueReusableAnnotationView(withClass: MKMarkerAnnotationView.self, for: annotation)
        #expect(view.annotation === annotation)
        #expect(view.reuseIdentifier == "MKMarkerAnnotationView")
    }

    @Test
    func usesTheRegisteredClass() {
        let mapView = MKMapView()
        mapView.register(BadgeAnnotationView.self, forAnnotationViewWithReuseIdentifier: "BadgeAnnotationView")
        let view = mapView.dequeueReusableAnnotationView(withClass: BadgeAnnotationView.self, for: annotation)
        #expect(view.annotation === annotation)
        #expect(view.reuseIdentifier == "BadgeAnnotationView")
    }

    @Test
    func returnsTheRequestedClassWhenAnotherClassIsRegisteredUnderTheName() {
        let mapView = MKMapView()
        mapView.register(MKAnnotationView.self, forAnnotationViewWithReuseIdentifier: "MKMarkerAnnotationView")
        let view: MKAnnotationView = mapView.dequeueReusableAnnotationView(
            withClass: MKMarkerAnnotationView.self,
            for: annotation
        )
        #expect(view is MKMarkerAnnotationView)
        #expect(view.annotation === annotation)
    }

    @Test
    func createsTheDynamicTypeOfTheClass() {
        let mapView = MKMapView()
        let viewClass: MKAnnotationView.Type = BadgeAnnotationView.self
        let view = mapView.dequeueReusableAnnotationView(withClass: viewClass, for: annotation)
        #expect(view is BadgeAnnotationView)
        #expect(view.reuseIdentifier == "BadgeAnnotationView")
        #expect(view.annotation === annotation)
    }

    @Test
    func returnsANewViewForEachCallWhileNoneAreQueued() {
        let mapView = MKMapView()
        let first = mapView.dequeueReusableAnnotationView(withClass: MKMarkerAnnotationView.self, for: annotation)
        let other = MKPointAnnotation()
        let second = mapView.dequeueReusableAnnotationView(withClass: MKMarkerAnnotationView.self, for: other)
        #expect(first !== second)
        #expect(first.annotation === annotation)
        #expect(second.annotation === other)
    }
}
#endif
