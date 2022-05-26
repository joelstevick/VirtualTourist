//
//  Location+CRUD.swift
//  VirtualTourist
//
//  Created by Joel Stevick on 5/24/22.
//

import Foundation
import CoreData
import UIKit
import NanoID

extension Location {
    func getAll(context: NSManagedObjectContext, viewController: UIViewController) -> [Location]? {
        do {
            let locations = try context.fetch(Location.fetchRequest())
            
            return locations
        } catch {
            showError(viewController: viewController, message: error.localizedDescription)
            return nil
        }
    }
    
    public static func create(
        latitude: Double,
        longitude: Double,
        title: String?,
        subtitle: String?,
        context: NSManagedObjectContext,
        viewController: UIViewController
    ) -> Location {
        let location = Location(context: context)
        location.id = NanoID.generate()
        location.title = title
        location.subtitle = subtitle
        location.longitude = longitude
        location.latitude = latitude
        location.creationDate = Date()
        
        do {
            try context.save()
            
            return location
        } catch {
            showError(viewController: viewController, message: error.localizedDescription)
            fatalError(error.localizedDescription)
        }
        
    }
    
    public static func update(location: Location, context: NSManagedObjectContext, viewController: UIViewController) {
        do {
            try context.save()
        } catch {
            showError(viewController: viewController, message: error.localizedDescription)
            fatalError(error.localizedDescription)
        }
    }
    public static func delete(location: Location, context: NSManagedObjectContext, viewController: UIViewController) {
        context.delete(location)
        
        do {
            try context.save()
        } catch {
            showError(viewController: viewController, message: error.localizedDescription)
            fatalError(error.localizedDescription)
        }
    }
    
    public static func get(id: String, context: NSManagedObjectContext, viewController: UIViewController) -> Location? {
        let fetchRequest: NSFetchRequest<Location> = Location.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(
            format: "id == %@", id
        )
        
        do {
            let locations = try context.fetch(fetchRequest)
            
            return locations.first
        } catch {
            fatalError("The fetch could not be performed: \(error.localizedDescription)")
        }
    }
}
