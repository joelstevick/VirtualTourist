//
//  MapViewController+CoreData+Notificaitons.swift
//  VirtualTourist
//
//  Created by Joel Stevick on 5/21/22.
//

import Foundation

extension MapViewController {
    func addSaveNotificationObserver() {
        
        removeSaveNotificationObserver()
        
        saveObserverToken =
        NotificationCenter.default.addObserver(
            forName: .NSManagedObjectContextObjectsDidChange,
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
            self?.load()
        }
    }
}
