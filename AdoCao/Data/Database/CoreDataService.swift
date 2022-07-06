//
//  CoreDataService.swift
//  AdoCao
//
//  Created by Marcos Vinicius on 05/07/22.
//

import Foundation
import UIKit

class CoreDataService {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func salvaUserAsSystemUser(usuario: Usuario) {
        print("Salvando usuário: \(usuario)")
        
        let systemUser: SystemUser = .init(context: context)
        systemUser.id = Int16(usuario.id)
        systemUser.nome = usuario.nome
        systemUser.email = usuario.email
        systemUser.cep = usuario.cep
        systemUser.cidade = usuario.cidade
        systemUser.uf = usuario.uf
        systemUser.contato = usuario.contato
        systemUser.foto = usuario.foto
        
        salvarContexto()
    }
    
    private func pegaSystemUser() -> [SystemUser] {
        do {
            return try context.fetch(SystemUser.fetchRequest())
        } catch {
            print(error)
        }
        
        return []
    }
    
    private func salvarContexto() {
        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        appDelegate.saveContext()
    }
}
