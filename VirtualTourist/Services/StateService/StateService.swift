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
    
    func updateCard(_ card: SelectableCard, location: Location, viewController: UIViewController, dataController: DataController) {
        
        self.cards = self.cards.map({ _card in
            if _card.id == card.id {
                return card
            } else {
                return _card
            }
        })
        saveCards(location: location, cards: self.cards, viewController: viewController, dataController: dataController)
        
        publishChanges()
    }
    func publishChanges() {
        NotificationCenter.default.post(name: Notification.Name("*"), object: nil)
    }
}
