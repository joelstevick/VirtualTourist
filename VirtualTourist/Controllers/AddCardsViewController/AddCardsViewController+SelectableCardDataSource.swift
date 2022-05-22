//
//  ImageSwiperController+Gestures.swift
//  VirtualTourist
//
//  Created by Joel Stevick on 5/21/22.
//

import Foundation
import UIKit

extension AddCardsViewController: SelectableCardsDataSource {
    func getNumberOfCards() -> Int {
        photoImages.count
    }
    
    func getCardAtIndex(at index: Int) -> SelectableCard {
        return SelectableCard(uiImage: photoImages[index])
    }
    
    func canRemoveCards() -> Bool {
        return false
    }
    
    
}

