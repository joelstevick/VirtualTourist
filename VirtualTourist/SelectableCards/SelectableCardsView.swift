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
    @IBOutlet weak var scrollView: UIScrollView!
    
    var delegate: SelectableCardsDataSource?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView() {
        // get the view
        let viewFromXib = Bundle.main.loadNibNamed("SelectableCardsView", owner: self, options: nil)![0] as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
        
        // query the delegate for the number of pictures
        if let delegate = delegate {
            let numberOfCards = delegate.getNumberOfCards()
            
            guard numberOfCards > 0 else {
                noPicturesLabel.isHidden = true
                return
            }
            
            // get each of the cards
            for i in 0..<numberOfCards {
                // get the card
                let card = delegate.getCardAtIndex(at: i)
                
                // setup the image view
                let imageView = UIImageView()
                imageView.image = card.uiImage
                imageView.frame.size.width = Constants.cardWidth
                imageView.frame.size.height = viewFromXib.bounds.height
                imageView.frame.origin.x = (Constants.cardWidth * Double(i))
                imageView.frame.origin.y = 0.0
                
                scrollView.addSubview(imageView)
            }
            
            scrollView.contentSize = CGSize(width: Constants.cardWidth * Double(numberOfCards), height: viewFromXib.bounds.height)
        }
    }
}
