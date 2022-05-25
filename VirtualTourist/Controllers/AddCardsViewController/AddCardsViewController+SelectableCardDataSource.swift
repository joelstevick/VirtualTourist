//
//  ImageSwiperController+Gestures.swift
//  VirtualTourist
//
//  Created by Joel Stevick on 5/21/22.
//

import Foundation
import UIKit
import NanoID

extension AddCardsViewController: SelectableCardsDataSource {
    func cardRemoved(card: Card) {
        print("card selection state removed", card)
    }
    
    func cardSelectionChanged(card: Card, selected: Bool) {
        card.selected = selected
        card.location = location
        StateService.shared.updateCard(
            card,
            location: location,
            viewController: self,
            dataController: dataController)
        print("card selection state changed", card)
    }
    
    
    func getNumberOfCards() -> Int {
        StateService.shared.getAvailableCards(location: location).count
    }
    
    func getCardAtIndex(at index: Int) -> Card {
        return StateService.shared.getAvailableCards(location: location)[index]
    }
    
    func canRemoveCards() -> Bool {
        return false
    }
    
    
}

