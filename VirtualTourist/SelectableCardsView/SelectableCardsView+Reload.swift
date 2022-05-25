//
//  SelectableCardsView+Configure.swift
//  VirtualTourist
//
//  Created by Joel Stevick on 5/23/22.
//

import Foundation
import UIKit

extension SelectableCardsView {
    func reload() {
        
        configured = true
        
        let rect = CGRect(origin:frame.origin, size:frame.size)
        
        // query the delegate for the number of pictures
        if let delegate = delegate {
            numberOfCards = delegate.getNumberOfCards()
            
            // create the scrollView
            scrollView = GesturesScrollView(frame: rect)
            scrollView.autoresizingMask = [.flexibleWidth]
            scrollView.backgroundColor = .white
            scrollView.isPagingEnabled = true
            addSubview(scrollView)
            
            // wire-up the scrollView to the page control
            scrollView.delegate = self
            
            // check for no pictures selected
            guard numberOfCards > 0 else {
                
                let noPicturesLabel = UILabel(frame: CGRect(x: 0, y: 0, width: rect.width, height: 200))
                noPicturesLabel.text = "No Pictures Selected"
                noPicturesLabel.textAlignment = .center
                noPicturesLabel.textColor = .gray
    
                addSubview(noPicturesLabel)
                return
            }
            imageWidth = rect.width
            
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
            
            // get each of the cards
            for i in 0..<numberOfCards {
                // get the card
                let card = delegate.getCardAtIndex(at: i)
                
                cards[i] = card
           
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
                
                scrollView.addSubview(imageView)
                
                imageView.isUserInteractionEnabled = true
                if delegate.isSelectable() {
                    // default visual que
                    applyVisualCue(cardIndex: i, visualCue: .Default)
                    
                    // setup a gesture recognizer for long press
                    let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longpressGestureFired))
                    
                    imageView.addGestureRecognizer(longPressRecognizer)
                }
                // setup a gesture recognizer for swipe
                let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureFired))
                swipeRecognizer.direction = .up
                swipeRecognizer.numberOfTouchesRequired = 1
                imageView.addGestureRecognizer(swipeRecognizer)
            }
            
            scrollView.contentSize = CGSize(width: imageWidth * Double(numberOfCards), height: frame.height - paginatorHeight)
    
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
