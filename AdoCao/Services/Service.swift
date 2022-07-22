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

        if let usuarioParameter = bodyParameter as? UsuariosRequest {
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
    }

    func postImage(id: Int, base64Image: String, endpoint: String, completion: @escaping (String?) -> Void, failure: @escaping (Error) -> Void) {
        
        let endpoint = "\(endpoint)/\(id)/image/"
        
        guard let serviceUrl = URL(string: base_url + endpoint) else { return }
        guard let token = token else { return }
        
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        
        AF.request(
            serviceUrl,
            method: .post,
            parameters: base64Image,
            encoder: JSONParameterEncoder.default,
            headers: headers
        ).responseDecodable(of: EnvioImagemResponse.self) { response in
            let resultadoDaRequisicao = response.result
            
            switch resultadoDaRequisicao {
                case .success(let imagemResponse):
                completion(imagemResponse.imagemURL)
                case .failure(let error):
                    print(error.localizedDescription)
                    break
            }
        }
    }
    
//    func postDogImage(dogId: Int, base64Image: String, completion: @escaping (String?) -> Void, failure: @escaping (Error) -> Void) {
//
//        let endpoint = "cachorros/\(dogId)/image/"
//
//        guard let serviceUrl = URL(string: base_url + endpoint) else { return }
//        guard let token = token else { return }
//
//        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
//
//        AF.request(
//            serviceUrl,
//            method: .post,
//            parameters: base64Image,
//            encoder: JSONParameterEncoder.default,
//            headers: headers
//        ).responseDecodable(of: EnvioImagemResponse.self) { response in
//            let resultadoDaRequisicao = response.result
//
//            switch resultadoDaRequisicao {
//                case .success(let imagemResponse):
//                completion(imagemResponse.imagemURL)
//                case .failure(let error):
//                    print(error.localizedDescription)
//                    break
//            }
//        }
//    }
    
    func login(email: String,  password: String, completion: @escaping (Usuario) -> Void, failure: @escaping (Error) -> Void) {
        
        let userLogin: LoginRequest = LoginRequest(email: email, senha: password)
        loginAction(path: "usuarios/login/", userLogin: userLogin, completion: { data in
            
            if let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) {
                
                let usuarioResposta = Usuario(usuarioResponse: loginResponse.user, token: loginResponse.token)
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
    
    func getAlreadyLoggedUserBy(Id id: Int, token: String, completion: @escaping (Bool) -> Void, failure: @escaping (Error) -> Void){
        self.token = token
        
        let endpoint = "usuarios/\(id)/"
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        
        AF.request(base_url+endpoint, headers: headers).responseDecodable(of: UsuarioResponse.self) { response in
            let resultadoDaRequisicao = response.result
            
            switch resultadoDaRequisicao {
                case .success(let usuarioResponse):
                    let usuario = Usuario(usuarioResponse: usuarioResponse)
                    self.currentUser = usuario
                    completion(usuario.ativo)
                case .failure(let error):
                    failure(error)
            }
        }
    }    

    func getLoggedUser() -> Usuario? {
        guard let currentUser = self.currentUser else { return nil }
        return currentUser
    }

    func create(user: Usuario, completion: @escaping (Usuario) -> Void) {
        let usuarioRequest = user.copiaParaUsuarioAPI()

        guard let token = token else { return }
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        
        AF.request(base_url+"usuarios/", method: .post, parameters: usuarioRequest, encoder: JSONParameterEncoder.default, headers: headers).responseDecodable(of: UsuarioResponse.self) { response in
        let resultadoDaRequisicao = response.result
            
            switch resultadoDaRequisicao {
                case .success(let usuarioResponse):
                    let novoUsuario: Usuario = Usuario(usuarioResponse: usuarioResponse)
                    completion(novoUsuario)
                case .failure(let error):
                    print(error.localizedDescription)
                    break
            }
        }
    }

    func addForAdoption(dog: Amigo, completion: @escaping (Bool) -> Void)  {
        guard let currentUser = currentUser else { return }

        let amigoParaAdocao = AmigoParaAdocaoRequest(amigo: dog)
        
        guard let token = token else { return }
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        
        AF.request(base_url+"cachorros/", method: .post, parameters: amigoParaAdocao, encoder: JSONParameterEncoder.default, headers: headers).responseDecodable(of: AmigoParaAdocaoResponse.self) { response in
        let resultadoDaRequisicao = response.result
            
            switch resultadoDaRequisicao {
                case .success(let cachorro):
                    let amigoDoacao: Amigo = Amigo(amigoResponse: cachorro)
                    currentUser.amigosCadastrados.append(amigoDoacao)
                    completion(true)
                case .failure(let error):
                    print(error.localizedDescription)
                    break
            }
        }
    }
    
    func addToFavorite(dog: Amigo, completion: @escaping (Bool) -> Void) {
        guard let currentUser = currentUser else { return }

        let amigoFavorito = FavoritoRequest(cachorroID: dog.id, usuarioID: currentUser.id)
        
        guard let token = token else { return }
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        
        AF.request(base_url+"favoritos/", method: .post, parameters: amigoFavorito, encoder: JSONParameterEncoder.default, headers: headers).responseDecodable(of: AmigoParaAdocaoResponse.self) { response in
        let resultadoDaRequisicao = response.result
            
            switch resultadoDaRequisicao {
                case .success(let cachorro):
                    let novoAmigoFavorito: Amigo = Amigo(amigoResponse: cachorro)
                    currentUser.amigosFavoritos.append(novoAmigoFavorito)
                    completion(true)
                case .failure(let error):
                    print(error.localizedDescription)
                    break
            }
        }
    }
    
    func removeFromFavorites(dog: Amigo, completion: @escaping (Bool) -> Void) {
        guard let currentUser = currentUser else { return }

        let endpoint = "\(base_url)favoritos/\(dog.id)/usuario/\(currentUser.id)"
        
        guard let token = token else { return }
        
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        AF.request(endpoint, method: .delete, parameters: "", encoder: JSONParameterEncoder.default, headers: headers).responseDecodable(of: AmigosParaAdocaoResponse.self) { response in
            
//        AF.request(endpoint, method: .delete, parameters: .none, encoder: JSONParameterEncoder.default, headers: headers).responseDecodable(of: AmigosParaAdocaoResponse.self) { response in

            let resultadoDaRequisicao = response.result
            
            switch resultadoDaRequisicao {
                case .success(let favoritos):
                    var amigos: [Amigo] = []
                    for favorito in favoritos {
                        amigos.append(Amigo(amigoResponse: favorito))
                    }
                    currentUser.amigosFavoritos = amigos
                    completion(true)
                case .failure(let error):
                    print(error.localizedDescription)
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
                case .failure(let error):
                print(error.localizedDescription)
                    break
            }
        }
    }
}
