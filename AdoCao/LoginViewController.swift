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
        }
    }


    @IBAction func entrarButton(_ sender: Any) {
        
        let emailDoUsuario = emailTextField.text
        let senhaDoUsuario = senhaTextField.text
        
        let armazenaEmailUsuario = UserDefaults.standard.string(forKey: "emailDoUsuario")
        
        let armazenaSenhaUsuario = UserDefaults.standard.string(forKey: "senhaDoUsuario")
        
        if armazenaEmailUsuario == emailDoUsuario {
            if armazenaSenhaUsuario == senhaDoUsuario {
                // sucesso no login
                UserDefaults.standard.setValue(true, forKey: "Login efetuado com sucesso!")
                UserDefaults.standard.synchronize()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
