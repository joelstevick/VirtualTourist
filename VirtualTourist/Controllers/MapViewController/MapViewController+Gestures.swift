//
//  MapViewController+Gestures.swift
//  VirtualTourist
//
//  Created by Joel Stevick on 5/21/22.
//

import Foundation
import MapKit
import CoreLocation

extension MapViewController {
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizer.State.began {
            
            // Add a Pin as soon as the user has pressed for > 1= second, don't wait for release
            DispatchQueue.main.async {
                
                // convert the device touch point to a coordinate
                let touchPoint = gestureRecognizer.location(in: self.mapView)
                
                let touchMapCoordinate =  self.mapView.convert(touchPoint, toCoordinateFrom: self.mapView)
                let annotation = MKPointAnnotation()
                annotation.coordinate = touchMapCoordinate
                
                let geoCoder = CLGeocoder()
                
                // get the placemark that describes the location in human-terms
                geoCoder.reverseGeocodeLocation(CLLocation(latitude: touchMapCoordinate.latitude, longitude: touchMapCoordinate.longitude)) { (placemarks, error) in
                    guard
                        let placemarks = placemarks,
                        let placeMark = placemarks.first
                    else {
                        return
                    }
                    
                    DispatchQueue.main.async {
                        
                        // add the pin to the map
                        annotation.title = placeMark.locality
                        annotation.subtitle = placeMark.administrativeArea
                        
                        self.mapView.addAnnotation(annotation)
                    }
                    
                }
            }
        }
    }
}
