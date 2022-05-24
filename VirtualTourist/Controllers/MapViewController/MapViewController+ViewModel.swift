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
import CoreData

extension MapViewController {
    private func addAnnotationToMapView(
        title: String,
        subTitle: String,
        latitude: Double,
        longitude: Double,
        location: Location
    ) {
            let annotation = AnnotationWithLocation()
            
        annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            annotation.title = title
            annotation.subtitle = subTitle
            annotation.location = location
            
            self.mapView.addAnnotation(annotation)
            
            // save the locations in case there is a change in the TableViewController -- we need to be able to remove the pins
            // associated with the locations that were deleted
            savedAnnotations = (self.mapView.annotations as! [MKPointAnnotation])
        }
    
    func load() {
        // get the current locations
        let fetchRequest: NSFetchRequest<Location> = Location.fetchRequest()
        
        // sort reverse chrono
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "creationDate", ascending: false)
        ]
        
        guard let locations = try? dataController.viewContext.fetch(fetchRequest) else {
            showError(viewController: self, message: "Could not read your phone data")
            return
        }
        
        for location in locations {
            // display in the map view
            addAnnotationToMapView(
                title: location.title!,
                subTitle: location.subtitle!,
                latitude: location.latitude,
                longitude: location.longitude,
                location: location)
        }
        
        // preserve locations so that we can pass to other view controllers
        self.locations = locations
        
        
    }
    
    func addAnnotation(
        title: String,
        subTitle: String,
        latitude: Double,
        longitude: Double
    ) {
        
        // persist
        let location = Location(context: dataController.viewContext)
        
        location.id = NanoID.generate()
        location.latitude = latitude
        location.longitude = longitude
        location.title = title
        location.subtitle = subTitle
        location.creationDate = Date.now // we may need this?
        
        do {
            try dataController.viewContext.save()
        } catch {
            showError(viewController: self, message: error.localizedDescription)
        }
    }
    
    
}
