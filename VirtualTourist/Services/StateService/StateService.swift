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
    
    func getSelectedCards(location: Location) -> [Card] {
        return location.cards?.filter { card in
            return (card as AnyObject).selected
        } as! [Card]
    }
    
    func getAvailableCards(location: Location) -> [Card] {
        return location.cards?.filter { card in
            return !(card as AnyObject).selected
        } as! [Card]
    }
    
    func updateCard(_ card: Card, location: Location, viewController: UIViewController, dataController: DataController) {
        
        saveCards(location: location, viewController: viewController, dataController: dataController)
        
        publishChanges()
    }
    func publishChanges() {
        NotificationCenter.default.post(name: Notification.Name("*"), object: nil)
    }
}
