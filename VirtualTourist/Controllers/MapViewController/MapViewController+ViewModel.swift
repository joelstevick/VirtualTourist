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
    private func addAnnotationToMapView(
        title: String,
        subTitle: String,
        latitude: Double,
        longitude: Double) {
            let annotation = MKPointAnnotation()
            
            annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            annotation.title = title
            annotation.subtitle = subTitle
            
            annotations.append(annotation)
            
            load()
        }
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
        // display in the map view
        addAnnotationToMapView(title: title, subTitle: subTitle, latitude: latitude, longitude: longitude)
        
        // persist
        let location = Location(context: dataController.viewContext)
        
        location.id = NanoID.generate()
        location.latitude = latitude
        location.longitude = longitude
        location.title = title
        location.subTitle = subTitle
        
        do {
            try dataController.viewContext.save()
        } catch {
            showError(viewController: self, message: error.localizedDescription)
        }
    }
    
    
}
