//
//  Service.swift
//  AdoCao
//
//  Created by André N. dos Santos on 11/06/22.
//

import Foundation

class Service {
    private let session = URLSession.shared
    let db = DataBase.shared
    var loggedUser: Usuario?
    var minhaLista = DataBase.shared.minhaLista
    
    let base_url = "https://adocao.azurewebsites.net/api/"
    var currentUser: LoginResult?
    
    static var shared = Service()
    
    private init() {
//        if let currentUserEmail = UserDefaults.standard.string(forKey: "emailDoUsuario") {
//            if let currentUser = getUserBy(email: currentUserEmail) {
//                self.loggedUser = currentUser
//            }
//            else {
//                ///Usuario não encontrado pelo Email / Estamos forçando um só pra testar o uso das outras funções
//                self.loggedUser = DataBase.shared.usuarios[2]
//            }
//        }
//        else { ///email do Usuario não foi gravado nos UserDefaults -> provavelmente não fez login / Estamos forçando um só pra testar o uso das outras funções
//            self.loggedUser = DataBase.shared.usuarios[2]
//        }
    }
    
    private func loginAction(path: String, userLogin: UserLogin, completion: @escaping (Data) -> Void, failure: @escaping (Error) -> Void) {
        guard let serviceUrl = URL(string: base_url + path) else { return }
        
        var request = URLRequest(url: serviceUrl)

        //Se precisar de autenticação por JWT
//        if let token = token {
//            let authString = "Bearer \(token)"
//            request.addValue(authString, forHTTPHeaderField: "Authorization")
//        }
        
        request.httpMethod =  "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        guard let httpBody = try? JSONEncoder().encode(userLogin) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                failure(error)
            }
            
            if let data = data {
                completion(data)
            }
        }.resume()
    }
    
    private func postAction(path: String, bodyParameter: Encodable, completion: @escaping (Data) -> Void, failure: @escaping (Error) -> Void) {
        guard let serviceUrl = URL(string: base_url + path) else { return }
        
        var request = URLRequest(url: serviceUrl)

        guard let currentUser = self.currentUser else { return }
        let authString = "Bearer \(currentUser.token)"
        request.addValue(authString, forHTTPHeaderField: "Authorization")
        
        request.httpMethod =  "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        ///Definir os tipos de objeto dependendo do Path (ex: Post p/ Usuario, p/ Cachorro, /Favoritos...
        if let usuarioParameter = bodyParameter as? UsuarioAPI {
            guard let httpBody = try? JSONEncoder().encode(usuarioParameter) else { return }
            request.httpBody = httpBody
        }
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                failure(error)
            }
            
            if let data = data {
                completion(data)
            }
        }.resume()
    }
    
    func login(email: String,  password: String, completion: @escaping (Usuario) -> Void, failure: @escaping(Error) -> Void) {
        let userLogin: UserLogin = UserLogin(email: email, senha: password)
        loginAction(path: "usuarios/login/", userLogin: userLogin, completion: { data in
            do {
                let loginResult = try JSONDecoder().decode(LoginResult.self, from: data)
                let usuarioResposta = Usuario(usuarioLogado: loginResult.user)
                self.currentUser = loginResult
                completion(usuarioResposta)
            }
            catch {
                print(error)
            }
        }, failure: { error in
            failure(error)
        })
    }

    func loadBreeds(completion: @escaping ([Raca]) -> Void, failure: @escaping (Error) -> Void) {
        let path = "raca/"
        guard let url = URL(string: base_url + path) else { return }
        
        let task = session.dataTask(with: url) { data, _, error in
            guard let data = data else {
                return
            }
            if let error = error {
                failure(error)
            }
            
            let decoder = JSONDecoder()
            
            do {
                let racas = try decoder.decode([Raca].self, from: data)
                completion(racas)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
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

    func getUserBy(id: Int) -> Usuario? {
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
        guard let currentUser = self.currentUser else { return nil }
        return Usuario(usuarioLogado: currentUser.user)
    }

    func create(user: Usuario) -> Bool {
        //TO-DO: - Pensar nas validações
        //Mock pra testar a gravacao
        let endereco = Endereco(logradouro: "Rua Logo Ali", numero: "123", complemento: "", bairro: "Centro", cidade: "Cabrobró", uf: "SP", cep: "01001-000")
        let edu = Tutor(id: 0, nome: "Eduardo", cpf: "123.123.123-99", telefone: "(11) 1234-1234", celular: "(11) 91234-1234", ativo: true, endereco: endereco, amigosDoacao: [])
        let usuarioAPI = UsuarioAPI(id: nil, email: "eduardo@adocao.com.br", senha: "123", imagemURL: "", ativo: true, ultimoAcesso: "", funcao: "Admin", tutor: edu)
        
        postAction(path: "usuarios/", bodyParameter: usuarioAPI) { data in
            print(data)
        } failure: { error in
            print(error)
        }
        
        return true
    }

    func addForAdoption(dog: Amigo) -> Bool {
        //TO-DO: - Pensar nas validações
        db.amigos.append(dog)
        return true
    }
}
