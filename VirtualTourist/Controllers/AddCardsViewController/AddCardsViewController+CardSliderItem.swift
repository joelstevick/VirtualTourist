//
//  ImageSwiperController+Gestures.swift
//  VirtualTourist
//
//  Created by Joel Stevick on 5/21/22.
//

import Foundation
import UIKit
import CardSlider

struct Item: CardSliderItem {
    var image: UIImage
    
    var rating: Int?
    
    var title: String
    
    var subtitle: String?
    
    var description: String?
}

extension AddCardsViewController: CardSliderDataSource {
    func item(for index: Int) -> CardSliderItem {
        let photoImage = photoImages[index]
        return Item(
            image: photoImage,
            rating: nil,
            title: "title \(index)",
            subtitle: "subtitle \(index)",
            description: nil
        )
    }
    
    func numberOfItems() -> Int {
        photoImages.count
    }
    
    
}

