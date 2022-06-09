//
//  DetalheAmigoViewModel.swift
//  AdoCao
//
//  Created by Eduardo Waked Gomes de Amorim on 08/06/22.
//

import Foundation


protocol DetalheAmigoViewModelDelegate {
    
    func configura(tela: ListarAmigosClient)
    
}


class DetalheAmigoViewModel {
    
    var delegate: DetalheAmigoViewModelDelegate?
    
    
    var amigo: ListarAmigosClient
    
    init(amigo: ListarAmigosClient) {
        self.amigo = amigo
        delegate?.configura(tela: amigo)
    }
    
    func telaInicial() {
        delegate?.configura(tela: amigo)

    }
    
}
