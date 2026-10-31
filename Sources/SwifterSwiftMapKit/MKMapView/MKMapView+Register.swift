// MKMapView+Register.swift - Copyright 2026 SwifterSwift

#if canImport(MapKit) && !os(watchOS)
import MapKit

public extension MKMapView {
    /// SwifterSwift: Registers an annotation view class, using the name of the class as its reuse identifier.
    ///
    /// This calls `register(_:forAnnotationViewWithReuseIdentifier:)` with `String(describing: viewClass)` as the
    /// identifier, for example `"MKMarkerAnnotationView"`. That's the identifier
    /// `dequeueReusableAnnotationView(withClass:)` and `dequeueReusableAnnotationView(withClass:for:)` look up, so you
    /// don't have to keep identifier strings in sync. The name doesn't include the module or any enclosing type, so
    /// register only one class with a given name on a map view.
    ///
    /// ```swift
    /// mapView.register(annotationViewWithClass: MKMarkerAnnotationView.self)
    /// // Same as:
    /// mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: "MKMarkerAnnotationView")
    /// ```
    ///
    /// - Parameter viewClass: The annotation view class to register.
    func register(annotationViewWithClass viewClass: MKAnnotationView.Type) {
        register(viewClass, forAnnotationViewWithReuseIdentifier: String(describing: viewClass))
    }
}
#endif
