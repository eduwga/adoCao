//
//  DetalheAmigoViewModel.swift
//  AdoCao
//
//  Created by Eduardo Waked Gomes de Amorim on 08/06/22.
//

import Foundation

class DetalheAmigoViewModel {
    
    let fotoPadrao = "iconDog"
    let amigo: Amigo
    let service = Service.shared
    
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
    
    func getCoordenadas() -> [Double] {
        return [amigo.latitude, amigo.longitude]
        
    }
    
    func getEndereco() -> String {
        return "\(amigo.tutor.getCidade()) - \(amigo.tutor.getUF())"
    }
}
