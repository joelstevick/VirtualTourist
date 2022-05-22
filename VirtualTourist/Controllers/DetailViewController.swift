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
    
    var photoImages = [UIImage]()
    
    // MARK: - Actions
    @IBAction func addPressed(_ sender: Any) {
        Task {
            self.activityIndicator.startAnimating()
            
            // get the photo URLs
            let photoUrls = await search(coordinate: coordinate, viewController: self)
            
            // download the images in parallel
            let queue = DispatchQueue(label: "com.joelstevick.download", attributes: .concurrent)
         
            for photoUrl in photoUrls {
                // execute in parallel threads
                queue.async {
                    
                    Task {
                        // download the image
                        let photoImage = await fetchImage(photoUrl: URL(string: photoUrl)!, viewController: self)
                        
                        // need to serialize on the main thread
                        DispatchQueue.main.async {
                            Task {
                                
                                // add to the list
                                if let photoImage = photoImage {
                                    self.photoImages.append(photoImage)
                                    
                                    // If all images loaded, perform the segue
                                    if self.photoImages.count == photoUrls.count {
                                        // perform the segue
                                        self.activityIndicator.stopAnimating()
                                        
                                        self.performSegue(withIdentifier: "AddPicture", sender: self)
                                    }
                                }
                                
                            }
                        }
                    }
                }
            }
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // If this is an ImagePickerViewConroller, we'll configure its `photoUrls`
        if let vc = segue.destination as? AddCardsViewController {
            vc.photoImages = photoImages
        }
    }
    
    // MARK: - Utility functions
    
}
