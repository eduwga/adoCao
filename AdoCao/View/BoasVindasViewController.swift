//
//  BoasVindasViewController.swift
//  AdoCao
//
//  Created by André N. dos Santos on 12/06/22.
//

import UIKit

class BoasVindasViewController: UIViewController {


    let viewModel: BoasVindasViewModel = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
    }

    @IBAction func vamosLaButtonAction(_ sender: Any) {
        seguirParaLogin()
        return
//        
//        guard let emailUsuarioArmazenado = UserDefaults.standard.string(forKey: "emailDoUsuario") else {
//            seguirParaLogin()
//            return
//        }
//        guard let senhaUsuarioArmazenado = UserDefaults.standard.string(forKey: "senhaDoUsuario") else {
//            seguirParaLogin()
//            return
//        }
//        if emailUsuarioArmazenado == "" || senhaUsuarioArmazenado == ""{
//            seguirParaLogin()
//            return
//        }
        ///Deve buscar do CoreData e ver se pula o login
        //viewModel.validaLogin(email: emailUsuarioArmazenado, senha: senhaUsuarioArmazenado)
    }
    
    private func seguirParaLogin() {
        performSegue(withIdentifier: "telaLoginSegue", sender: nil)
    }
}
extension BoasVindasViewController: BoasVindasViewModelDelegate {
    func atualizaLogin(devePermitir: Bool, usuario: Usuario?) {
        self.seguirParaLogin()
//        if devePermitir {
//            performSegue(withIdentifier: "telaPrincipalSegue", sender: usuario)
//        }
//        else {
//            self.seguirParaLogin()
//        }
    }
    
    
}
