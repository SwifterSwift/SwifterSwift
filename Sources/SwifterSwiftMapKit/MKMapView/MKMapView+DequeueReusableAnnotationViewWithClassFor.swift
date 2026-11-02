// MKMapView+DequeueReusableAnnotationViewWithClassFor.swift - Copyright 2026 SwifterSwift

#if canImport(MapKit) && !os(watchOS)
import MapKit

public extension MKMapView {
    /// SwifterSwift: Returns an annotation view of the given class for an annotation, reusing one when possible.
    ///
    /// The view is looked up with `String(describing: viewClass)` as the reuse identifier, the same one
    /// `register(annotationViewWithClass:)` uses. If there's a view of class `viewClass` to reuse, or the class is
    /// registered for that identifier, you get that view with its `annotation` set. Otherwise a new view is created
    /// with `init(annotation:reuseIdentifier:)`, so registering the class first is optional.
    ///
    /// Unlike the SDK's `dequeueReusableAnnotationView(withIdentifier:for:)`, this never raises an exception when
    /// nothing is registered for the identifier, and it always returns a view of the requested class.
    ///
    /// ```swift
    /// func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
    ///     let view = mapView.dequeueReusableAnnotationView(withClass: MKMarkerAnnotationView.self, for: annotation)
    ///     view.markerTintColor = .systemOrange
    ///     return view
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - viewClass: The class of the annotation view to return.
    ///   - annotation: The annotation the view represents.
    /// - Returns: An annotation view of class `viewClass` whose `annotation` is `annotation`.
    func dequeueReusableAnnotationView<T: MKAnnotationView>(
        withClass viewClass: T.Type,
        for annotation: any MKAnnotation
    ) -> T {
        let identifier = String(describing: viewClass)
        if let view = dequeueReusableAnnotationView(withIdentifier: identifier) as? T {
            view.annotation = annotation
            return view
        }
        return viewClass.init(annotation: annotation, reuseIdentifier: identifier)
    }
}
#endif
