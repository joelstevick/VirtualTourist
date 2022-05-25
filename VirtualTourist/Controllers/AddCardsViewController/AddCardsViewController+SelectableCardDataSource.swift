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
        var updatedCard = card
        updatedCard.selected = selected
        updatedCard.location = location
        StateService.shared.updateCard(
            updatedCard,
            location: location,
            viewController: self,
            dataController: dataController)
        print("card selection state changed", updatedCard)
    }
    
    
    func getNumberOfCards() -> Int {
        StateService.shared.getAvailableCards().count
    }
    
    func getCardAtIndex(at index: Int) -> Card {
        return StateService.shared.getAvailableCards()[index]
    }
    
    func canRemoveCards() -> Bool {
        return false
    }
    
    
}

