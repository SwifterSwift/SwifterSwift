//
//  MKMapViewExtensions.swift
//  SwifterSwift
//
//  Created by Hannes Staffler on 24.01.19.
//  Copyright © 2019 SwifterSwift
//

#if canImport(MapKit)
import MapKit

#if !os(watchOS)
@available(tvOS 9.2, *)
public extension MKMapView {

    /// SwifterSwift: Dequeue reusable MKAnnotationView using class type
    ///
    /// - Parameters:
    ///   - name: MKAnnotationView type.
    /// - Returns: optional MKAnnotationView object.
    func dequeueReusableAnnotationView<T: MKAnnotationView>(withClass name: T.Type) -> T? {
        return dequeueReusableAnnotationView(withIdentifier: String(describing: name)) as? T
    }

    /// SwifterSwift: Register MKAnnotationView using class type
    ///
    /// - Parameter name: MKAnnotationView type.
    @available(iOS 11.0, tvOS 11.0, macOS 10.13, *)
    func register<T: MKAnnotationView>(annotationViewWithClass name: T.Type) {
        register(T.self, forAnnotationViewWithReuseIdentifier: String(describing: name))
    }

    /// SwifterSwift: Dequeue reusable MKAnnotationView using class type
    ///
    /// - Parameters:
    ///   - name: MKAnnotationView type.
    ///   - annotation: annotation of the mapView.
    /// - Returns: optional MKAnnotationView object.
    @available(iOS 11.0, tvOS 11.0, macOS 10.13, *)
    func dequeueReusableAnnotationView<T: MKAnnotationView>(withClass name: T.Type, for annotation: MKAnnotation) -> T? {
        guard let annotationView = dequeueReusableAnnotationView(withIdentifier: String(describing: name), for: annotation) as? T else {
            fatalError("Couldn't find MKAnnotationView for \(String(describing: name))")
        }

        return annotationView
    }
    
    /// SwifterSwift: Zooms in on multiple mapView coordinates.
    ///
    /// - Parameters:
    ///   - coordinates: Gets the array of type CLLocationCoordinate2D.
    ///   - meter: Takes the type of Double zoom.
    ///   - insets: Gives space to the CGFloat type screen.
    ///   - animated: The animation control takes the Boolean value.
    @available(iOS 9.0, *)
    func multipleCoordinateZoom(for coordinates: [CLLocationCoordinate2D], meter: Double, insets: CGFloat, animated: Bool) {
        if coordinates.count == 1 {
            let coordinateRegion = MKCoordinateRegion(center: coordinates.first!, latitudinalMeters: meter, longitudinalMeters: meter)
            self.setRegion(coordinateRegion, animated: true)
        } else {
            let mkPolygon = MKPolygon(coordinates: coordinates, count: coordinates.count)
            let edgePadding = UIEdgeInsets(top: insets, left: insets, bottom: insets, right: insets)
            setVisibleMapRect(mkPolygon.boundingMapRect, edgePadding: edgePadding, animated: animated)
        }
    }
}
#endif

#endif
