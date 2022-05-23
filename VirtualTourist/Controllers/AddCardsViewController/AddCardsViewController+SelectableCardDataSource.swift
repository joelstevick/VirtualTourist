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
    func cardSelectionChanged(at index: Int, selected: Bool) {
        print("card selection state changed", index, selected)
    }
    
    func getNumberOfCards() -> Int {
        photoImages.count
    }
    
    func getCardAtIndex(at index: Int) -> SelectableCard {
        return SelectableCard(id: NanoID.generate(), uiImage: photoImages[index])
    }
    
    func canRemoveCards() -> Bool {
        return false
    }
    
    
}

