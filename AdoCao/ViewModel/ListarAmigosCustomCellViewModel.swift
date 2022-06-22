//
//  ListarAmigosCustomCellViewModel.swift
//  AdoCao
//
//  Created by Eduardo Waked Gomes de Amorim on 31/05/22.
//

import Foundation

protocol ListarAmigosCustomCellViewModelDelegate {
    
    
}


class ListarAmigosCustomCellViewModel {
    
    var delegate: ListarAmigosCustomCellViewModelDelegate?
    let service = Service()
    
    func preparaCaoCell() {
        
    }
    
    func verificaSeAmigoEFavorito(amigoSelecionado: Amigo) -> Bool {
        let usuarioAtual = service.getLoggedUser()
        
        guard let usuarioAtual = usuarioAtual else {
            return false
        }

        return usuarioAtual.amigosFavoritos.contains(where: { amigo in
            amigo.nome == amigoSelecionado.nome
        })
    }
}

