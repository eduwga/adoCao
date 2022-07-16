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
    func retornaParaLogin()
}

// MARK: - Definição da Classe
class DetalhesUsuarioViewModel {
    
    var delegate: DetalhesUsuarioViewModelDelegate?
    private let service = Service.shared
    private let fotoPadrao = "customPerson"
    private var usuario: Usuario?
    
    init(usuario: Usuario) {
        self.usuario = usuario
        delegate?.configuraPropriedadesView(usuario: usuario)
    }
    
    init(emailUsuario: String) {
        let usuario = service.getLoggedUser()
        self.usuario = usuario!
        delegate?.configuraPropriedadesView(usuario: usuario!)
    }
    
    init() {
        if let usuario = service.getLoggedUser() {
            self.usuario = usuario
        }
    }
    
    func forcarInicioTela() {
        guard let usuario = usuario else {
            return
        }

        delegate?.configuraPropriedadesView(usuario: usuario)
    }
    
    func obterVMTelaEditarUsuario(_ sender: Any?) -> EditarUsuarioViewModel? {
        if let usr = sender as? Usuario {
            let vmEditarUsuario = EditarUsuarioViewModel(usuario: usr)
            return vmEditarUsuario
        }
        return nil
    }
    
    func getUsuario() -> Usuario? {
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
    
    func deslogarUsuario() {
        guard let usuario = usuario else { return }
        let coreData = CoreDataService()
        if coreData.removeSystemUser(usuario: usuario) {
            service.currentUser = nil
            self.delegate?.retornaParaLogin()
        }
    }
}
