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
        
        selectableCardView.delegate = self
        
        // listen for changes
        NotificationCenter.default.addObserver(self, selector: #selector(refresh), name: Notification.Name("*"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.activityIndicator.startAnimating()
        
        // reload pics for this location
        Task {
            await StateService.shared.load(location: self.location, dataController: dataController, viewController: self, completion:  {
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    
                    self.selectableCardView.reload()
                }
                
            })
        }
    
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let addCardVC = segue.destination as! AddCardsViewController
        addCardVC.dataController = dataController
        addCardVC.location =  location
    }
    
    // MARK: - Utility functions
    @objc func refresh() {
        selectableCardView.reload()
    }
}
