//
//  Breed+CoreDataProperties.swift
//  
//
//  Created by André N. dos Santos on 17/07/22.
//
//

import Foundation
import CoreData


extension Breed {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Breed> {
        return NSFetchRequest<Breed>(entityName: "Breed")
    }

    @NSManaged public var id: Int16
    @NSManaged public var nome: String?
    @NSManaged public var nivelDeCuidado: String?
    @NSManaged public var imagemURL: String?
    @NSManaged public var caracteristicas: String?
    @NSManaged public var origem: String?
    @NSManaged public var pesoMedio: String?
    @NSManaged public var alturaMedia: String?
    @NSManaged public var estimativaDeVida: String?

}
