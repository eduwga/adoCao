//
//  UserFavorites+CoreDataProperties.swift
//  
//
//  Created by André N. dos Santos on 08/07/22.
//
//

import Foundation
import CoreData


extension UserFavorites {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserFavorites> {
        return NSFetchRequest<UserFavorites>(entityName: "UserFavorites")
    }

    @NSManaged public var userId: Int16
    @NSManaged public var dogId: Int16

}
