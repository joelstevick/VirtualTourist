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
    var location: Location!
    var dataController: DataController!
        
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var selectableCardView: SelectableCardsView!
    
    
    // MARK: - Actions
    @IBAction func addPressed(_ sender: Any) {
        // perform the segue
        self.performSegue(withIdentifier: "AddPicture", sender: self)
    }
    // MARK: - Lifecyle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.startAnimating()
        selectableCardView.delegate = self
        
        Task {
            await StateService.shared.load(location: self.location, dataController: dataController, viewController: self, completion:  {
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                }
                
            })
        }
    
        // listen for changes
        NotificationCenter.default.addObserver(self, selector: #selector(refresh), name: Notification.Name("*"), object: nil)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    // MARK: - Utility functions
    @objc func refresh() {
        selectableCardView.reload()
    }
}
