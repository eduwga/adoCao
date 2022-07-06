//
//  LoginViewModel.swift
//  AdoCao
//
//  Created by André N. dos Santos on 26/06/22.
//

import Foundation

protocol LoginViewModelDelegate {
    func loginComSucesso(_ usuario: Usuario)
    func exibeMensagemAlert(mensagem: String)
    func temUsuarioLogado()
}

class LoginViewModel {
    var delegate: LoginViewModelDelegate?
    private let service = Service.shared
    private let coreDataService: CoreDataService = .init()
    private var systemUser: SystemUser?
    
    init() {
        service.delegate = self
    }
    
    func verificaSeTemUsuarioLogado() {
        systemUser = coreDataService.pegaSystemUser()
        guard let systemUser = systemUser else { return }
        
        login(email: systemUser.email, senha: systemUser.senha)
        //delegate?.temUsuarioLogado()
    }
    
    func validaEmail(email: String?) -> Bool {
        if let email = email {
            if(email != "") {
                return true
            }
        }
        delegate?.exibeMensagemAlert(mensagem: "O campo e-mail é obrigatório!")
        return false
    }
    
    func validaSenha(senha: String?) -> Bool {
        if let senha = senha {
            if(senha != "") {
                return true
            }
        }
        delegate?.exibeMensagemAlert(mensagem: "O campo senha é obrigatório!")
        return false
    }
    
    func login(email: String?, senha: String?) {
        guard let email = email,
              let senha = senha
        else { return }
        
        service.login(email: email, password: senha, completion: { usuarioLogado in
            DispatchQueue.main.async {
                self.salvaUsuario(usuarioLogado: usuarioLogado)
                self.delegate?.loginComSucesso(usuarioLogado)
            }
        }) { error in
            self.delegate?.exibeMensagemAlert(mensagem: "Falha no login: \(error.localizedDescription)")
        }
    }
    
    private func salvaUsuario (usuarioLogado: Usuario) {
        coreDataService.salvaUserAsSystemUser(usuario: usuarioLogado)
    }
}

extension LoginViewModel: ServiceDelegate {
    func returnAPIMessage(message: String) {
        self.delegate?.exibeMensagemAlert(mensagem: message)
    }
}
