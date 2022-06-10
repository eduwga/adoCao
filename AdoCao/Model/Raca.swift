//
//  Raca.swift
//  AdoCao
//
//  Created by André N. dos Santos on 05/06/22.
//

import Foundation

class Raca {
    
    init(nome: String, outrosNomes: String, foto: String, caracteristicas: String, naturalidade: String, peso: String, altura: String, estimativaDeVida: String) {
        self.nome = nome
        self.outrosNomes = outrosNomes
        self.foto = foto
        self.caracteristicas = caracteristicas
        self.naturalidade = naturalidade
        self.peso = peso
        self.altura = altura
        self.estimativaDeVida = estimativaDeVida
    }
    
    init(nome: String, foto: String) {
        self.nome = nome
        self.foto = foto
        self.caracteristicas = ""
        self.naturalidade = ""
        self.peso = ""
        self.altura = ""
        self.estimativaDeVida = ""
        self.outrosNomes = ""
    }

    let nome: String
    let outrosNomes: String
    let foto: String
    let caracteristicas: String
    let naturalidade: String
    let peso: String
    let altura: String
    let estimativaDeVida: String
}
