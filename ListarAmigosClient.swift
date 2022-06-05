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
    var foto: UIImage?
    
    init(
        nome: String,
         descricao: String,
         localizacao: String,
         foto: UIImage?
    )
    {
        self.nome = nome
        self.descricao = descricao
        self.localizacao = localizacao
        self.foto = foto
    }
    
}
