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
    
    @IBOutlet weak var selectableCardView: SelectableCardsView!
    
    
    // MARK: - Actions
    @IBAction func addPressed(_ sender: Any) {
        // perform the segue
        self.activityIndicator.stopAnimating()
        
        self.performSegue(withIdentifier: "AddPicture", sender: self)
    }
    // MARK: - Lifecyle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.startAnimating()
        
        Task {
            await StateService.shared.load(coordinate: coordinate, viewController: self, completion:  {
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                }
                
            })
        }
    
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // If this is an ImagePickerViewConroller, we'll configure its `photoUrls`
//        if let vc = segue.destination as? AddCardsViewController {
//           
//        }
    }
    
    // MARK: - Utility functions
    
}
