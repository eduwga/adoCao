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
        
    let service = Service()
   
    var usuarioAtual: Usuario
    
    let cao: Amigo?
    
    
    
    var delegate: ListarAmigosCustomCellViewModelDelegate?

    init(cao: Amigo?) {
        self.usuarioAtual = service.getLoggedUser()!
        self.cao = cao

    }
    let service = Service()
    
    func getNome() -> String {
        return self.cao?.nome ?? ""
    }
    
    func getFoto() -> String {
        return self.cao?.foto ?? ""
    }
    
    func getDescricao() -> String {
        return self.cao?.descricao ?? ""
    }
    
    func getLocalizacao() -> String {
        return self.cao?.localizacao ?? ""
    }
        
    
    func verificaSeAmigoEFavorito() -> Bool {

            return usuarioAtual.amigosFavoritos.contains(where: { amigo in
                amigo.nome == self.cao?.nome
            })
        }
    func removeFavoritos() {
        usuarioAtual.amigosFavoritos.removeAll { amigo in
            amigo.nome == cao?.nome
        }
    }
    func adicionaFavoritos() {
        usuarioAtual.amigosFavoritos.append(cao!)
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

