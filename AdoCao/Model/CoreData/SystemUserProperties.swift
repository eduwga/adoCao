//
//  SystemUserProperties.swift
//  AdoCao
//
//  Created by Marcos Vinicius on 06/07/22.
//

import Foundation
import CoreData

extension SystemUser {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<SystemUser> {
        return NSFetchRequest<SystemUser>(entityName: "SystemUser")
    }
    
    @NSManaged var id: Int16
    @NSManaged var nome: String
    @NSManaged var email: String
    @NSManaged var cep: String
    @NSManaged var cidade: String
    @NSManaged var uf: String
    @NSManaged var contato: String
    @NSManaged var foto: String?
    @NSManaged var senha: String?
    @NSManaged var token: String?
    @NSManaged var refreshToken: String?
    @NSManaged var provider: String?
}

extension SystemUser: Identifiable {}
