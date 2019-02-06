//
//  MKMapSnapshotterTests.swift
//  SwifterSwift
//
//  Created by Amit Bhavsar on 06/02/19.
//  Copyright © 2019 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if canImport(MapKit)
import MapKit

import struct CoreLocation.CLLocationCoordinate2D

final class MKMapSnapshotterTests: XCTestCase {
    
    let location = CLLocationCoordinate2D(latitude: 37.332078, longitude: -122.02962)
    let mapSize = CGSize(width: 100.0, height: 100.0)
    
    func testWithCoordinates() {
        var imageSnap: UIImage?
        var imageSnapshotter: UIImage?
        
        let mapSnapshotOptions = MKMapSnapshotter.Options()
        
        let region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.075, longitudeDelta: 0.075))
        mapSnapshotOptions.region = region
        mapSnapshotOptions.scale = UIScreen.main.scale
        mapSnapshotOptions.size = mapSize
        mapSnapshotOptions.showsBuildings = true
        mapSnapshotOptions.showsPointsOfInterest = true
        
        let snapShotter = MKMapSnapshotter(options: mapSnapshotOptions)
        
        snapShotter.start { (snapshot, error) in
            if let _ = snapshot {
                imageSnapshotter = snapshot!.image
            }
            
            self.location.snap(withSize: self.mapSize) { image in
                if let _ = image {
                    imageSnap = image
                }
                XCTAssertEqual(imageSnapshotter!.pngData()!, imageSnap!.pngData()!)
            }
        }
    }
}

#endif
