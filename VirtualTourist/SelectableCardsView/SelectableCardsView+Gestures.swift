//
//  SelectableCardsView+Gestures.swift
//  VirtualTourist
//
//  Created by Joel Stevick on 5/23/22.
//

import Foundation
import UIKit

extension SelectableCardsView {
    // longpress
    @objc func longpressGestureFired(_ gestureRecognizer: UILongPressGestureRecognizer) {
        
        if gestureRecognizer.state == UIGestureRecognizer.State.began {
            // toggle the current selection state
            if selectionState[pageControl.currentPage] != nil {
                selectionState[pageControl.currentPage] = !selectionState[pageControl.currentPage]!
            } else {
                selectionState[pageControl.currentPage] = true
            }
            
            // apply visual cue
            applyVisualCue(cardIndex: pageControl.currentPage,
                           visualCue: selectionState[pageControl.currentPage]! ? CardVisualCue.Selected : CardVisualCue.Default)
            
            // notify the delegate
            if let delegate = delegate {
                delegate.cardSelectionChanged(card: cards[pageControl.currentPage]!,
                                              selected: selectionState[pageControl.currentPage]!)
            }
        }
    }
    
    // swipe
    @objc func swipeGestureFired(_ gestureRecognizer: UISwipeGestureRecognizer) {
        
        if gestureRecognizer.state == UIGestureRecognizer.State.began {
            // toggle the current selection state
            if selectionState[pageControl.currentPage] != nil {
                selectionState[pageControl.currentPage] = !selectionState[pageControl.currentPage]!
            } else {
                selectionState[pageControl.currentPage] = true
            }
            
            // apply visual cue
            applyVisualCue(cardIndex: pageControl.currentPage,
                           visualCue: selectionState[pageControl.currentPage]! ? CardVisualCue.Selected : CardVisualCue.Default)
            
            // notify the delegate
            if let delegate = delegate {
                delegate.cardSelectionChanged(card: cards[pageControl.currentPage]!,
                                              selected: selectionState[pageControl.currentPage]!)
            }
        }
        
    }
}
