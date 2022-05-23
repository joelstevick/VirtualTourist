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
    func configure() {
      
        configured = true
        
        let rect = CGRect(origin:frame.origin, size:frame.size)
        
        // query the delegate for the number of pictures
        if let delegate = delegate {
            numberOfCards = delegate.getNumberOfCards()
            
            guard numberOfCards > 0 else {
                noPicturesLabel.isHidden = true
                return
            }
            imageWidth = rect.width
            
            // create the scrollView
            scrollView = UIScrollView(frame: rect)
            scrollView.autoresizingMask = [.flexibleWidth]
            scrollView.backgroundColor = .white
            scrollView.isPagingEnabled = true
            addSubview(scrollView)
            
            // wire-up the scrollView to the page control
            scrollView.delegate = self
            
            // add a paginator
            let paginatorHeight = 70.0
            
            pageControl = {
                let pageControl = UIPageControl()
                pageControl.numberOfPages = numberOfCards
                pageControl.frame = CGRect(
                    x: 0,
                    y: rect.size.height - paginatorHeight,
                    width: rect.size.width,
                    height: paginatorHeight)
                pageControl.backgroundColor = .systemBlue
                return pageControl
            }()
            addSubview(pageControl)
            
            // wire-up the page control to the scrollView
            pageControl.addTarget(self, action: #selector(pageControlValueChanged), for: .valueChanged)
            
            // create a containerView
            let containerView = UIView()
            containerView.frame.size = CGSize(width: imageWidth * Double(numberOfCards), height: frame.height - paginatorHeight)
            
            scrollView.addSubview(containerView)
            
            // get each of the cards
            for i in 0..<numberOfCards {
                // get the card
                let card = delegate.getCardAtIndex(at: i)
                
                scrollView.addSubview(containerView)
                // setup the image view
                let imageView = UIImageView()
                imageView.image = card.uiImage
                imageView.frame.size.width = imageWidth
                imageView.frame.size.height = rect.height - paginatorHeight
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
    
    @objc private func pageControlValueChanged(_ sender: UIPageControl) {
        let current = sender.currentPage
        
        scrollView.setContentOffset(CGPoint(
            x: CGFloat(current) * frame.width,
            y: 0
        ), animated: true)
    }
}
