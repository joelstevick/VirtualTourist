//
//  DetailViewController+SelectableCardDataSource.swift
//  VirtualTourist
//
//  Created by Joel Stevick on 5/23/22.
//

import Foundation

extension DetailViewController: SelectableCardsDataSource {
    func cardRemoved(card: Card) {
        var updatedCard = card
        updatedCard.selected = false
        StateService.shared.updateCard(
            updatedCard,
            location: location,
            viewController: self,
            dataController: dataController
        )
    }
    
    func getNumberOfCards() -> Int {
        return StateService.shared.getSelectedCards(location: location).count
    }
    
    func getCardAtIndex(at index: Int) -> Card {
        return StateService.shared.getSelectedCards(location: location)[index]
    }
    
    func canRemoveCards() -> Bool {
        return true
    }
    
    func isSelectable() -> Bool {
        return false
    }
    
    func cardSelectionChanged(card: Card, selected: Bool) {
        var updatedCard = card
        updatedCard.selected = true
        StateService.shared.updateCard(
            updatedCard,
            location: location,
            viewController: self,
            dataController: dataController
        )
    }
    
    
}
