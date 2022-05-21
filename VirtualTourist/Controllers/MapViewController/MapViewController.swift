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
        navigateToMapDetailView(view: view)
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
        
    // MARK: - Utility Methods
    func navigateToMapDetailView(view: MKAnnotationView) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let detailViewController = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailViewController.coordinate = view.annotation?.coordinate
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
