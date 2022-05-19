//
//  ShowError.swift
//  OnTheMap
//
//  Created by Joel Stevick on 5/15/22.
//

import Foundation
import UIKit

func showError(viewController: UIViewController, message: String) {
    let alert = UIAlertController(title: "Network Error", message: message, preferredStyle: .alert)
    let cancelAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
    alert.addAction(cancelAction)
    
    DispatchQueue.main.async {
        viewController.present(alert, animated: true, completion: nil)
        
    }
    
}
