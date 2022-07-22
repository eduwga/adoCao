//
//  ListarAmigosCustomCellViewModel.swift
//  AdoCao
//
//  Created by Eduardo Waked Gomes de Amorim on 31/05/22.
//

import Foundation

protocol ListarAmigosCustomCellViewModelDelegate {
    
    func exibeMensagemResposta(sucesso: Bool)
    
    func amigoFoiAdicionado()
    func amigoFoiRemovido()
}


class ListarAmigosCustomCellViewModel {
        
    let service = Service.shared
    let cao: Amigo?
    var usuarioAtual: Usuario?
    var delegate: ListarAmigosCustomCellViewModelDelegate?

    init(cao: Amigo?) {
        self.usuarioAtual = service.getLoggedUser()
        self.cao = cao
        buscaAmigosFavoritos()
    }
    
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
        guard let amigo = cao?.tutor else { return self.cao?.localizacao ?? "" }
        return "\(amigo.cidade) - \(amigo.uf)"
    }
        
    func buscaAmigosFavoritos() {
        service.getUserFavorites { amigos in
            if let usuarioAtual = self.usuarioAtual {
                usuarioAtual.amigosFavoritos = amigos
            }
        }
    }
    func verificaSeAmigoEFavorito() {
        service.getUserFavorites { amigos in
            if let usuarioAtual = self.usuarioAtual {
                usuarioAtual.amigosFavoritos = amigos
            }
            let existe =  amigos.contains(where: { amigo in
                amigo.nome == self.cao?.nome
            })
            if existe {
                self.removeFavoritos()
            }
            else {
                self.adicionaFavoritos()
            }
        }
    }
    
    func removeFavoritos() {
        guard let cao = cao else { return }
        service.removeFromFavorites(dog: cao) { resposta in
            if resposta {
                self.delegate?.amigoFoiRemovido()
            }
            else {
                self.delegate?.amigoFoiAdicionado()
            }
        }
    }
    
    func adicionaFavoritos() {
        guard let cao = cao else { return }
        service.addToFavorite(dog: cao) { resposta in
            if resposta {
                self.delegate?.amigoFoiAdicionado()
            }
            else {
                self.delegate?.amigoFoiRemovido()
            }
        }
    }
}

