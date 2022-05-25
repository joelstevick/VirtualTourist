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
    func saveCards(
        location: Location,
        viewController: UIViewController,
        dataController: DataController
    ) {
        (location.cards as? NSMutableSet)?.removeAllObjects()
        
        print("selected cards", getSelectedCards(location: location).count, location.cards!.count, location.cards?.count ?? -1)
        // persist each image to the filesystem
        for _card in location.cards! {
            let manager = FileManager.default
            
            let card = _card as! Card
            
            // save to the file
            if let fileUrl = getFileUrl(cardId: card.id!, viewController: viewController) {
                manager.createFile(atPath: fileUrl.path, contents: card.uiImage!.jpegData(compressionQuality: 1.0))
            } else {
                return
            }
        }
        // save into the db
        Task {
            do {
                try dataController.viewContext.save()
            } catch {
                showError(viewController: viewController, message: error.localizedDescription)
            }
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
