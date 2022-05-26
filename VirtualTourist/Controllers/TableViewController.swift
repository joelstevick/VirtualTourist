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
    
    var dataController: DataController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return locations.count
    }
    
    
    // swipe requirements
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { [weak self] action, indexPath in
            
            // persist
            if let location = self?.locations[indexPath.row] {
                
                self?.dataController.viewContext.delete(location)
                
                do {
                    try self?.dataController.viewContext.save()
                } catch {
                    showError(viewController: self!, message: error.localizedDescription)
                }
                
                // update the view
                self?.locations.remove(at: indexPath.row)
                
                tableView.reloadData()
            }
        }
        
        return [deleteAction]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let location = locations[indexPath.row]
        cell.textLabel?.text = "\(location.title!), \(location.subtitle!)"
        
        return cell
    }
    
}
