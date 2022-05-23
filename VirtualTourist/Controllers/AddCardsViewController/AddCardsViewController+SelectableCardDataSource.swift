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
    func cardRemoved(card: SelectableCard) {
        print("card selection state removed", card)
    }
    
    func cardSelectionChanged(card: SelectableCard, selected: Bool) {
        print("card selection state changed", card, selected)
    }
    
    
    func getNumberOfCards() -> Int {
        StateService.shared.getAvailableCards().count
    }
    
    func getCardAtIndex(at index: Int) -> SelectableCard {
        return StateService.shared.getAvailableCards()[index]
    }
    
    func canRemoveCards() -> Bool {
        return false
    }
    
    
}

