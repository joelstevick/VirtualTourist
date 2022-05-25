//
//  StateService+Load.swift
//  VirtualTourist
//
//  Created by Joel Stevick on 5/25/22.
//

import UIKit
import CoreData
import CoreLocation
import NanoID

extension StateService {
    func load(location: Location, dataController: DataController, viewController: UIViewController, completion: (() -> Void)?) async {
        
        // reset
        photoImages.removeAll()
        
        // try to load locally, then from the cloud if needed
        if !(await loadLocal(location: location, dataController: dataController, viewController: viewController,
                             completion: completion)) {
            await loadFromCloud(location: location, dataController: dataController, viewController: viewController, completion: completion)
        }
    }
    func loadLocal(location: Location, dataController: DataController, viewController: UIViewController, completion: (() -> Void)?) async -> Bool {
        
        // try to load from db
        let loaded = loadLocation(location: location, dataController: dataController, viewController: viewController)
        
        if loaded {
            // call completion handler
            if let completion = completion {
                completion()
            }
        }
        
        return loaded
    }
    func loadFromCloud(location: Location, dataController: DataController, viewController: UIViewController, completion: (() -> Void)?) async {
       
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
                                    
                                    Task {
                                        // persist the cards for the location
                                        self.saveCards(
                                            location: location,
                                            cards: self.cards,
                                            viewController: viewController,
                                            dataController: dataController
                                        )
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
    }
    
    func loadLocation(location: Location, dataController: DataController, viewController: UIViewController) -> Bool {
        
        // for each card, load the image
        if let cards = location.cards {
            
            guard cards.count > 0 else {
                return false
            }
            print("loadLocation", cards.count, self.photoImages.count)
            for card in cards {
                let fileURL = getFileUrl(cardId: (card as! Card).id!, viewController: viewController)!
                if let photoImage = UIImage(contentsOfFile: fileURL.path) {
                    self.photoImages.append(photoImage)
                    self.cards.append(SelectableCard(id: (card as! Card).id!, uiImage: photoImage, selected: (card as! Card).selected))
                } else {
                    return false
                }
            }
            print("selected", getSelectedCards().count)
            return true
        } else {
            return false
        }
    }
}
