//
//  Usuario.swift
//  AdoCao
//
//  Created by André N. dos Santos on 05/06/22.
//

import Foundation

class Usuario {
    internal init(id: Int, nome: String, email: String, senha: String, cep: String, cidade: String, uf: String, contato: String) {
        self.id = id
        self.nome = nome
        self.email = email
        self.senha = senha
        self.cep = cep
        self.cidade = cidade
        self.uf = uf
        self.contato = contato
     }
    
    internal init(id: Int, nome: String, email: String, senha: String, cep: String, cidade: String, uf: String, contato: String, foto: String) {
        self.id = id
        self.nome = nome
        self.email = email
        self.senha = senha
        self.cep = cep
        self.cidade = cidade
        self.uf = uf
        self.contato = contato
        self.foto = foto
     }
    
    internal init(usuarioResponse: UsuarioResponse) {
        self.id = usuarioResponse.usuarioID
        self.nome = usuarioResponse.nome
        self.senha = "123"
        self.email = usuarioResponse.email
        self.cep = usuarioResponse.cep
        self.cidade = usuarioResponse.cidade
        self.uf = usuarioResponse.uf
        self.contato = usuarioResponse.contato
        self.foto = usuarioResponse.foto
        self.ativo = usuarioResponse.ativo
        
        for favoritoResponse in usuarioResponse.amigosFavoritos {
            let favorito = Amigo(amigoResponse: favoritoResponse)
            self.amigosFavoritos.append(favorito)
        }
        
        for amigoParaDoacaoResponse in usuarioResponse.amigosParaDoacao {
            let amigoParaDoacao = Amigo(amigoResponse: amigoParaDoacaoResponse)
            self.amigosCadastrados.append(amigoParaDoacao)
        }
     }
    
    internal init(usuarioResponse: UsuarioResponse, token: String) {
        self.id = usuarioResponse.usuarioID
        self.nome = usuarioResponse.nome
        self.senha = ""
        self.email = usuarioResponse.email
        self.cep = usuarioResponse.cep
        self.cidade = usuarioResponse.cidade
        self.uf = usuarioResponse.uf
        self.contato = usuarioResponse.contato
        self.foto = usuarioResponse.foto
        self.token = token
        self.ativo = usuarioResponse.ativo
        
        for favoritoResponse in usuarioResponse.amigosFavoritos {
            let favorito = Amigo(amigoResponse: favoritoResponse)
            self.amigosFavoritos.append(favorito)
        }
        
        for amigoParaDoacaoResponse in usuarioResponse.amigosParaDoacao {
            let amigoParaDoacao = Amigo(amigoResponse: amigoParaDoacaoResponse)
            self.amigosCadastrados.append(amigoParaDoacao)
        }
     }
    
    internal init(systemUser: SystemUser) {
        self.id = Int(systemUser.id)
        self.nome = systemUser.nome
        self.email = systemUser.email
        self.senha = ""///Trazer da classe SystemUser do CoreData
        self.cep = systemUser.cep
        self.cidade = systemUser.cidade
        self.uf = systemUser.uf
        self.contato = systemUser.contato
        self.foto = systemUser.foto
        self.token = systemUser.token
        self.refreshToken = systemUser.refreshToken
        self.provider = systemUser.provider
    }
    
    
    internal init(id: Int, nome: String, email: String, senha: String, cep: String, cidade: String, uf: String, contato: String, foto: String, token: String?, refreshToken: String?, provider: String?) {
        self.id = id
        self.nome = nome
        self.email = email
        self.senha = senha
        self.cep = cep
        self.cidade = cidade
        self.uf = uf
        self.contato = contato
        self.foto = foto
        self.token = token
        self.refreshToken = refreshToken
        self.provider = provider
     }
    
    let id: Int
    let nome: String
    let senha: String
    let email: String
    var cep: String
    var cidade: String
    var uf: String
    var contato: String
    var foto: String?
    var token: String?
    var ativo: Bool = false
    var refreshToken: String?
    var provider: String?
    
    var amigosFavoritos: [Amigo] = []
    var amigosCadastrados: [Amigo] = []
    
    func setFoto(caminhoFoto: String) {
        self.foto = caminhoFoto
    }
    
    // MARK: - Getters de Usuario
        func getNome() -> String {
            return self.nome
        }
        
        func getEmail() -> String {
            return self.email
        }
        
        func getCidade() -> String {
            return self.cidade
        }
        
        func getUF() -> String {
            return self.uf
        }
        
        func getContato() -> String {
            return self.contato
        }
        
        func getCaminhoDaFoto() -> String {
            return self.foto ?? ""
        }
    
    func copiaParaUsuarioAPI() -> UsuariosRequest {
        
        let usuarioRequest = UsuariosRequest(
            usuarioID: id,
            nome: nome,
            senha: senha,
            email: email,
            cep: cep,
            cidade: cidade,
            uf: uf,
            contato: contato,
            foto: foto ?? "")
        
        return usuarioRequest
    }
}
