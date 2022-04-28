//
//  ItemsClass+CoreDataProperties.swift
//  Reitems
//
//  Created by Dennis Anthony on 28/04/22.
//
//

import Foundation
import CoreData


extension ItemsClass {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemsClass> {
        return NSFetchRequest<ItemsClass>(entityName: "Items")
    }

    @NSManaged public var itemName: String?
    @NSManaged public var itemID: Int64
    @NSManaged public var itemLocation: String?
    @NSManaged public var editedTime: String?
    @NSManaged public var locationRelation: LocationsClass?

}

extension ItemsClass : Identifiable {

}
