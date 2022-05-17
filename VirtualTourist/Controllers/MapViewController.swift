//
//  MapViewController.swift
//  VirtualTourist
//
//  Created by Joel Stevick on 5/17/22.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, UIGestureRecognizerDelegate {
    // MARK: - Properties
    
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizer.State.began {
            
            let touchPoint = gestureRecognizer.location(in: self.mapView)
            
            let touchMapCoordinate =  self.mapView.convert(touchPoint, toCoordinateFrom: mapView)
            let annotation = MKPointAnnotation()
            annotation.coordinate = touchMapCoordinate
            
            let geoCoder = CLGeocoder()
            
            geoCoder.reverseGeocodeLocation(CLLocation(latitude: touchMapCoordinate.latitude, longitude: touchMapCoordinate.longitude)) { (placemarks, error) in
                guard
                    let placemarks = placemarks,
                    let placeMark = placemarks.first
                else {
                    return
                }
                
                DispatchQueue.main.async {
                    
                    self.mapView.addAnnotation(annotation)
                    annotation.title = placeMark.locality
                    
                    self.mapView.addAnnotation(annotation)
                }
                
            }
        }
    }
}
