//
//  LoginViewController.swift
//  AdoCao
//
//  Created by Thales S. Bernardes on 06/06/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    var iconeClick = false
    let imagemIcone = UIImageView()
    let service = Service()

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var senhaTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagemIcone.image = UIImage(named: "eyePassword")
        
        let contentView = UIView()
        contentView.addSubview(imagemIcone)
        
        contentView.frame = CGRect(x: 0, y: 0, width: UIImage(named: "eyePassword")!.size.width, height: UIImage(named: "eyePassword")!.size.height)
        
        imagemIcone.frame = CGRect(x: -10, y: 0, width: UIImage(named: "eyePassword")!.size.width, height: UIImage(named: "eyePassword")!.size.height)
        
        senhaTextField.rightView = contentView
        senhaTextField.rightViewMode = .always
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickImage(tapGestureRecognizer:)))
        imagemIcone.isUserInteractionEnabled = true
        imagemIcone.addGestureRecognizer(tapGestureRecognizer)
        
        emailTextField.becomeFirstResponder()
    }
    
    @objc func clickImage(tapGestureRecognizer: UITapGestureRecognizer) {
        let clickImage = tapGestureRecognizer.view as! UIImageView
        
        if iconeClick {
            iconeClick = false
            clickImage.image = UIImage(named: "eye")
            senhaTextField.isSecureTextEntry = false
        } else {
            iconeClick = true
            clickImage.image = UIImage(named: "eyePassword")
            senhaTextField.isSecureTextEntry = true
            senhaTextField.becomeFirstResponder()
        }
    }


    @IBAction func entrarButton(_ sender: Any) {
        guard let emailDoUsuario = emailTextField.text else {
            alertaLoginInvalido(mensagem: "O campo e-mail é obrigatório!")
            return
        }
        guard let senhaDoUsuario = senhaTextField.text else {
            alertaLoginInvalido(mensagem: "O campo senha é obrigatório!")
            return
        }

        if emailDoUsuario == "" || senhaDoUsuario == "" {
            // alerta campos obrigatorios
            alertaLogin(mensagemNaTela: "Todos os campos são obrigatórios!")
            return
        }

        if !service.login(email: emailDoUsuario, password: senhaDoUsuario) {
            alertaLoginInvalido(mensagem: "As informações de login são inválidas")
            return
        }
        UserDefaults.standard.set(emailDoUsuario, forKey: "emailDoUsuario")
        UserDefaults.standard.set(senhaDoUsuario, forKey: "senhaDoUsuario")
        
        let armazenaEmailUsuario = UserDefaults.standard.string(forKey: "emailDoUsuario")
        let armazenaSenhaUsuario = UserDefaults.standard.string(forKey: "senhaDoUsuario")

        if let navigationController = navigationController {

            var viewControllers = navigationController.viewControllers

            for (index, viewController) in viewControllers.enumerated() where viewController is LoginViewController {
                viewControllers.remove(at: index)
            }

            let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let initialViewController = storyBoard.instantiateViewController(withIdentifier: "amigoParaAdocao")

            viewControllers.append(initialViewController)

            navigationController.setViewControllers(viewControllers, animated: true)
        }
        
        
        if armazenaEmailUsuario == emailDoUsuario && armazenaSenhaUsuario == senhaDoUsuario {
            
            // alerta de confirmacao de login
            let alertaConfirmacaoLogin = UIAlertController(title: "Muito bem!", message: "Seu Login foi realizado com sucesso. Seja bem vindo(a)!", preferredStyle: UIAlertController.Style.alert)
            
            let botaoLogar = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { action in
                self.dismiss(animated: true, completion: nil)
            }
            
            alertaConfirmacaoLogin.addAction(botaoLogar)
            self.present(alertaConfirmacaoLogin, animated: true, completion: nil)

        } else {
            // usuario ou senha invalidos
            alertaLogin(mensagemNaTela: "Usuario ou senha invalidos.")
        }
    }



    func alertaLogin(mensagemNaTela: String) {
        let alertaErroLogin = UIAlertController(title: "Ops!", message: mensagemNaTela, preferredStyle: UIAlertController.Style.alert)
    
        let botaoLogin = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
    
        alertaErroLogin.addAction(botaoLogin)
        self.present(alertaErroLogin, animated: true, completion: nil)
        
    }
    
    private func alertaLoginInvalido(mensagem: String) {
        alertaLogin(mensagemNaTela: mensagem)
        return
    }
}