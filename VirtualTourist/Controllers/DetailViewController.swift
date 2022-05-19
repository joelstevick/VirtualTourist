//
//  DetailViewController.swift
//  VirtualTourist
//
//  Created by Joel Stevick on 5/18/22.
//

import UIKit
import CoreLocation

class DetailViewController: UIViewController {
    // MARK: - Properties
    var coordinate: CLLocationCoordinate2D!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var photoUrls: [String]?
    
    // MARK: - Actions
    @IBAction func addPressed(_ sender: Any) {
        Task {
            self.activityIndicator.startAnimating()
            
            photoUrls = await search(coordinate: coordinate)
            
            self.activityIndicator.stopAnimating()
            
            performSegue(withIdentifier: "AddPicture", sender: self)
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // If this is an ImagePickerViewConroller, we'll configure its `photoUrls`
        if let vc = segue.destination as? ImagePickerViewController {
            vc.photoURLs = photoUrls!
        }
    }
    
}
