//
//  CoreDataService.swift
//  AdoCao
//
//  Created by Marcos Vinicius on 05/07/22.
//

import Foundation
import UIKit
import CoreData

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
        systemUser.senha =  usuario.senha
        systemUser.token =  usuario.token
        
        salvarContexto()
    }
    
    func removeSystemUser(usuario: Usuario) -> Bool {
        do {
            let loggedUsers = try context.fetch(SystemUser.fetchRequest())

            if let object = loggedUsers.first(where: { systemUser in
                systemUser.id == usuario.id
            }) {
                context.delete(object)
                salvarContexto()
            }
        } catch {
            print(error)
        }
        return true
    }
    
    func pegaSystemUser() -> SystemUser? {
        do {
            let users = try context.fetch(SystemUser.fetchRequest())
            if !users.isEmpty {
                return users.last
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    private func salvarContexto() {
        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        appDelegate.saveContext()
    }
}
