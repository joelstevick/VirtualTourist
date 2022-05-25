//
//  DetailViewController+SelectableCardDataSource.swift
//  VirtualTourist
//
//  Created by Joel Stevick on 5/23/22.
//

import Foundation

extension DetailViewController: SelectableCardsDataSource {
    func cardRemoved(card: SelectableCard) {
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
        print("getNumberOfCards -> ", StateService.shared.getSelectedCards().count )
        return StateService.shared.getSelectedCards().count
    }
    
    func getCardAtIndex(at index: Int) -> SelectableCard {
        return StateService.shared.getSelectedCards()[index]
    }
    
    func canRemoveCards() -> Bool {
        return true
    }
    
    func isSelectable() -> Bool {
        return false
    }
    
    func cardSelectionChanged(card: SelectableCard, selected: Bool) {
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
