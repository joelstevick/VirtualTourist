//
//  MapViewController.swift
//  VirtualTourist
//
//  Created by Joel Stevick on 5/17/22.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, UIGestureRecognizerDelegate, MKMapViewDelegate {
    // MARK: - Properties
    
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.delegate = self
        
        // Setup longpress for MapView
        let lpgr = UILongPressGestureRecognizer(target: self,
                                                action:#selector(self.handleLongPress))
        lpgr.minimumPressDuration = 1
        lpgr.delaysTouchesBegan = true
        lpgr.delegate = self
        
        self.mapView.addGestureRecognizer(lpgr)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: - Handlers
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        print("Did select")
        navigateToMapDetailView()
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil // ignore current user location
        }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "custom")
        } else {
            annotationView?.annotation = annotation
        }
        
        annotationView?.canShowCallout = true
        
        return annotationView
    }
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
    
    // MARK: - Utility Methods
    func navigateToMapDetailView() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let detailViewController = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
