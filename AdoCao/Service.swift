//
//  Service.swift
//  AdoCao
//
//  Created by André N. dos Santos on 11/06/22.
//

import Foundation

class Service {
    let db = DataBase.shared
    var loggedUser: Usuario?
    var minhaLista = DataBase.shared.minhaLista

    init() {
        if let currentUserEmail = UserDefaults.standard.string(forKey: "emailDoUsuario") {
            if let currentUser = getUserBy(email: currentUserEmail) {
                self.loggedUser = currentUser
            }
            else {
                ///Usuario não encontrado pelo Email / Estamos forçando um só pra testar o uso das outras funções
                self.loggedUser = DataBase.shared.usuarios[2]
            }
        }
        else { ///email do Usuario não foi gravado nos UserDefaults -> provavelmente não fez login / Estamos forçando um só pra testar o uso das outras funções
            self.loggedUser = DataBase.shared.usuarios[2]
        }
    }
    
    func login(email: String,  password: String) -> Bool {
        guard let user = getUserBy(email: email) else { return false }
        if user.senha == password {
            self.loggedUser = user
            return true
        }
        return false
    }
    
    func getBreeds() -> [Raca] {
        return db.racas
    }

    func getDogsForAdoption() -> [Amigo] {
        return db.amigos
    }

    func getDogBy(id: UUID) -> Amigo? {
        let dog = db.amigos.first { amigo in
            amigo.id == id
        }
        return dog
    }

    func getBreedBy(name: String) -> Raca? {
        let breed = db.racas.first { raca in
            raca.nome == name
        }
        return breed
    }

    func getDogsBy(name: String) -> [Amigo] {
        let dogs = db.amigos.filter({ amigo in
            amigo.nome == name
        })
        return dogs
    }

    func getUserBy(id: UUID) -> Usuario? {
        let user = db.usuarios.first { usuario in
            usuario.id == id
        }
        return user
    }
    
    func getUserBy(email: String) -> Usuario? {
        let user = db.usuarios.first { usuario in
            usuario.email == email
        }
        return user
    }

    func getLoggedUser() -> Usuario? {
        return loggedUser
    }

    func create(user: Usuario) -> Bool {
        //TO-DO: - Pensar nas validações
        db.usuarios.append(user)
        return true
    }

    func addForAdoption(dog: Amigo) -> Bool {
        //TO-DO: - Pensar nas validações
        db.amigos.append(dog)
        return true
    }
}
