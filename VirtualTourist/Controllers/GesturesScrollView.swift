//
//  GesturesScrollView.swift
//  VirtualTourist
//
//  Created by Joel Stevick on 5/24/22.
//

import UIKit

class GesturesScrollView: UIScrollView, UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}
