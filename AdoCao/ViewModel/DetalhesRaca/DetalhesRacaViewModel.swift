//
//  DetalhesRacaViewModel.swift
//  AdoCao
//
//  Created by André N. dos Santos on 07/06/22.
//

import Foundation

class DetalhesRacaViewModel {
    
    private var raca: Raca
    private let fotoPadrao: String = "iconDog"
    
    init(raca: Raca) {
        self.raca = raca
    }
    
    func getRaca() -> Raca {
        return raca
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
