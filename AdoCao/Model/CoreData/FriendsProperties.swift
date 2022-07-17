//
//  Friends+CoreDataProperties.swift
//  
//
//  Created by André N. dos Santos on 08/07/22.
//
//

import Foundation
import CoreData


extension Friends {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friends> {
        return NSFetchRequest<Friends>(entityName: "Friends")
    }

    @NSManaged public var id: Int16
    @NSManaged public var nome: String?
    @NSManaged public var idade: Int16
    @NSManaged public var racaNome: String?
    @NSManaged public var racaId: Int16
    @NSManaged public var tutorNome: String?
    @NSManaged public var tutorId: Int16
    @NSManaged public var porte: Int16
    @NSManaged public var foto: Data?
    @NSManaged public var latitude: String?
    @NSManaged public var longitude: String?
    @NSManaged public var descricao: String?
    @NSManaged public var caracteristicas: String?
}
