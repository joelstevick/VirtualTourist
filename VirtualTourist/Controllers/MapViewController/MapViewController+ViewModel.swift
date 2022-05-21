//
//  MapViewController+ViewModel.swift
//  VirtualTourist
//
//  Created by Joel Stevick on 5/21/22.
//

import Foundation
import MapKit

extension MapViewController {
    func load() {
        for annotation in annotations {
            self.mapView.addAnnotation(annotation)
        }
    }
}
