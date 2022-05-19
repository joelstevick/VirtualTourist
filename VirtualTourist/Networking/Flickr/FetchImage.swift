//
//  FetchImage.swift
//  VirtualTourist
//
//  Created by Joel Stevick on 5/19/22.
//

import Foundation
import UIKit

func fetchImage(photoUrl: URL, viewController: UIViewController) async -> UIImage? {
    // get data
    do {
        let (data, _) = try await URLSession.shared.data(from: photoUrl)
        
        // convert the data to image
        return UIImage(data: data)!
    } catch {
        print("Error fetching url", error.localizedDescription, photoUrl)
        showError(viewController: viewController, message: "Error fetching URL: \(error.localizedDescription)")
        return nil
    }
    
}
