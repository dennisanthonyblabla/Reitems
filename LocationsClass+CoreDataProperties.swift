//
//  LocationsClass+CoreDataProperties.swift
//  Reitems
//
//  Created by Dennis Anthony on 28/04/22.
//
//

import Foundation
import CoreData


extension LocationsClass {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocationsClass> {
        return NSFetchRequest<LocationsClass>(entityName: "Locations")
    }

    @NSManaged public var location: String?
    @NSManaged public var itemsRelation: NSSet?
    
    public var itemArray : [ItemsClass]?
    {
        get
    {
    return itemsRelation?.allObjects as? [ItemsClass]
        }
    }

//    public var itemArray: [ItemsClass] {
////        let setitem = itemsRelation
////        return setitem!.sorted {
////            $0.wrappedItemName > $1.wrappedItemName
//
//        let set = itemsRelation as? Set<ItemsClass> ?? []
//        return set.sorted {
//            $0.itemID < $1.itemID
//        }
//    }
    
}

// MARK: Generated accessors for itemsRelation
extension LocationsClass {

    @objc(addItemsRelationObject:)
    @NSManaged public func addToItemsRelation(_ value: ItemsClass)

    @objc(removeItemsRelationObject:)
    @NSManaged public func removeFromItemsRelation(_ value: ItemsClass)

    @objc(addItemsRelation:)
    @NSManaged public func addToItemsRelation(_ values: NSSet)

    @objc(removeItemsRelation:)
    @NSManaged public func removeFromItemsRelation(_ values: NSSet)

}

extension LocationsClass : Identifiable {

}
