//
//  Service.swift
//  AdoCao
//
//  Created by André N. dos Santos on 11/06/22.
//

import Foundation
import Alamofire

protocol ServiceDelegate {
    
    func returnAPIMessage(message: String)
}

class Service {
    
    
    let coreData = CoreDataService();
    var delegate: ServiceDelegate?
    
    private let session = URLSession.shared
    
    let base_url = "https://adocao.azurewebsites.net/api/"
    //let base_url = "https://localhost:5001/api/"
    
    var currentUser: Usuario?
    var token: String?
    
    static var shared = Service()
    
    private init() {
        guard let systemUser = coreData.pegaSystemUser() else { return }
        self.currentUser = Usuario(systemUser: systemUser)
    }
    
    
    private func loginAction(path: String, userLogin: LoginRequest, completion: @escaping (Data) -> Void, failure: @escaping (Error) -> Void) {
        guard let serviceUrl = URL(string: base_url + path) else { return }
        
        var request = URLRequest(url: serviceUrl)
        
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

        guard let token = token else { return }
        let authString = "Bearer \(token)"

        ///Definir os tipos de objeto dependendo do Path (ex: Post p/ Usuario, p/ Cachorro, /Favoritos...
        guard let usuarioParameter = bodyParameter as? UsuariosRequest else { return }
        guard let httpBody = try? JSONEncoder().encode(usuarioParameter) else { return }
        
        request.httpMethod =  "POST"
        request.addValue(authString, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
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
    
    
    private func postImage(path: String, bodyParameter: Encodable, completion: @escaping (Data) -> Void, failure: @escaping (Error) -> Void) {
        guard let serviceUrl = URL(string: base_url + path) else { return }
        
        var request = URLRequest(url: serviceUrl)

        guard let token = token else { return }
        let authString = "Bearer \(token)"
        
        
//        let parameter = createParameterDictionary()
//        if let parameter = parameter {
//            AF.upload(multipartFormData: { multipartFormData in
//                for (key, value) in parameter {
//                    multipartFormData.append(value, withName: key)
//                    multipartFormData.append(image!.jpegData(compressionQuality: 0.5)!, withName: "upload_data" , fileName: "file.jpeg", mimeType: "image/jpeg")
//                }
//            }, to: serviceUrl, method: .post , headers: .none).response { resp in
//                print(resp)
//            }
//        }
        
        request.addValue(authString, forHTTPHeaderField: "Authorization")
        
        request.httpMethod =  "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        ///Definir os tipos de objeto dependendo do Path (ex: Post p/ Usuario, p/ Cachorro, /Favoritos...
        if let usuarioParameter = bodyParameter as? UsuariosRequest {
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
        
        let userLogin: LoginRequest = LoginRequest(email: email, senha: password)
        loginAction(path: "usuarios/login/", userLogin: userLogin, completion: { data in
            
            if let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) {
                
                let usuarioResposta = Usuario(usuarioResponse: loginResponse.user)
                self.currentUser = usuarioResposta	
                self.token = loginResponse.token
                
                self.currentUser = usuarioResposta
                completion(usuarioResposta)
            }
            else {
                let loginResult = try? JSONDecoder().decode(FailureResponse.self, from: data)
                if let loginResult = loginResult {
                    DispatchQueue.main.async {
                        self.delegate?.returnAPIMessage(message: loginResult.message)
                    }                    
                }
            }

        }, failure: { error in
            self.delegate?.returnAPIMessage(message: error.localizedDescription)
        })
    }

    func loadBreeds(completion: @escaping ([Raca]) -> Void, failure: @escaping (Error) -> Void) {
        let path = "raca/"
        guard let url = URL(string: base_url + path) else { return }
        
        guard let token = token else { return }
        let authString = "Bearer \(token)"
        
        var request = URLRequest(url: url)
        request.addValue(authString, forHTTPHeaderField: "Authorization")
        
        request.httpMethod =  "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        let task = session.dataTask(with: request) { data, _, error in
            guard let data = data else {
                return
            }
            if let error = error {
                failure(error)
            }
            
            let decoder = JSONDecoder()
            
            do {
                let racas = try decoder.decode([Raca].self, from: data)
                DispatchQueue.main.async {
                    completion(racas)
                }                
            } catch {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
    
    func getDogsForAdoption(completion: @escaping ([Amigo]) -> Void) {

        guard let token = token else { return }
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        
        AF.request(base_url+"cachorros/", headers: headers).responseDecodable(of: AmigosParaAdocaoResponse.self) { response in
        let resultadoDaRequisicao = response.result
            
            switch resultadoDaRequisicao {
                case .success(let cachorros):
                    var amigos: [Amigo] = []
                    for cachorro in cachorros {
                        amigos.append(Amigo(amigoResponse: cachorro))
                    }
                    completion(amigos)
                case .failure(_):
                    break
            }
        }
    }

    func getDogBy(id: Int, completion: @escaping (Amigo) -> Void) {
        guard let token = token else { return }
        let endpoint = "cachorros/\(id)/"
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        
        AF.request(base_url+endpoint, headers: headers).responseDecodable(of: AmigoParaAdocaoResponse.self) { response in
            let resultadoDaRequisicao = response.result
            
            switch resultadoDaRequisicao {
                case .success(let cachorro):
                let amigo: Amigo = Amigo(amigoResponse: cachorro)
                    completion(amigo)
                case .failure(_):
                    break
            }
        }
    }

    func getBreedBy(id: Int, completion: @escaping (Raca) -> Void) {
        guard let token = token else { return }
        
        let endpoint = "raca/\(id)/"
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        
        AF.request(base_url+endpoint, headers: headers).responseDecodable(of: Raca.self) { response in
            let resultadoDaRequisicao = response.result
            
            switch resultadoDaRequisicao {
                case .success(let raca):
                    completion(raca)
                case .failure(_):
                    break
            }
        }
    }

    func getDogsBy(name: String) -> [Amigo] {
//        let dogs = db.amigos.filter({ amigo in
//            amigo.nome == name
//        })
//        return dogs
        return []
    }

    func getUserBy(id: Int, completion: @escaping (Usuario) -> Void){
        guard let token = token else { return }
        
        let endpoint = "usuarios/\(id)/"
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        
        AF.request(base_url+endpoint, headers: headers).responseDecodable(of: UsuarioResponse.self) { response in
            let resultadoDaRequisicao = response.result
            
            switch resultadoDaRequisicao {
                case .success(let usuarioResponse):
                let usuario = Usuario(usuarioResponse: usuarioResponse)
                    completion(usuario)
                case .failure(_):
                    break
            }
        }
    }

    func getLoggedUser() -> Usuario? {
        guard let currentUser = self.currentUser else { return nil }
        return currentUser
    }

    func create(user: Usuario) -> Bool {
        //TO-DO: - Pensar nas validações
        let usuarioDTO = user.copiaParaUsuarioAPI()
        
        postAction(path: "usuarios/", bodyParameter: usuarioDTO) { data in
            print(data)
        } failure: { error in
            print(error)
        }
        
        return true
    }

    func addForAdoption(dog: Amigo) -> Bool {
        //TO-DO: - Pensar nas validações
        _ = AmigoParaAdocaoRequest(
            nome: dog.nome,
            idade: dog.idade,
            tamanho: dog.porte.rawValue,
            imagem: "",
            descricao: dog.descricao,
            caracteristicas: "",
            nomeRaca: dog.raca,
            latitude: 0,
            longitude: 0,
            tutorID: dog.tutor.id,
            racaID: 0
        )
//        db.amigos.append(dog)
        return true
    }
    
    func addToFavorite(dog: Amigo, completion: @escaping (Bool) -> Void) {
        //TO-DO: - Pensar nas validações
        guard let currentUser = currentUser else { return }

        let amigoFavorito = FavoritoRequest(cachorroID: dog.id, usuarioID: currentUser.id)
        
        guard let token = token else { return }
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        
        AF.request(base_url+"favoritos/", method: .post, parameters: amigoFavorito, encoder: JSONParameterEncoder.default, headers: headers).responseDecodable(of: AmigosParaAdocaoResponse.self) { response in
        let resultadoDaRequisicao = response.result
            
            switch resultadoDaRequisicao {
                case .success(let cachorros):
                    var amigos: [Amigo] = []
                    for cachorro in cachorros {
                        amigos.append(Amigo(amigoResponse: cachorro))
                    }
                    completion(true)
                case .failure(let error):
                    print(error)
                    break
            }
        }
    }
    
    func getUserFavorites(completion: @escaping ([Amigo]) -> Void) {
        guard let currentUser = currentUser else { return }

        guard let token = token else { return }
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        
        AF.request(base_url+"favoritos/usuario/\(currentUser.id)", headers: headers).responseDecodable(of: AmigosParaAdocaoResponse.self) { response in
            let resultadoDaRequisicao = response.result
            
            switch resultadoDaRequisicao {
                case .success(let favoritos):
                    var amigos: [Amigo] = []
                    for favorito in favoritos {
                        amigos.append(Amigo(amigoResponse: favorito))
                    }
                    completion(amigos)
                case .failure(_):
                    break
            }
        }
    }
}
