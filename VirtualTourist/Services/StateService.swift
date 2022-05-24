//
//  State.swift
//  VirtualTourist
//
//  Created by Joel Stevick on 5/23/22.
//

import Foundation
import CoreLocation
import UIKit
import NanoID

class StateService {
    
    static public let shared = StateService()
    
    private init() {
        
    }
    var cards = [SelectableCard]()
    var photoImages = [UIImage]()
    
    func load(location: Location, viewController: UIViewController, completion: (() -> Void)?) async {
        // reset
        photoImages.removeAll()
        
        // get the photo URLs
        let photoUrls = await search(
            coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
                                        , viewController: viewController)
        
        guard photoUrls.count > 0 else {
            // call completion handler
            if let completion = completion {
                completion()
                
                showError(viewController: viewController, message: "No pictures for this location")
                
                cards.removeAll()
            }
            return
        }
        // download the images in parallel
        let queue = DispatchQueue(label: "com.joelstevick.download", attributes: .concurrent)
        
        for photoUrl in photoUrls {
            // execute in parallel threads
            queue.async {
                
                Task {
                    // download the image
                    let photoImage = await fetchImage(photoUrl: URL(string: photoUrl)!,
                                                      viewController: viewController)
                    
                    // need to serialize on the main thread
                    DispatchQueue.main.async {
                        Task {
                            
                            // add to the lists
                            if let photoImage = photoImage {
                                self.photoImages.append(photoImage)
                                
                                self.cards = self.photoImages.map({ uiImage in
                                    return SelectableCard(id: NanoID.generate(), uiImage: uiImage, selected: false)
                                })
                                
                                // If all images loaded, we are done
                                if self.photoImages.count == photoUrls.count {
                                    // call completion handler
                                    if let completion = completion {
                                        completion()
                                    }
                                }
                            }
                            
                        }
                    }
                }
            }
        }
    }
    
    func getSelectedCards() -> [SelectableCard] {
        return cards.filter { card in
            return card.selected
        }
    }
    
    func getAvailableCards() -> [SelectableCard] {
        return cards.filter { card in
            return !card.selected
        }
    }
    
    func updateCard(_ card: SelectableCard) {
        
        self.cards = self.cards.map({ _card in
            if _card.id == card.id {
                return card
            } else {
                return _card
            }
        })
        publishChanges()
    }
    func publishChanges() {
        NotificationCenter.default.post(name: Notification.Name("*"), object: nil)
    }
}
