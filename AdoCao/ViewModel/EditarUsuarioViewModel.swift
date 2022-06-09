//
//  EditarUsuarioViewModel.swift
//  AdoCao
//
//  Created by André N. dos Santos on 08/06/22.
//

import Foundation

protocol EditarUsuarioViewModelDelegate {
    
    func configuraTelaCom(usuario: Usuario)
}

class EditarUsuarioViewModel {
    
    var usuario: Usuario
    var delegate: EditarUsuarioViewModelDelegate?
    
    init(usuario: Usuario) {
        self.usuario = usuario
        delegate?.configuraTelaCom(usuario: usuario)
    }
    
    func forcarInicioTela() {
        delegate?.configuraTelaCom(usuario: usuario)
    }
    
}
