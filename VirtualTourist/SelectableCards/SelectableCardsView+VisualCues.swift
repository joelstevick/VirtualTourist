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
            label.textColor = .white
            label.backgroundColor = .systemGray
            label.font = label.font.withSize(40)
            label.frame.origin = CGPoint(x: 30, y: 5)
            label.frame.size = CGSize(width: 260, height: 40)
            
            imageView.addSubview(label)
            
        case .Selected:
        break
            
        }
    }
}
