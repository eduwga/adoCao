//
//  EditarUsuarioViewModel.swift
//  AdoCao
//
//  Created by André N. dos Santos on 08/06/22.
//

import Foundation

class EditarUsuarioViewModel {
    
    private var usuario: Usuario
    private let fotoPadrao = "customPerson"
    
    init(usuario: Usuario) {
        self.usuario = usuario
    }
    
    func validarFoto(nomeFoto: String?) -> String {
        if let nomeFoto = nomeFoto {
            if nomeFoto != ""{
                return nomeFoto
            }
        }
        return fotoPadrao
    }
    
    func getUsuario() -> Usuario {
        return self.usuario
    }
}
