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
        delegate?.configura(amigo: amigo)
    }
    
    func telaInicial() {
        delegate?.configura(amigo: amigo)
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
