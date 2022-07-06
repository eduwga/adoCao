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
    let fotoPadrao = "customPerson"
    init(usuario: Usuario) {
        self.usuario = usuario
    }
    
    func configurarTela() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.delegate?.configuraTelaCom(usuario: self.usuario)
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
