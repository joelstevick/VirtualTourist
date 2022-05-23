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
        // remove current visual cue
        if  let visualCueView = currentVisualCue[cardIndex] {
            visualCueView.removeFromSuperview()
        }
        
        // apply the new visual que
        let imageView = imageViews[cardIndex]!
        let labelWidth = 260
        let systemImageDim = 40
    
        switch visualCue {
    
            // press to select
        case .Default:
        let label = UILabel()
            label.text = "Press to select"
            label.textColor = .white
            label.backgroundColor = .systemGray
            label.font = label.font.withSize(40)
            label.frame.origin = CGPoint(x: (Int(frame.width) - labelWidth)/2, y: 0)
            label.frame.size = CGSize(width: labelWidth, height: 40)
            
            imageView.addSubview(label)
            
            currentVisualCue[cardIndex] = label
            
            // selected
        case .Selected:
            let checkView = UIImageView()
            checkView.image =  UIImage.checkmark
            checkView.frame.origin = CGPoint(x: (Int(frame.width) - systemImageDim)/2, y: 20)
            checkView.frame.size = CGSize(width: systemImageDim, height: systemImageDim)
            
            imageView.addSubview(checkView)
            
            currentVisualCue[cardIndex] = checkView
            
        }
    }
}
