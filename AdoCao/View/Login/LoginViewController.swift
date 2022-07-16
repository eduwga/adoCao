//
//  LoginViewController.swift
//  AdoCao
//
//  Created by Thales S. Bernardes on 06/06/22.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class LoginViewController: UIViewController {
    
    var iconeClick = false
    let imagemIcone = UIImageView()
    let viewModel = LoginViewModel()
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var senhaTextField: UITextField!
    @IBOutlet weak var loginGoogleButton: GIDSignInButton!
    
    
    override func viewDidLoad() {
        viewModel.delegate = self
        //verificaSeHaUsuarioLogado()
        
        super.viewDidLoad()
        
        configuraImagemRevelarSenha()
        emailTextField.becomeFirstResponder()
    }
    
    @objc func clickImage(tapGestureRecognizer: UITapGestureRecognizer) {
        let clickImage = tapGestureRecognizer.view as! UIImageView
        
        if iconeClick {
            clickImage.image = UIImage(named: "eye")
        } else {
            clickImage.image = UIImage(named: "eyePassword")
            senhaTextField.becomeFirstResponder()
        }
        iconeClick = !iconeClick
        senhaTextField.isSecureTextEntry = iconeClick
    }
    
    @IBAction func googleLoginButton(_ sender: Any) {
    
        loginGoogle()
        
    }
    
    
    @IBAction func entrarButton(_ sender: Any) {
        
        if viewModel.validaEmail(email: emailTextField.text) && viewModel.validaSenha(senha: senhaTextField.text) {
            
            viewModel.login(email: emailTextField.text, senha: senhaTextField.text)
        }
        //        adicionaViewControllerInicial()
    }
    
    
    private func loginGoogle(){
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in
            
            if let error = error {
                // ...
                return
            }
            
            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
            else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: authentication.accessToken)
            
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    
                }
                return
            }
        }
    }
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
        print("saiu")
    }
    
    
    
    private func verificaSeHaUsuarioLogado() {
        viewModel.verificaSeTemUsuarioLogado()
    }
    
    private func configuraImagemRevelarSenha() {
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
    }
    
    
    private func adicionaViewControllerInicial() {
        ///Não entendi o que faz esse codigo, verificar com o Thales
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
    }
    
    private func exibeAlerta(mensagem: String) {
        let alertaErroLogin = UIAlertController(title: "Ops!", message: mensagem, preferredStyle: UIAlertController.Style.alert)
        let botaoLogin = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alertaErroLogin.addAction(botaoLogin)
        self.present(alertaErroLogin, animated: true, completion: nil)
    }
}
extension LoginViewController: LoginViewModelDelegate {
    func temUsuarioLogado() {
        self.adicionaViewControllerInicial()
    }
    
    func loginComSucesso(_ usuario: Usuario) {
        self.adicionaViewControllerInicial()
        // alerta de confirmacao de login
        let alertaConfirmacaoLogin = UIAlertController(title: "Muito bem!", message: "Seu Login foi realizado com sucesso. Seja bem vindo(a)!", preferredStyle: UIAlertController.Style.alert)
        let botaoLogar = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { action in
            self.dismiss(animated: true, completion: nil)
        }
        alertaConfirmacaoLogin.addAction(botaoLogar)
        self.present(alertaConfirmacaoLogin, animated: true, completion: nil)
    }
    
    func exibeMensagemAlert(mensagem: String) {
        exibeAlerta(mensagem: mensagem)
    }
}
