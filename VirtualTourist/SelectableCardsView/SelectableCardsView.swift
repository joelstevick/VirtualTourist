//
//  SelectableCardsView.swift
//  VirtualTourist
//
//  Created by Joel Stevick on 5/22/22.
//

import UIKit

protocol SelectableCardsDataSource {
    func getNumberOfCards() -> Int
    func getCardAtIndex(at index: Int) -> Card
    func canRemoveCards() -> Bool
    func isSelectable() -> Bool
    func cardRemoved(card: Card) -> Void
    func cardSelectionChanged(card: Card, selected: Bool) -> Void
}

extension SelectableCardsDataSource {
    func cardRemoved(card: Card) {}
    func isSelectable() -> Bool {
        return true
    }
}
class SelectableCardsView: UIView {
    
    // MARK: - Properties
    var noPicturesLabel: UILabel?
    
    var delegate: SelectableCardsDataSource?
    var imageWidth: Double!
    var scrollView: UIScrollView!
    var pageControl: UIPageControl!
    var numberOfCards: Int!
    
    var selectionState = [Int: Bool]()
    var imageViews = [Int: UIImageView]()
    var currentVisualCue = [Int: UIView]()
    var cards = [Int: Card]()
    
    var configured = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func draw(_ rect: CGRect) {
        if (!configured) {
            reload()
        }
    }
}
