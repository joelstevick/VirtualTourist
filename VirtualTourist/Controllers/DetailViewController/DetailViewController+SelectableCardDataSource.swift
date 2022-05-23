//
//  DetailViewController+SelectableCardDataSource.swift
//  VirtualTourist
//
//  Created by Joel Stevick on 5/23/22.
//

import Foundation

extension DetailViewController: SelectableCardsDataSource {
    func cardRemoved(card: SelectableCard) {
        
    }
    
    func getNumberOfCards() -> Int {
        StateService.shared.selectedCards.count
    }
    
    func getCardAtIndex(at index: Int) -> SelectableCard {
        return StateService.shared.selectedCards[index]
    }
    
    func canRemoveCards() -> Bool {
        return true
    }
    
    func cardSelectionChanged(card: SelectableCard, selected: Bool) {
    }
    
    
}
