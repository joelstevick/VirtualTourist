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
        
        if !(await loadLocal(location: location, dataController: dataController, viewController: viewController,
                           completion: completion)) {
            await loadFromCloud(location: location, dataController: dataController, viewController: viewController, completion: completion)
        }
    }
    func loadLocal(location: Location, dataController: DataController, viewController: UIViewController, completion: (() -> Void)?) async -> Bool {
        
        // try to load from db
        loadLocation(location: location, dataController: dataController)
        return false
        
    }
    func loadFromCloud(location: Location, dataController: DataController, viewController: UIViewController, completion: (() -> Void)?) async {
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
   
    func loadLocation(location: Location, dataController: DataController) -> Bool {
        let fetchRequest:NSFetchRequest<Location> = Location.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "id = %@", location.id!
        )
        do {
            let locationRecord = try dataController.viewContext.fetch(fetchRequest)
            
            print(locationRecord[0].cards?.count)
            return true
        } catch {
            return false
        }
    }
}
