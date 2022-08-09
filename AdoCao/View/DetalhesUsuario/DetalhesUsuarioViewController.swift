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
    
    @IBAction func sairButtonAction(_ sender: Any) {
        viewModel?.deslogarUsuario()
    }
    
    @IBAction func irParaListaAmigosButtonAction(_ sender: Any) {
        tabBarController?.selectedIndex = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = DetalhesUsuarioViewModel()
        viewModel?.delegate = self
        viewModel?.forcarInicioTela()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setGradientBackground(
            colorTop: UIColor(red: 250.0/255.0, green: 214.0/255.0, blue: 255/255.0, alpha: 1.0),
            colorBottom: UIColor(red: 255.0/255.0, green: 94.0/255.0, blue: 58.0/255.0, alpha: 0.0)
        )
        super.viewWillAppear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let telaEditarUsuario = segue.destination as? EditarUsuarioViewController else { return }
        if let vm = viewModel?.obterVMTelaEditarUsuario(sender) {
            telaEditarUsuario.configuraTela(vm: vm)
        }
    }
}

extension DetalhesUsuarioViewController: DetalhesUsuarioViewModelDelegate {
    func configuraPropriedadesView(usuario: Usuario) {
        nomeLabel.text = usuario.getNome()
        emailLabel.text = usuario.getEmail()
        cidadeLabel.text = usuario.getCidade()
        ufLabel.text = usuario.getUF()
        contatoLabel.text = usuario.getContato()
        configuraFoto(nomeFoto: usuario.getCaminhoDaFoto(),  imageView: fotoImageView)
    }
    
    func retornaParaLogin() {
        performSegue(withIdentifier: "unwindToLogin", sender: self)
        
        tabBarController?.navigationController?.popToRootViewController(animated: true)
    }
}
