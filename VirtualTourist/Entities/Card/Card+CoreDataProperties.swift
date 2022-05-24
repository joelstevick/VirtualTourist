//
//  Card+CoreDataProperties.swift
//  VirtualTourist
//
//  Created by Joel Stevick on 5/24/22.
//
//

import Foundation
import CoreData


extension Card {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Card> {
        return NSFetchRequest<Card>(entityName: "Card")
    }

    @NSManaged public var attribute: String?
    @NSManaged public var selected: Bool
    @NSManaged public var location: Location?

}

extension Card : Identifiable {

}
