//
//  DetalhesUsuarioViewModel.swift
//  AdoCao
//
//  Created by André N. dos Santos on 05/06/22.
//

import Foundation

// MARK: - Protocolo do Delegate
protocol DetalhesUsuarioViewModelDelegate {
    func configuraPropriedadesView(usuario: Usuario)
}

// MARK: - Definição da Classe
class DetalhesUsuarioViewModel {
    
    
    
    var delegate: DetalhesUsuarioViewModelDelegate?
    
    let usuario: Usuario
    
    init(usuario: Usuario) {
        self.usuario = usuario
        delegate?.configuraPropriedadesView(usuario: usuario)
    }
    
    func teste() {
        delegate?.configuraPropriedadesView(usuario: usuario)
    }
}
