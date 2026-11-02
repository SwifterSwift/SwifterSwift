# ``SwifterSwiftMapKit``

Extensions for MapKit, such as `MKMapView` and the overlay shapes.

## Overview

These extensions are available on iOS, iPadOS, macOS, tvOS, visionOS and Mac Catalyst. Extensions for MapKit types that also exist on watchOS, such as `MKPolyline`, are available there too. On other platforms, the module is empty.

Every extension lives in its own source file and doesn't depend on any other SwifterSwift code. Use the whole module, or copy a single file into your project.

```swift
import SwifterSwiftMapKit

mapView.register(annotationViewWithClass: MKMarkerAnnotationView.self)
mapView.zoom(to: route.coordinates, meters: 500, animated: true)
```
