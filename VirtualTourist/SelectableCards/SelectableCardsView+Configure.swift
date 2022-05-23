//
//  SelectableCardsView+Configure.swift
//  VirtualTourist
//
//  Created by Joel Stevick on 5/23/22.
//

import Foundation
import UIKit

extension SelectableCardsView {
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
                
                cards[i] = card
                
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
                imageViews[i] = imageView
                
                containerView.addSubview(imageView)
                
                applyVisualCue(cardIndex: i, visualCue: .Default)
                
                // setup a gesture recognizer for long press
                imageView.isUserInteractionEnabled = true
                let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(gestureFired))
                
                imageView.addGestureRecognizer(longPressRecognizer)
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
