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
        cards: [SelectableCard],
        viewController: UIViewController,
        dataController: DataController
    ) {
        
        // add to the location record
        cards.forEach { card in
            let cardEntity = Card(context: dataController.viewContext)
            
            location.cards = location.cards!.adding(cardEntity) as NSSet
        }
        
        // persist each image to the filesystem
        for card in cards {
            let manager = FileManager.default
            
            // save to the file
            if let fileUrl = getFileUrl(card: card, viewController: viewController) {
                manager.createFile(atPath: fileUrl.path, contents: card.uiImage.jpegData(compressionQuality: 1.0))
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
    
    func getFileUrl(card: SelectableCard, viewController: UIViewController) -> URL? {
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
        return folderUrl.appendingPathComponent("\(Constants.cardPrefix.rawValue)-\(card.id)")
        
    }
}
