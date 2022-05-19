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
            let photoUrls = await search(coordinate: coordinate)
            
            // download the images in parallel
            let queue = DispatchQueue(label: "com.joelstevick.download", attributes: .concurrent)
            
            let strongSelf = self
            
            for photoUrl in photoUrls {
                queue.async {
                    guard let data = try? Data(contentsOf: URL(string: photoUrl)!) else {
                        print("Could not get data for url:", photoUrl)
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self.photoImages.append(UIImage(data: data)!)
                        
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
    
}
