//
//  Usuario.swift
//  AdoCao
//
//  Created by André N. dos Santos on 05/06/22.
//

import Foundation

class Usuario {
    internal init(nome: String, email: String, cep: String, cidade: String, uf: String, contato: String) {
        self.id = UUID.init()
        self.nome = nome
        self.email = email
        self.cep = cep
        self.cidade = cidade
        self.uf = uf
        self.contato = contato
     }
    
    internal init(nome: String, email: String, cep: String, cidade: String, uf: String, contato: String, foto: String) {
        self.id = UUID.init()
        self.nome = nome
        self.email = email
        self.cep = cep
        self.cidade = cidade
        self.uf = uf
        self.contato = contato
        self.foto = foto
     }
    
    let id: UUID
    let nome: String
    let email: String
    var cep: String
    var cidade: String
    var uf: String
    var contato: String
    var foto: String?
    
    var amigosFavoritos: [Amigo] = []
    var amigosCadastrados: [Amigo] = []
    
    func setFoto(caminhoFoto: String) {
        self.foto = caminhoFoto
    }
    
    // MARK: - Getters de Usuario
        func getNome() -> String {
            return "Nome: \(self.nome)"
        }
        
        func getEmail() -> String {
            return "E-mail: \(self.email)"
        }
        
        func getCidade() -> String {
            return "Cidade: \(self.cidade)"
        }
        
        func getUF() -> String {
            return "UF: \(self.uf)"
        }
        
        func getContato() -> String {
            return "Contato: \(self.contato)"
        }
        
        func getCaminhoDaFoto() -> String {
            return self.foto ?? ""
        }
}
