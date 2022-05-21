//
//  MapViewController+ViewModel.swift
//  VirtualTourist
//
//  Created by Joel Stevick on 5/21/22.
//

import Foundation
import MapKit
import NanoID
import CoreLocation

extension MapViewController {
    func load() {
        for annotation in annotations {
            self.mapView.addAnnotation(annotation)
        }
    }
    
    func addAnnotation(
        title: String,
        subTitle: String,
        latitude: Double,
        longitude: Double
    ) {
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        annotation.title = title
        annotation.subtitle = subTitle
        
        annotations.append(annotation)
        
        load()
    }
}
