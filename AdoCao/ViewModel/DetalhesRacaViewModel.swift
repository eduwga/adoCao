//
//  DetalhesRacaViewModel.swift
//  AdoCao
//
//  Created by André N. dos Santos on 07/06/22.
//

import Foundation

protocol DetalhesRacaViewModelDelegate {
    func exibeDadosIniciais(raca: Raca)
}

class DetalhesRacaViewModel {
    
    var raca: Raca
    var delegate: DetalhesRacaViewModelDelegate?
    let fotoPadrao: String = "iconDog"
    
    init(raca: Raca) {
        self.raca = raca
    }
    
    func configuracaotela() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.delegate?.exibeDadosIniciais(raca: self.raca)
        }
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
