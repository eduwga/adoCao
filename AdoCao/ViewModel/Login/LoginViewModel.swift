//
//  LoginViewModel.swift
//  AdoCao
//
//  Created by André N. dos Santos on 26/06/22.
//

import Foundation
import FirebaseAuth
import GoogleSignIn
import FacebookLogin

protocol LoginViewModelDelegate {
    func loginComSucesso(_ usuario: Usuario)
    func exibeMensagemAlert(mensagem: String)
    func temUsuarioLogado()
    func loginGoogle(configuration: GIDConfiguration)
}

class LoginViewModel {
    private let loginService: LoginService = .init()
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
    
    // MARK: - Login com provedores externos (Firebase: Google/Facebook)
    func efetuarLoginGoogle() {
        guard let configuration = loginService.pegarConfiguracaoGoogle() else { return }
        
        delegate?.loginGoogle(configuration: configuration)
    }
    
    func tratarLoginGoogle(user: GIDGoogleUser?, error: Error?) {
        // tratativa de erro
        if let error = error {
            print(error)
            return
        }
        
        // login do google deu certo
        salvarDadosNoFirebase(user: user)
        
        // User is signed in
       
        // fazer alguma coisa - delegate
    }
    
    func tratarLoginFacebook(result: LoginManagerLoginResult?, error: Error?) {
        loginService.tratarResultadoLoginFacebook(
            result: result,
            error: error
        )
    }
    
    private func pegarInformacoesDoUsuario() {
//        let currentUser = Auth.auth().currentUser
        
//        let email = currentUser?.email
//        let name = currentUser?.displayName
//        let photo = currentUser?.photoURL
    }
    
    private func salvarDadosNoFirebase(user: GIDGoogleUser?) {
        guard let credencial = loginService.pegarCredencialGoogle(de: user) else { return }
        
        loginService.salvarNoFirebase(com: credencial)
    }
}

extension LoginViewModel: ServiceDelegate {
    func returnAPIMessage(message: String) {
        self.delegate?.exibeMensagemAlert(mensagem: message)
    }
}
