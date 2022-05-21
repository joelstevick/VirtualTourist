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
    var annotations = [MKPointAnnotation]()
    let dataController = DataController(modelName: "VirtualTourist")
    
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataController.load {
            // update to Main
        }
        
        self.mapView.delegate = self
        
        // Setup longpress for MapView
        let lpgr = UILongPressGestureRecognizer(target: self,
                                                action:#selector(self.handleLongPress))
        lpgr.minimumPressDuration = 1
        lpgr.delaysTouchesBegan = true
        lpgr.delegate = self
        
        self.mapView.addGestureRecognizer(lpgr)
        
        // initialize the view model
        load()
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */

}
