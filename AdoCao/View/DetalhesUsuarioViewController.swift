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
    @IBOutlet weak var logoBackgroundImageView: UIImageView!
    @IBOutlet weak var fotoImageView: UIImageView!
    
    var viewModel: DetalhesUsuarioViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = DetalhesUsuarioViewModel(usuario: DataBase.shared.usuarios[1])
        viewModel?.delegate = self
        viewModel?.forcarInicioTela()
    }
    
    @IBAction func listarAmigosParaAdocaoButtonAction(_ sender: Any) {
        
    }
    
    @IBAction func cadastrarAmigoParaAdocaoButtonAction(_ sender: Any) {
        
    }
    
    @IBAction func editarUsuarioButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "editarUsuarioSegue", sender: viewModel?.getUsuario()) ///Sim, precisa refatorar!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let telaEditarUsuario = segue.destination as? EditarUsuarioViewController else { return }
        if let vm = viewModel?.obterVMTelaEditarUsuario(sender) {
            telaEditarUsuario.viewModel = vm
            telaEditarUsuario.recarregaTela()
        }
    }
    
    private func configuraFotoDoUsuario(nomeFoto: String?) {
        
        fotoImageView.image = UIImage(named: validarFoto(nomeFoto: nomeFoto))
        fotoImageView.layer.cornerRadius = 70
        fotoImageView.layer.borderWidth = 1
        fotoImageView.layer.borderColor = UIColor.black.cgColor
    }
    
    private func validarFoto(nomeFoto: String?) -> String {
        if let nomeFoto = nomeFoto {
            if nomeFoto != ""{
                return nomeFoto
            }
        }
        return "customPerson"
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
