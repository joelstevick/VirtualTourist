//
//  SelectableCardsView+Gestures.swift
//  VirtualTourist
//
//  Created by Joel Stevick on 5/23/22.
//

import Foundation
import UIKit
import ViewAnimator

extension SelectableCardsView: UIGestureRecognizerDelegate {
    // gesture recognizer
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
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
        
        guard let delegate = delegate else {
            return
        }
        
        guard delegate.canRemoveCards() else {
            return
        }
        if let gestureView = gestureRecognizer.view {
            
           
            // apply visual cue
            UIView.animate(withDuration: 0.5) {
                gestureView.center = CGPoint(x: gestureView.center.x, y: -1 * gestureView.frame.height)
            } completion: { done in
                guard done else {
                    return
                }
                gestureView.superview!.removeFromSuperview()
            }

            // notify the delegate
            let isSelected = selectionState[pageControl.currentPage] == true
            delegate.cardSelectionChanged(card: cards[pageControl.currentPage]!,
                                          selected: isSelected)
            
        }
    }
}
