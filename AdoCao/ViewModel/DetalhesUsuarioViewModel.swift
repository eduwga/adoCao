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
    private let fotoPadrao = "customPerson"
    private let usuario: Usuario
    
    init(usuario: Usuario) {
        self.usuario = usuario
        delegate?.configuraPropriedadesView(usuario: usuario)
    }
    
    func forcarInicioTela() {
        delegate?.configuraPropriedadesView(usuario: usuario)
    }
    
    func obterVMTelaEditarUsuario(_ sender: Any?) -> EditarUsuarioViewModel? {
        if let usr = sender as? Usuario {
            let vmEditarUsuario = EditarUsuarioViewModel(usuario: usr)
            return vmEditarUsuario
        }
        return nil
    }
    
    func getUsuario() -> Usuario {
        return usuario
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
