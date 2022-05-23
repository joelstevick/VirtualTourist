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
        let labelWidth = 260
    
        switch visualCue {
        case .Default:
        let label = UILabel()
            label.text = "Press to select"
            label.textColor = .white
            label.backgroundColor = .systemGray
            label.font = label.font.withSize(40)
            label.frame.origin = CGPoint(x: (Int(frame.width) - labelWidth)/2, y: 5)
            label.frame.size = CGSize(width: labelWidth, height: 400
            
            imageView.addSubview(label)
            
        case .Selected:
        break
            
        }
    }
}
