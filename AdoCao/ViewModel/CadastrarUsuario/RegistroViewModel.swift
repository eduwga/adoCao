//
//  RegistroViewModel.swift
//  AdoCao
//
//  Created by André N. dos Santos on 26/06/22.
//

import Foundation

protocol RegistroViewModelDelegate {
    func exibeAlertaErro(mensagem: String)
    func cadastroComSucesso(mensagem: String)
}
class RegistroViewModel {
    let service = Service.shared
    var delegate: RegistroViewModelDelegate?
    
    private func validaSenhaConfirmacao(senha: String, confirmacao: String) -> Bool {
        if senha != confirmacao {
            delegate?.exibeAlertaErro(mensagem: "O preenchimento das senhas é obrigatório")
            return false
        }
        return true
    }
    
    func armazenaUsuarioNoDispositivo(email: String, senha: String) {
        // armazenar dados cadastrais
        ///Deve ser trocado para CoreData
        UserDefaults.standard.set(email, forKey: "emailDoUsuario")
        UserDefaults.standard.set(senha, forKey: "senhaDoUsuario")
        UserDefaults.standard.synchronize()
    }
    
    func cadastraUsuario(nome: String?, email: String?, uf: String?, cep: String?, senha: String?, confirmacao: String?) {
        guard let nome = nome, let email = email, let senha = senha, let uf = uf, let cep = cep, let confirmacao = confirmacao else {
            delegate?.exibeAlertaErro(mensagem: "Todos os campos são obrigatórios!")
            return
        }
        if validaSenhaConfirmacao(senha: senha, confirmacao: confirmacao) {
            let usuario = Usuario(id: 0, nome: nome, email: email, senha: senha, cep: cep, cidade: "", uf: uf, contato: "")
            
            service.create(user: usuario) { novoUsuario in
                ///Deveriamos salvar o usuario todo no dispositivo
                self.armazenaUsuarioNoDispositivo(email: email, senha: senha)
                self.delegate?.cadastroComSucesso(mensagem: "Sucesso")

            }
        }
    }
}
