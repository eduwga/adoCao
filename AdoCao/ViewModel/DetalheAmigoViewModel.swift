//
//  DetalheAmigoViewModel.swift
//  AdoCao
//
//  Created by Eduardo Waked Gomes de Amorim on 08/06/22.
//

import Foundation


protocol DetalheAmigoViewModelDelegate {
    func configura(amigo: Amigo)
}


class DetalheAmigoViewModel {
    
    let fotoPadrao = "iconDog"
    var delegate: DetalheAmigoViewModelDelegate?
    var amigo: Amigo
    
    init(amigo: Amigo) {
        self.amigo = amigo
    }
    
    func getNome() -> String {
        return amigo.nome
    }
    
    func getLocalizacao() -> String {
        return amigo.localizacao
    }
    
    func getDescricao() -> String {
        return amigo.descricao
    }
    
    func getFoto() -> String {
        return amigo.foto != "" ? amigo.foto : fotoPadrao
    }
}
