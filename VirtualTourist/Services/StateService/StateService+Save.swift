//
//  StateService+Save.swift
//  VirtualTourist
//
//  Created by Joel Stevick on 5/25/22.
//

import UIKit
import CoreData
import CoreLocation
import NanoID

extension StateService {
    func saveCardImage(
        card: Card,
        viewController: UIViewController,
        dataController: DataController
    ) {
        
        // persist the image to the filesystem
        let manager = FileManager.default
        
        // save to the file
        if let fileUrl = getFileUrl(cardId: card.id!, viewController: viewController),
           let uiImage = card.uiImage {
            manager.createFile(atPath: fileUrl.path, contents: uiImage.jpegData(compressionQuality: 1.0))
        } else {
            return
        }
        
    }
    
    func getFileUrl(cardId: String, viewController: UIViewController) -> URL? {
        let manager = FileManager.default
        
        guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            showError(viewController: viewController, message: "Could not get File URL")
            return nil
        }
        // create the card-images folder
        let folderUrl = url.appendingPathComponent(Constants.cardImages.rawValue)
        
        do {
            try manager.createDirectory(at: folderUrl, withIntermediateDirectories: true)
        } catch {
            showError(viewController: viewController, message: error.localizedDescription)
        }
        
        // file URL
        return folderUrl.appendingPathComponent("\(Constants.cardPrefix.rawValue)-\(cardId)")
        
    }
}
