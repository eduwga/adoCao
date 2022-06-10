//
//  ListarAmigosClient.swift
//  AdoCao
//
//  Created by Eduardo Waked Gomes de Amorim on 31/05/22.
//

import Foundation
import UIKit

class ListarAmigosClient {
    
    var nome: String
    var descricao: String
    var localizacao: String
    var foto: String
    
    init(
        nome: String,
         descricao: String,
         localizacao: String,
         foto: String
    )
    {
        self.nome = nome
        self.descricao = descricao
        self.localizacao = localizacao
        self.foto = foto
    }
    func obterNome() -> String {
        return nome
    }
    func obterLocalizaCao() -> String {
        return localizacao
    }
    func obterDescriCao() -> String {
        return descricao
    }
    
}
