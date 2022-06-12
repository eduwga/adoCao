//
//  UsuarioViewController.swift
//  AdoCao
//
//  Created by André N. dos Santos on 05/06/22.
//

import UIKit

class DetalhesUsuarioViewController: UIViewController {

    @IBOutlet weak var contatoLabel: UILabel!
    @IBOutlet weak var ufLabel: UILabel!
    @IBOutlet weak var cidadeLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var fotoImageView: UIImageView!
    
    var viewModel: DetalhesUsuarioViewModel?
    
    @IBAction func editarButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "editarUsuarioSegue", sender: viewModel?.getUsuario())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let emailUsuario = UserDefaults.standard.string(forKey: "emailDoUsuario")
        viewModel = DetalhesUsuarioViewModel(emailUsuario: emailUsuario!)
        viewModel?.delegate = self
        viewModel?.forcarInicioTela()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setGradientBackground()
        super.viewWillAppear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let telaEditarUsuario = segue.destination as? EditarUsuarioViewController else { return }
        if let vm = viewModel?.obterVMTelaEditarUsuario(sender) {
            telaEditarUsuario.viewModel = vm
            telaEditarUsuario.configuraTela(vm: vm)
        }
    }
    
    private func setGradientBackground() {
        let colorTop =  UIColor(red: 250.0/255.0, green: 214.0/255.0, blue: 255/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 255.0/255.0, green: 94.0/255.0, blue: 58.0/255.0, alpha: 0.0).cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 0.35]
        gradientLayer.frame = self.view.bounds
                
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    private func configuraFotoDoUsuario(nomeFoto: String?) {
        fotoImageView.image = UIImage(named: viewModel!.validarFoto(nomeFoto: nomeFoto))
        let valorRadius = fotoImageView.frame.size.height / 2.0
        fotoImageView.layer.cornerRadius = valorRadius
        fotoImageView.layer.borderWidth = 1
        fotoImageView.layer.borderColor = UIColor.purple.cgColor
    }
}
extension DetalhesUsuarioViewController: DetalhesUsuarioViewModelDelegate {
    func configuraPropriedadesView(usuario: Usuario) {
        nomeLabel.text = usuario.getNome()
        emailLabel.text = usuario.getEmail()
        cidadeLabel.text = usuario.getCidade()
        ufLabel.text = usuario.getUF()
        contatoLabel.text = usuario.getContato()
        configuraFotoDoUsuario(nomeFoto: usuario.getCaminhoDaFoto())
    }
}
