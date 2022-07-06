//
//  Raca.swift
//  AdoCao
//
//  Created by André N. dos Santos on 05/06/22.
//

import Foundation

class Raca: Codable {
    
    init(id: Int, nome: String, nivelDeCuidado: String, foto: String, caracteristicas: String, naturalidade: String, peso: String, altura: String, estimativaDeVida: String) {
        self.id = id
        self.nome = nome
        self.nivelDeCuidado = nivelDeCuidado
        self.imagemURL = foto
        self.caracteristicas = caracteristicas
        self.origem = naturalidade
        self.pesoMedio = peso
        self.alturaMedia = altura
        self.estimativaDeVida = estimativaDeVida
    }
    
    init(nome: String, nivelDeCuidado: String, foto: String, caracteristicas: String, naturalidade: String, peso: String, altura: String, estimativaDeVida: String) {
        self.id = 0
        self.nome = nome
        self.nivelDeCuidado = nivelDeCuidado
        self.imagemURL = foto
        self.caracteristicas = caracteristicas
        self.origem = naturalidade
        self.pesoMedio = peso
        self.alturaMedia = altura
        self.estimativaDeVida = estimativaDeVida
    }
    
    init(nome: String, foto: String) {
        self.id = 0
        self.nome = nome
        self.imagemURL = foto
        self.caracteristicas = ""
        self.origem = ""
        self.pesoMedio = ""
        self.alturaMedia = ""
        self.estimativaDeVida = ""
        self.nivelDeCuidado = ""
    }
    
    let id: Int
    let nome: String
    let nivelDeCuidado: String
    let imagemURL: String
    let caracteristicas: String
    let origem: String
    let pesoMedio: String
    let alturaMedia: String
    let estimativaDeVida: String
   
}
