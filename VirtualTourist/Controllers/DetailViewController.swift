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
            
            let strongSelf = self
            
            for photoUrl in photoUrls {
                queue.async {
                    
                    DispatchQueue.main.async {
                        Task {
                            // download the image
                            let photoImage = await self.fetchImage(URL(string: photoUrl)!)
                            
                            // add to the list
                            if let photoImage = photoImage {
                                self.photoImages.append(photoImage)
                                
                                // If all images loaded, perform the segue
                                if self.photoImages.count == photoUrl.count {
                                    // perform the segue
                                    self.activityIndicator.stopAnimating()
                                    
                                    strongSelf.performSegue(withIdentifier: "AddPicture", sender: strongSelf)
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
        if let vc = segue.destination as? ImagePickerViewController {
            vc.photoImages = photoImages
        }
    }
    
    // MARK: - Utility functions
    private func fetchImage(_ photoUrl: URL) async -> UIImage? {
        // get data
        do {
            let (data, _) = try await URLSession.shared.data(from: photoUrl)
            
            // convert the data to image
            return UIImage(data: data)!
        } catch {
            print("Error fetching url", error.localizedDescription, photoUrl)
            showError(viewController: self, message: "Error fetching URL: \(error.localizedDescription)")
            return nil
        }
        
    }
}
