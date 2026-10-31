// MKMapView+RegisterTests.swift - Copyright 2026 SwifterSwift

#if canImport(MapKit) && !os(watchOS)
import MapKit
import SwifterSwiftMapKit
import Testing

@MainActor
struct MKMapViewRegisterTests {
    final class BadgeAnnotationView: MKAnnotationView {}

    @Test
    func registersClassUnderItsName() {
        let mapView = MKMapView()
        #expect(mapView.dequeueReusableAnnotationView(withIdentifier: "MKMarkerAnnotationView") == nil)
        mapView.register(annotationViewWithClass: MKMarkerAnnotationView.self)
        let view = mapView.dequeueReusableAnnotationView(withIdentifier: "MKMarkerAnnotationView")
        #expect(view is MKMarkerAnnotationView)
    }

    @Test
    func usesTheNameWithoutModuleOrEnclosingType() {
        let mapView = MKMapView()
        mapView.register(annotationViewWithClass: BadgeAnnotationView.self)
        let view = mapView.dequeueReusableAnnotationView(withIdentifier: "BadgeAnnotationView")
        #expect(view is BadgeAnnotationView)
    }

    @Test
    func registersTheDynamicTypeOfTheClass() {
        let mapView = MKMapView()
        let viewClass: MKAnnotationView.Type = MKMarkerAnnotationView.self
        mapView.register(annotationViewWithClass: viewClass)
        let view = mapView.dequeueReusableAnnotationView(withIdentifier: "MKMarkerAnnotationView")
        #expect(view is MKMarkerAnnotationView)
        #expect(mapView.dequeueReusableAnnotationView(withIdentifier: "MKAnnotationView") == nil)
    }

    @Test
    func registersSeveralClassesSeparately() {
        let mapView = MKMapView()
        mapView.register(annotationViewWithClass: MKMarkerAnnotationView.self)
        mapView.register(annotationViewWithClass: BadgeAnnotationView.self)
        let marker = mapView.dequeueReusableAnnotationView(withIdentifier: "MKMarkerAnnotationView")
        let badge = mapView.dequeueReusableAnnotationView(withIdentifier: "BadgeAnnotationView")
        #expect(marker is MKMarkerAnnotationView)
        #expect(badge is BadgeAnnotationView)
    }

    @Test
    func registeringAgainReplacesTheClass() {
        let mapView = MKMapView()
        mapView.register(annotationViewWithClass: MKMarkerAnnotationView.self)
        mapView.register(annotationViewWithClass: MKMarkerAnnotationView.self)
        let view = mapView.dequeueReusableAnnotationView(withIdentifier: "MKMarkerAnnotationView")
        #expect(view is MKMarkerAnnotationView)
    }
}
#endif
