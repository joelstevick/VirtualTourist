//
//  State.swift
//  VirtualTourist
//
//  Created by Joel Stevick on 5/23/22.
//

import Foundation
import CoreLocation
import UIKit
import NanoID
import CoreData

enum Constants: String {
    case cardImages = "card-images"
    case cardPrefix = "card"
}

class StateService {
    
    static public let shared = StateService()
    
    private init() {
        
    }
    var cards = [SelectableCard]()
    var photoImages = [UIImage]()
    
    // MARK: - Load
    
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
            
            guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else {
                return
            }
            
            // create the card-images folder
            let folderUrl = url.appendingPathComponent(Constants.cardImages.rawValue)
            
            do {
                try manager.createDirectory(at: folderUrl, withIntermediateDirectories: true)
            } catch {
                showError(viewController: viewController, message: error.localizedDescription)
            }
            
            // save to the file
            let fileUrl = folderUrl.appendingPathComponent("\(Constants.cardPrefix.rawValue)-\(card.id)")
            
            manager.createFile(atPath: fileUrl.path, contents: card.uiImage.jpegData(compressionQuality: 1.0))
            
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
    
    func loadLocation(location: Location, dataController: DataController) -> Bool {
        let fetchRequest:NSFetchRequest<Location> = Location.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "id = %@", location.id!
        )
        do {
            let locationRecord = try dataController.viewContext.fetch(fetchRequest)
            
            print(locationRecord[0].cards?.count)
            return true
        } catch {
            return false
        }
    }
    func getSelectedCards() -> [SelectableCard] {
        return cards.filter { card in
            return card.selected
        }
    }
    
    func getAvailableCards() -> [SelectableCard] {
        return cards.filter { card in
            return !card.selected
        }
    }
    
    func updateCard(_ card: SelectableCard) {
        
        self.cards = self.cards.map({ _card in
            if _card.id == card.id {
                return card
            } else {
                return _card
            }
        })
        publishChanges()
    }
    func publishChanges() {
        NotificationCenter.default.post(name: Notification.Name("*"), object: nil)
    }
}
