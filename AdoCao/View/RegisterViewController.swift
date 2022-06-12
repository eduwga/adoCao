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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cadastrarButton(_ sender: Any) {
        
        let nomeDoUsuario = nomeTextField.text
        let emailDoUsuario = emailTextField.text
        let senhaDoUsuario = senhaTextField.text
        let confirmarSenhaDoUsuario = confirmarSenhaTextField.text
        let estadoDoUsuario = estadoTextField.text
        let CEPDoUsuario = CEPTextField.text
        
        // verificar se todos os campos estao preenchidos
        
        if nomeDoUsuario == "" ||
        emailDoUsuario == "" ||
        senhaDoUsuario == "" ||
        confirmarSenhaDoUsuario == "" ||
        estadoDoUsuario == "" ||
        CEPDoUsuario == "" {
            
            // mensagem de alerta
            
            alertaNaTela(mensagemNaTela: "Todos os campos são obrigatórios!")
            
            return
            
        }
        
        if senhaDoUsuario != confirmarSenhaDoUsuario {
            
            // alerta na tela de senhas diferentes
            alertaNaTela(mensagemNaTela: "As senhas estão diferentes!")
            return
        }
        
        // armazenar dados cadastrais
        UserDefaults.standard.set(emailDoUsuario, forKey: "emailDoUsuario")
        UserDefaults.standard.set(senhaDoUsuario, forKey: "senhaDoUsuario")
        UserDefaults.standard.synchronize()
        
        // alerta de confirmacao de cadastro
        var alertaConfirmacao = UIAlertController(title: "Muito bem!", message: "Seu cadastro foi realizado com sucesso. Seja bem vindo(a)!", preferredStyle: UIAlertController.Style.alert)
        
        let botaoCadastrar = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { action in
            self.dismiss(animated: true, completion: nil)
        }
        
        alertaConfirmacao.addAction(botaoCadastrar)
        self.present(alertaConfirmacao, animated: true, completion: nil)
        
    }
    
    func alertaNaTela(mensagemNaTela: String) {
        var alerta = UIAlertController(title: "Ops!", message: mensagemNaTela, preferredStyle: UIAlertController.Style.alert)
        
        let botaoCadastrar = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        
        alerta.addAction(botaoCadastrar)
        self.present(alerta, animated: true, completion: nil)
    }
}
