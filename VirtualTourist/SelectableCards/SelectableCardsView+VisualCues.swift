//
//  SelectableCardsView+VisualCues.swift
//  VirtualTourist
//
//  Created by Joel Stevick on 5/23/22.
//

import Foundation
import UIKit

enum CardVisualCue: String {
    case Default
    case Selected
}
extension SelectableCardsView {
    
    func applyVisualCue(cardIndex: Int, visualCue: CardVisualCue) {
        let imageView = imageViews[cardIndex]!
    
        switch visualCue {
        case .Default:
        let label = UILabel()
            label.text = "Press to select"
            label.frame.origin = CGPoint(x: 0, y: 0)
            label.frame.size = CGSize(width: 50, height: 20)
            
            imageView.addSubview(label)
            
        case .Selected:
        break
            
        }
    }
}
