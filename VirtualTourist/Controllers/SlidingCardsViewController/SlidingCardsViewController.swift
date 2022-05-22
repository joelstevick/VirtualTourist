//
//  ImagePickerViewController.swift
//  VirtualTourist
//
//  Created by Joel Stevick on 5/19/22.
//

import UIKit
import CardSlider

class SlidingCardsViewController: UIViewController, UIGestureRecognizerDelegate {

    // MARK: - Properties
    @IBOutlet weak var image1View: UIImageView!
    
    @IBOutlet weak var image2View: UIImageView!
    var photoImages: [UIImage]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        image1View.image = photoImages[0]
        print(photoImages)

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
