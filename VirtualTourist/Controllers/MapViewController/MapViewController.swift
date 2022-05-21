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
    var locations = [Location]()
    let dataController = DataController(modelName: "VirtualTourist")
    
    @IBOutlet weak var mapView: MKMapView!
    
    var saveObserverToken: Any?
    
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
        
        // listen for model changes
        addSaveNotificationObserver()
    }
    
    deinit {
        removeSaveNotificationObserver()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as! TableViewController
        vc.locations = locations
        vc.dataController = dataController
    }
    
    
}
