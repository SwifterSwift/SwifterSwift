//
//  MKMapSnapshotterExtensions.swift
//  SwifterSwift
//
//  Created by Amit Bhavsar on 06/02/19.
//  Copyright © 2019 SwifterSwift
//


#if canImport(MapKit)
import MapKit

#if canImport(Kingfisher)
import Kingfisher
#endif

#if !os(watchOS)
// MARK: - Methods
@available(tvOS 9.2, *)
public extension CLLocationCoordinate2D {
    
    
    /// SwifterSwift: Return the image of map region
    ///
    /// Example:
    ///     let location = CLLocationCoordinate2D(latitude: 37.332078, longitude: -122.02962)
    ///     location.snap(withSize: imgvMap.frame.size) { [weak self] image in
    ///         if let _ = image {
    ///             self?.imgvMap.image = image
    ///         }
    ///     }
    ///
    /// - Parameters:
    ///   - size: size of the map image which will be displayed
    ///   - completion: It will return the required map image
    public func snap(withSize size:CGSize, completion:@escaping (UIImage?) -> Void) {
        let mapSnapshotOptions = MKMapSnapshotter.Options()
        
        let region = MKCoordinateRegion(center: self, span: MKCoordinateSpan(latitudeDelta: 0.075, longitudeDelta: 0.075))
        mapSnapshotOptions.region = region
        
        // Set the scale of the image. We'll just use the scale of the current device, which is 2x scale on Retina screens.
        mapSnapshotOptions.scale = UIScreen.main.scale
        
        // Set the size of the image output.
        mapSnapshotOptions.size = size
        
        // Show buildings and Points of Interest on the snapshot
        mapSnapshotOptions.showsBuildings = true
        mapSnapshotOptions.showsPointsOfInterest = true
        
        mapSnapshotOptions.snap { image in
            completion(image)
        }
    }
}
#endif

#if !os(watchOS)
@available(tvOS 9.2, *)
fileprivate extension MKMapSnapshotter.Options {
    
    /// SwifterSwift: Return the image of map from snapshotter
    ///
    /// - Parameter completion: It will return the required map image
    fileprivate func snap(completion:@escaping (UIImage?) -> Void) {
        
        let location = self.region.center
        let snapshotIdentifier = "\(location.latitude)\(location.longitude)"
        
        func loadMapSnapShotter(completion:@escaping (UIImage?) -> Void) {
            let snapShotter = MKMapSnapshotter(options: self)
            
            snapShotter.start { (snapshot, error) in
                guard let snapshot = snapshot else {
                    print("Snapshot error: \(error!.localizedDescription)")
                    completion(nil)
                    return
                }
                
                #if canImport(Kingfisher)
                ImageCache.default.store(snapshot.image, forKey: snapshotIdentifier)
                #endif
                
                completion(snapshot.image)
            }
        }
        
        #if canImport(Kingfisher)
        let cacheType = ImageCache.default.imageCachedType(forKey: snapshotIdentifier)
        
        if cacheType.cached {
            ImageCache.default.retrieveImage(forKey: snapshotIdentifier, options: nil) { (image, cacheType) in
                if let _ = image {
                    completion(image)
                } else {
                    loadMapSnapShotter(completion: completion)
                }
            }
        } else {
            loadMapSnapShotter(completion: completion)
        }
        #else
        loadMapSnapShotter(completion: completion)
        #endif
        
        
    }
}
#endif

#endif
