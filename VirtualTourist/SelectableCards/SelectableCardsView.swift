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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func draw(_ rect: CGRect) {
      
        // query the delegate for the number of pictures
        if let delegate = delegate {
            let numberOfCards = delegate.getNumberOfCards()
            
            guard numberOfCards > 0 else {
                noPicturesLabel.isHidden = true
                return
            }
            let imageWidth = rect.width
            
            // create the scrollView
            let scrollView = UIScrollView(frame: rect)
            scrollView.autoresizingMask = [.flexibleWidth]
            scrollView.backgroundColor = .white
            scrollView.isPagingEnabled = true
            addSubview(scrollView)
            
            // add a paginator
            let pageControl: UIPageControl = {
                let pageControl = UIPageControl()
                pageControl.numberOfPages = numberOfCards
                pageControl.frame = CGRect(
                    x: 10,
                    y: rect.size.height - 100,
                    width: rect.size.width - 20,
                    height: 70)
                pageControl.backgroundColor = .systemBlue
                return pageControl
            }()
            addSubview(pageControl)
            
            // create a containerView
            let containerView = UIView()
            containerView.frame.size = CGSize(width: imageWidth * Double(numberOfCards), height: frame.height)
            
            scrollView.addSubview(containerView)
            
            // get each of the cards
            for i in 0..<numberOfCards {
                // get the card
                let card = delegate.getCardAtIndex(at: i)
                
                scrollView.addSubview(containerView)
                // setup the image view
                let imageView = UIImageView()
                imageView.image = card.uiImage
                imageView.layer.borderColor = UIColor.blue.cgColor
                imageView.layer.borderWidth = 1
                imageView.frame.size.width = imageWidth
                imageView.frame.size.height = rect.height
                imageView.frame.origin.x = (imageWidth * Double(i))
                imageView.frame.origin.y = 0.0
                imageView.contentMode = UIView.ContentMode.scaleAspectFill
                imageView.layer.masksToBounds = true
                
                containerView.addSubview(imageView)
            }
            
            scrollView.contentSize = containerView.frame.size
    
            print(scrollView.contentSize)
        }
    }
}
