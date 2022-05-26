//
//  TableViewController.swift
//  VirtualTourist
//
//  Created by Joel Stevick on 5/21/22.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    // MARK: - Properties
    var locations: [Location]!
    
    var locationsNotDeleted: [Location] {
        return locations.filter { location in
            let isDeleted = deletedLocations.filter { deletedLocation in
                deletedLocation.id == location.id
            }.count > 0
            
            return !isDeleted
        }
    }
    
    var deletedLocations = [Location]()
    
    var dataController: DataController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if isMovingFromParent {
            StateService.shared.publishDeleteLocationsRequest(locations: deletedLocations)
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return locationsNotDeleted.count
    }
    
    
    // swipe requirements
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { [weak self] action, indexPath in
            
            // defer persist
            if let location = self?.locationsNotDeleted[indexPath.row] {
                
                self?.deletedLocations.append(location as Location)
            
                tableView.reloadData()
            }
        }
        
        return [deleteAction]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let location = locationsNotDeleted[indexPath.row]
        cell.textLabel?.text = "\(location.title!), \(location.subtitle!)"
        
        return cell
    }
    
}
