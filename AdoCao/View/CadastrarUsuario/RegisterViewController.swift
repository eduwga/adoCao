//
//  RegisterViewController.swift
//  AdoCao
//
//  Created by Thales S. Bernardes on 06/06/22.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var senhaTextField: UITextField!
    @IBOutlet weak var confirmarSenhaTextField: UITextField!
    @IBOutlet weak var estadoTextField: UITextField!
    @IBOutlet weak var CEPTextField: UITextField!
    
    let viewModel: RegistroViewModel = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func jaPossuoLoginButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func cadastrarButton(_ sender: Any) {
        
        viewModel.cadastraUsuario(nome: nomeTextField.text, email: emailTextField.text, uf: estadoTextField.text, cep: CEPTextField.text, senha: senhaTextField.text, confirmacao: confirmarSenhaTextField.text)
        
    }
    
    private func exibeAlerta(mensagem: String) {
        let alerta = UIAlertController(title: "Ops!", message: mensagem, preferredStyle: UIAlertController.Style.alert)
        
        let botaoCadastrar = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        
        alerta.addAction(botaoCadastrar)
        self.present(alerta, animated: true, completion: nil)
    }
}
extension RegisterViewController: RegistroViewModelDelegate {
    func exibeAlertaErro(mensagem: String) {
        self.exibeAlerta(mensagem: mensagem)
    }
    
    func cadastroComSucesso(mensagem: String) {
        self.exibeAlerta(mensagem: "Usuario cadastrado com sucesso!")
        
        // alerta de confirmacao de cadastro
        let alertaConfirmacao = UIAlertController(title: "Muito bem!", message: "Seu cadastro foi realizado com sucesso. Seja bem vindo(a)!", preferredStyle: UIAlertController.Style.alert)
        
        let botaoCadastrar = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { action in
            self.dismiss(animated: true, completion: nil)
        }
        
        alertaConfirmacao.addAction(botaoCadastrar)
        self.present(alertaConfirmacao, animated: true, completion: nil)
    }
    
    
}
