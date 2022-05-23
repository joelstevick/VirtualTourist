//
//  SelectableCardsView+Gestures.swift
//  VirtualTourist
//
//  Created by Joel Stevick on 5/23/22.
//

import Foundation
import UIKit

extension SelectableCardsView {
    @objc func gestureFired(_ gestureRecognizer: UILongPressGestureRecognizer) {
        
        if gestureRecognizer.state == UIGestureRecognizer.State.began {
            // toggle the current selection state
            if selectionState[pageControl.currentPage] != nil {
                selectionState[pageControl.currentPage] = !selectionState[pageControl.currentPage]!
            } else {
                selectionState[pageControl.currentPage] = true
            }
            
            // notify the delegate
            if let delegate = delegate {
                delegate.cardSelectionChanged(at: pageControl.currentPage,
                                              selected: selectionState[pageControl.currentPage]!)
            }
        }
        
    }
}
