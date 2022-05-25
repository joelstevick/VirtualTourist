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
    actor DownloadCounter {
        var count = 0
        func increment() {
            count += 1
        }
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
            }
            return
        }
        // download the images in parallel
        let queue = DispatchQueue(label: "com.joelstevick.download", attributes: .concurrent)
                
        let downloadCounter = DownloadCounter()
        
        for photoUrl in photoUrls {
            // execute in parallel threads
            queue.async {
                
                Task {
                    await downloadCounter.increment()
                    
                    // download the image
                    let photoImage = await fetchImage(photoUrl: URL(string: photoUrl)!,
                                                      viewController: viewController)
                    
                    // need to serialize on the main thread
                    DispatchQueue.main.async {

                        Task {
                            
                            // add to the lists
                            if let photoImage = photoImage {
                                
                                let card = Card(context: dataController.viewContext)
                                card.id = NanoID.generate()
                                card.uiImage = photoImage
                                card.selected = false
                                card.location = location
                                
                                // If all images downloaded, we are done
                                if await downloadCounter.count == photoUrls.count {
                                    
                                    Task {
                                        // persist the card images for the location
                                        self.saveCardsImages(
                                            location: location,
                                            viewController: viewController,
                                            dataController: dataController
                                        )
                                        
                                        // save to db
                                        do {
                                            try dataController.viewContext.save()
                                        } catch {
                                            showError(viewController: viewController, message: error.localizedDescription)
                                        }
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
        print(location.cards?.count)
        if let cards = location.cards {
            
            guard cards.count > 0 else {
                return false
            }
            for _card in cards {
                let card = _card as! Card
                let fileURL = getFileUrl(cardId: card.id!, viewController: viewController)!
                if let photoImage = UIImage(contentsOfFile: fileURL.path) {
                    
                    card.uiImage = photoImage
                    
                } else {
                    return false
                }
            }
            print("selected", getSelectedCards(location: location).count)
            return true
        } else {
            return false
        }
    }
}