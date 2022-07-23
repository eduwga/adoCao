//
//  LoginService.swift
//  AdoCao
//
//  Created by André N. dos Santos on 22/07/22.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import GoogleSignIn
import FacebookLogin
import Kingfisher

protocol LoginServiceDelegate {
    func usuarioLogadoNoFirebase(usuario: Usuario)
    func usuarioComErroNoFirebase(error: Error)
}

class LoginService {
    
    var delegate: LoginServiceDelegate?
    
    func salvarNoFirebase(com credencial: AuthCredential) {
        
        Auth.auth().signIn(with: credencial) { authResult, error in
            if let error = error {
                self.delegate?.usuarioComErroNoFirebase(error: error)
                print(error)
            }
            guard let authResult = authResult else { return }
            guard let currentUser = Auth.auth().currentUser else { return }
            
            let usuario = Usuario(
                id: 0,
                nome: authResult.user.displayName ?? "",
                email: authResult.user.email ?? "",
                senha: UUID.init().uuidString,
                cep: "",
                cidade: "",
                uf: "",
                contato: authResult.user.phoneNumber ?? "",
                foto: authResult.user.photoURL?.path ?? ""
            )
            
            self.delegate?.usuarioLogadoNoFirebase(usuario: usuario)
            
            return
        }
        
    }
    
    func tratarResultadoLoginFacebook(result: LoginManagerLoginResult?, error: Error?) {
        switch result {
            
        case .none:
            print("Um erro aconteceu")
        case .some(let loginResult):
            
            guard let token = loginResult.token?.tokenString else {
                return
            }
            
            let credencial = pegarCredencialFacebook(
                token: token
            )
            
            salvarNoFirebase(com: credencial)
        }
    }
    
    func pegarCredencialFacebook(token: String) -> AuthCredential {
        return FacebookAuthProvider.credential(
            withAccessToken: token
        )
    }
    
    func pegarCredencialGoogle(de user: GIDGoogleUser?) -> AuthCredential? {
        guard
            let authentication = user?.authentication,
            let idToken = authentication.idToken
        else {
            return nil
        }
        
        
        let credential = GoogleAuthProvider.credential(
            withIDToken: idToken,
            accessToken: authentication.accessToken
        )
        
        return credential
        
    }
    
    func pegarConfiguracaoGoogle() -> GIDConfiguration? {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return nil }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        
        return config
    }
}
