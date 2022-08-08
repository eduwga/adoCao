//
//  FavoritosViewModel.swift
//  AdoCao
//
//  Created by André N. dos Santos on 11/06/22.
//

import Foundation

protocol FavoritosViewModelDelegate {
    func recarregarTela()
}

class FavoritosViewModel {
    
    var delegate: FavoritosViewModelDelegate?
    let service = Service.shared
    var usuarioLogado: Usuario?
    
    init() {
        if let usuario = service.getLoggedUser() {
            self.usuarioLogado = usuario
        }
    }
    
    func obterQuantidadeDeFavoritos() -> Int {
        if let usuarioLogado = usuarioLogado {
            return usuarioLogado.amigosFavoritos.count
        }
        else {
            if let usuario = service.getLoggedUser() {
                self.usuarioLogado = usuario
                return usuario.amigosFavoritos.count
            }
        }
        return  0
    }
    
    func obterAmigoFavorito(posicao: Int) -> Amigo? {
        if let usuarioLogado = usuarioLogado {
            return usuarioLogado.amigosFavoritos[posicao]
        }
        else {
            if let usuario = service.getLoggedUser() {
                self.usuarioLogado = usuario
                return usuario.amigosFavoritos[posicao]
            }
        }
        return nil
    }
    
    func obterViewModelParaCell(posicao: Int) -> FavoritoCellViewModel? {
        guard let amigoFavorito = obterAmigoFavorito(posicao: posicao) else { return nil }
        let vmCell = FavoritoCellViewModel(amigoFavorito: amigoFavorito)
        return vmCell
    }
    func obterViewModelParaTelaDetalhe(posicao: Int) -> DetalheAmigoViewModel {
        ///TO-DO: Avaliar se existe caso em que isso possa ser nulo
        let amigoFavorito = obterAmigoFavorito(posicao: posicao)!
        let vmDetalhe = DetalheAmigoViewModel(amigo: amigoFavorito)
        return vmDetalhe
    }
}