//
//  ImagePickerViewController.swift
//  VirtualTourist
//
//  Created by Joel Stevick on 5/19/22.
//

import UIKit


class AddCardsViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var selectableCardView: SelectableCardsView!
    var location: Location!
    var dataController: DataController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectableCardView.delegate = self
    }
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
