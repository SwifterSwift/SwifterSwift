// MKMapView+DequeueReusableAnnotationViewWithClass.swift - Copyright 2026 SwifterSwift

#if canImport(MapKit) && !os(watchOS)
import MapKit

public extension MKMapView {
    /// SwifterSwift: Returns a reusable annotation view of the given class, identified by the class name.
    ///
    /// This calls `dequeueReusableAnnotationView(withIdentifier:)` with `String(describing: viewClass)` as the
    /// identifier, the same one `register(annotationViewWithClass:)` uses. If the reuse queue is empty and a class is
    /// registered for that identifier, the map view creates a new view.
    ///
    /// The returned view's `annotation` isn't updated, so set it before you return the view from
    /// `mapView(_:viewFor:)`. To get a view that's already configured for an annotation, use
    /// `dequeueReusableAnnotationView(withClass:for:)` instead.
    ///
    /// ```swift
    /// mapView.register(annotationViewWithClass: MKMarkerAnnotationView.self)
    /// let view = mapView.dequeueReusableAnnotationView(withClass: MKMarkerAnnotationView.self)
    /// view?.annotation = annotation
    /// ```
    ///
    /// - Parameter viewClass: The class of the annotation view to dequeue.
    /// - Returns: An annotation view of class `viewClass`, or `nil` if there's no view to reuse, no class is
    ///   registered for the identifier, or the view the map view returns isn't a `viewClass`.
    func dequeueReusableAnnotationView<T: MKAnnotationView>(withClass viewClass: T.Type) -> T? {
        dequeueReusableAnnotationView(withIdentifier: String(describing: viewClass)) as? T
    }
}
#endif
