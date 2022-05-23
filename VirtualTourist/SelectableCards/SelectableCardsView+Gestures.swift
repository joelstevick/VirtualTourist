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
            print("gesture fired", pageControl.currentPage)
        }
        
    }
}
