//
//  LoginViewController.swift
//  AdoCao
//
//  Created by Thales S. Bernardes on 06/06/22.
//

import UIKit
import FirebaseAuth
import GoogleSignIn
import FacebookLogin
import FacebookCore
import FBSDKLoginKit
import MessageUI
import SwiftUI
import simd

class LoginViewController: UIViewController {
    
    var iconeClick = false
    let imagemIcone = UIImageView()
    let viewModel = LoginViewModel()
    let loginButton = FBLoginButton(
        frame: CGRect(x: 0, y: 0, width: 230, height: 48), // frame: CGRect(x: 0, y: 0, width: 210, height: 28),
        permissions: [.publicProfile, .userLocation]
    )
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var senhaTextField: UITextField!
    @IBOutlet weak var loginGoogleButton: GIDSignInButton!
    @IBOutlet weak var loginFacebookButton: UIView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Botao de login Google
        loginGoogleButton.style = .wide
        loginGoogleButton.colorScheme = .dark
        
        
        ///Botao de login Facebook
        loginButton.center = loginFacebookButton.center
        loginButton.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        view.addSubview(loginButton)
        
        viewModel.delegate = self
        loginButton.delegate = self
        
        configuraImagemRevelarSenha()
        emailTextField.becomeFirstResponder()
        configuraBotoesProvedoresExternos()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
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
        viewModel.efetuarLoginGoogle()
        exibeAlertaContatoGoogle(mensagem: "Informe o seu número de contato")
    }
    
    
    @IBAction func entrarButton(_ sender: Any) {
        if viewModel.validaEmail(email: emailTextField.text) && viewModel.validaSenha(senha: senhaTextField.text) {
            viewModel.login(email: emailTextField.text, senha: senhaTextField.text)
        }
    }
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
        exibeAlerta(mensagem: "saiu")
    }
    
    private func configuraBotoesProvedoresExternos() {
        
        loginButton.frame.size = .init(width: 270, height: 40)
        loginButton.imageView?.roundCorners(cornerRadius: 30, cornerType: [.superiorDireito, .superiorEsquerdo, .inferiorEsquerdo, .inferiorDireito])
        loginButton.center = loginFacebookButton.center
        loginFacebookButton.isHidden = true
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
    
    private func exibeAlertaContatoGoogle(mensagem: String) {
        let alertaContatoInesistente = UIAlertController(title: "Informe o seu contato:", message: mensagem, preferredStyle: UIAlertController.Style.alert)
        alertaContatoInesistente.addTextField { (textField: UITextField!) -> Void in
            textField.placeholder = "E-mail ou telefone"
        }
        let botaoSalvarContato = UIAlertAction(title: "Salvar", style: UIAlertAction.Style.default, handler: nil)
        alertaContatoInesistente.addAction(botaoSalvarContato)
        self.present(alertaContatoInesistente, animated: true, completion: nil)
    }
    
    private func exibeAlertaContatoFB(mensagemContato: String) {
        let alertaContatoInesistente = UIAlertController(title: "Informe os seus dados:", message: mensagemContato, preferredStyle: UIAlertController.Style.alert)
        alertaContatoInesistente.addTextField { (textField: UITextField!) -> Void in
            textField.placeholder = "Telefone"
        }
        alertaContatoInesistente.addTextField { (textField: UITextField!) -> Void in
            textField.placeholder = "E-mail"
        }
        alertaContatoInesistente.addTextField { (textField: UITextField!) -> Void in
            textField.placeholder = "UF"
        }
        alertaContatoInesistente.addTextField { (textField: UITextField!) -> Void in
            textField.placeholder = "Cidade"
        }
        
        let botaoSalvarContato = UIAlertAction(title: "Salvar", style: UIAlertAction.Style.default, handler: nil)
        alertaContatoInesistente.addAction(botaoSalvarContato)
        self.present(alertaContatoInesistente, animated: true, completion: nil)
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
    
    
    func loginGoogle(configuration: GIDConfiguration) {
        GIDSignIn.sharedInstance.signIn(
            with: configuration,
            presenting: self
        ) { [unowned self] user, error in
            self.viewModel.tratarLoginGoogle(
                user: user,
                error: error
            )
        }
    }
}

extension LoginViewController: LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        switch result {
        case .none:
            return
        case .some(let xxx):
            
            exibeAlertaContatoFB(mensagemContato: "Informe os seus dados:")
            viewModel.tratarLoginFacebook(
                result: result,
                error: error
            )
        }
        
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("O usuário efetuou logout")
    }
}


extension LoginViewController: MFMailComposeViewControllerDelegate {
    
    @IBAction func supportButton(_ sender: Any) {
        
        guard MFMailComposeViewController.canSendMail() else {return}
        
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["suporte@adocao.com.br"])
        composer.setSubject("Suporte")
        composer.setMessageBody("Olá, preciso de ajuda com:", isHTML: false)
        present(composer, animated: true)
        
    }
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .sent:
            print("Email sent")
        case .saved:
            print("Draft saved")
        case .cancelled:
            print("Email cancelled")
        case  .failed:
            print("Email failed")
        @unknown default:
            print("failed")
        }
        controller.dismiss(animated: true, completion: nil)
    }
    
    
}
