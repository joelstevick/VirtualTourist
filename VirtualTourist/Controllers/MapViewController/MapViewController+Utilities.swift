//
//  MapViewController+Utilities.swift
//  VirtualTourist
//
//  Created by Joel Stevick on 5/21/22.
//

import Foundation
import MapKit

extension MapViewController {
    func navigateToMapDetailView(view: MKAnnotationView) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let detailViewController = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailViewController.coordinate = view.annotation?.coordinate
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}