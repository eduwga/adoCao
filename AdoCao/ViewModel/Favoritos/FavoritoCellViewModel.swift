//
//  FavoritoCellViewModel.swift
//  AdoCao
//
//  Created by André N. dos Santos on 11/06/22.
//

import Foundation
protocol FavoritoCellViewModelDelegate {
    func configuraCellFavorito(amigoFavorito: Amigo)
}

class FavoritoCellViewModel {
    
    var delegate: FavoritoCellViewModelDelegate?
    var amigoFavorito: Amigo
    let fotoPadrao = "iconDog"
    
    init(amigoFavorito: Amigo) {
        self.amigoFavorito = amigoFavorito
    }
   
    func inicializaCell() {
        delegate?.configuraCellFavorito(amigoFavorito: self.amigoFavorito)
    }

    func validarFoto(nomeFoto: String?) -> String {
        if let nomeFoto = nomeFoto {
            if nomeFoto != ""{
                return nomeFoto
            }
        }
        return fotoPadrao
    }
}
