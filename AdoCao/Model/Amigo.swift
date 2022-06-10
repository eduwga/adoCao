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

class Amigo {
    internal init(nome: String, idade: Int, raca: String, tutor: Usuario, porte: Porte, foto: String, localizacao: String, descricao: String) {
        self.nome = nome
        self.idade = idade
        self.raca = raca
        self.tutor = tutor
        self.porte = porte
        self.foto = foto
        self.localizacao = localizacao
        self.descricao = descricao
    }
    
    let nome: String
    var idade: Int
    var raca: String
    var tutor: Usuario
    var porte: Porte
    var foto: String
    var localizacao: String
    var descricao: String
}
