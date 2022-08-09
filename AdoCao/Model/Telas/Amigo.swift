//
//  Amigos.swift
//  AdoCao
//
//  Created by André N. dos Santos on 05/06/22.
//

import Foundation


enum Porte: Int {
    case mini = 1///Até 5 kgs
    case pequeno = 2 ///5 ~ 10 Kgs
    case medio = 3/// 10 ~ 25kgs
    case grande = 4///25 ~ 40Kgs
    case gigante = 5///+ de 40Kgs
}

enum TipoListagem: Int {
    case Adocao = 0
    case Doacao = 1
}

class Amigo {
    internal init(id: Int, nome: String, idade: Int, raca: String, tutor: Usuario, porte: Porte, foto: String, localizacao: String, descricao: String, latitude: Double, longitude: Double, isFavorite: Bool) {
        self.id = id
        self.nome = nome
        self.idade = idade
        self.raca = raca
        self.tutor = tutor
        self.porte = porte
        self.foto = foto
        self.localizacao = localizacao
        self.descricao = descricao
        self.latitude = latitude
        self.longitude = longitude
        self.isFavorite = isFavorite
    }
    
  
    internal init(amigoResponse: AmigoParaAdocaoResponse) {
        self.id = amigoResponse.id
        self.nome = amigoResponse.nome
        self.idade = amigoResponse.idade
        self.raca = ""
        self.tutor = Usuario(
            id: amigoResponse.tutorID,
            nome: amigoResponse.tutorNome,
            email: "",
            senha: "",
            cep: "",
            cidade: "",
            uf: "",
            contato: ""
        )
        self.porte = Porte(rawValue: amigoResponse.tamanho)!
        self.foto = amigoResponse.imagemURL
        self.localizacao = amigoResponse.tutorEndereco
        self.latitude = amigoResponse.latitude
        self.longitude = amigoResponse.longitude
        self.descricao = amigoResponse.descricao
        self.isFavorite = amigoResponse.isFavorite
    }
    
    let id: Int
    let nome: String
    var idade: Int
    var raca: String
    var tutor: Usuario
    var porte: Porte
    var foto: String
    var localizacao: String
    var descricao: String
    let latitude: Double
    let longitude: Double
    let isFavorite: Bool
}
