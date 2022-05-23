//
//  SelectableCardsView.swift
//  VirtualTourist
//
//  Created by Joel Stevick on 5/22/22.
//

import UIKit

protocol SelectableCardsDataSource {
    func getNumberOfCards() -> Int
    func getCardAtIndex(at index: Int) -> SelectableCard
    func canRemoveCards() -> Bool
    func cardRemoved(at index: Int) -> Void
}

extension SelectableCardsDataSource {
    func cardRemoved(at index: Int) {
        
    }
}
class SelectableCardsView: UIView {
    
    // MARK: - Properties
    @IBOutlet weak var noPicturesLabel: UILabel!
    
    var delegate: SelectableCardsDataSource?
    var imageWidth: Double!
    var scrollView: UIScrollView!
    var pageControl: UIPageControl!
    var numberOfCards: Int!
    
    var configured = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func draw(_ rect: CGRect) {
        if (!configured) {
            configure()
        }
    }
    
    
}
