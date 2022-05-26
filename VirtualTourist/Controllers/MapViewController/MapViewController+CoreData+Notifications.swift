//
//  MapViewController+CoreData+Notifications.swift
//  VirtualTourist
//
//  Created by Joel Stevick on 5/21/22.
//

import Foundation

extension MapViewController {
    
    // MARK: - Save Observer
    func addSaveNotificationObserver() {
        
        removeSaveNotificationObserver()
        
        saveObserverToken =
        NotificationCenter.default.addObserver(
            forName: .NSManagedObjectContextDidSave,
            object:dataController.viewContext,
            queue:nil,
            using:handleSaveNotication(notification:))
        
    }
    func removeSaveNotificationObserver() {
        if let token = saveObserverToken {
            NotificationCenter.default.removeObserver(token)
            
            saveObserverToken = nil
        }
    }
    func handleSaveNotication(notification: Notification) {
       
        DispatchQueue.main.async { [weak self] in
            // clear the map
            if let savedAnnotations = self?.savedAnnotations {
                self?.mapView.removeAnnotations(savedAnnotations)
            }
            // reload the map
            self?.load()
        }
    }
    // MARK: - delete Locations observer
    func addDeleteLocationsNotificationObserver() {
        
        removeDeleteLocationsNotificationObserver()
        
        deleteLocationsObserverToken =
        NotificationCenter.default.addObserver(
            forName: Notification.Name("delete-locations"),
            object:nil,
            queue:nil,
            using:handleDeleteLocationsNotication(notification:))
        
    }
    func removeDeleteLocationsNotificationObserver() {
        if let token = deleteLocationsObserverToken {
            NotificationCenter.default.removeObserver(token)
            
            deleteLocationsObserverToken = nil
        }
    }
    func handleDeleteLocationsNotication(notification: Notification) {
        
        DispatchQueue.main.async { [weak self] in
            let deletedLocations = notification.object as! [Location]
            
            for location in deletedLocations {
                self?.dataController.viewContext.delete(location)
            }
            
            do {
                try self!.dataController.viewContext.save()
            } catch {
                showError(viewController: self!, message: error.localizedDescription)
            }
            // clear the map
            if let savedAnnotations = self?.savedAnnotations {
                self?.mapView.removeAnnotations(savedAnnotations)
            }
            // reload the map
            self?.load()
        }
    }
}
