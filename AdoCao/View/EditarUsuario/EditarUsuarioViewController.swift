//
//  EditarUsuarioViewController.swift
//  AdoCao
//
//  Created by André N. dos Santos on 08/06/22.
//

import UIKit

class EditarUsuarioViewController: UIViewController {
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var contatoTextField: UITextField!
    @IBOutlet weak var ufTextField: UITextField!
    @IBOutlet weak var cidadetextField: UITextField!
    @IBOutlet weak var fotoImageView: UIImageView!
    @IBOutlet weak var novaSenhaTextField: UITextField!
    @IBOutlet weak var confirmarSenhaTextField: UITextField!
    
    var viewModel: EditarUsuarioViewModel?
    let fotoPadrao: String = "customPerson"

    override func viewDidLoad() {
        super.viewDidLoad()
        iniciaActivityIndicator()
        configuraFotoDoUsuario(nomeFoto: fotoPadrao)
        configuraTela()
    }
    
    func configuraTela(vm: EditarUsuarioViewModel) {
        self.viewModel = vm
    }
    
    @IBAction func alterarUsuarioButtonAction(_ sender: Any) {
        exibirAlertConfirmacao()
    }
    
    @IBAction func tirarFotoButtonAction(_ sender: Any) {
        abrirImagePickerViewController(modo: .camera)
    }
    
    @IBAction func buscarNaGaleriaButtonAction(_ sender: Any) {
        abrirImagePickerViewController(modo: .photoLibrary)
    }
    
    private func configuraTela() {
        if let usuario = viewModel?.getUsuario() {
            self.nomeTextField.text = usuario.getNome()
            self.cidadetextField.text = usuario.getCidade()
            self.ufTextField.text = usuario.getUF()
            self.contatoTextField.text = usuario.getContato()
            configuraFoto(nomeFoto: usuario.getCaminhoDaFoto(), imageView: fotoImageView)
        }
        finalizaActivityIndicator()
    }
    
    private func iniciaActivityIndicator() {
        activityIndicatorView.isHidden = false
        activityIndicatorView.color = UIColor.purple
        activityIndicatorView.style = .large
        activityIndicatorView.startAnimating()
    }
    
    private func finalizaActivityIndicator() {
        activityIndicatorView.isHidden = true
        activityIndicatorView.stopAnimating()
    }
    
    private func configuraFotoDoUsuario(nomeFoto: String?) {
        if let nomeFoto = viewModel?.validarFoto(nomeFoto: nomeFoto) {
            fotoImageView.image = UIImage(named: nomeFoto)
        }
        let valorRadius = fotoImageView.frame.size.height / 2.0
        fotoImageView.layer.cornerRadius = valorRadius
        fotoImageView.layer.borderWidth = 1
        fotoImageView.layer.borderColor = UIColor.purple.cgColor
    }

    private func abrirImagePickerViewController(modo: UIImagePickerController.SourceType) {
        iniciaActivityIndicator()
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = modo
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    private func exibirAlertConfirmacao() {
        iniciaActivityIndicator()
        let alerta = UIAlertController(title: "Alterando Usuario",message: "Deseja realmente alterar os dados de usuário?",preferredStyle: .alert)
        
        let actionConfirma = UIAlertAction(title: "Sim", style: .default) { alert in
            self.finalizaActivityIndicator()
        }
        let actionCancela = UIAlertAction(title: "Cancelar", style: .destructive) { alert in
            self.finalizaActivityIndicator()
        }
        
        alerta.addAction(actionConfirma)
        alerta.addAction(actionCancela)
        
        present(alerta, animated: true)
    }
}

extension EditarUsuarioViewController:  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        finalizaActivityIndicator()
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            fotoImageView.image = image
            let imageStringBase64 = image.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
            viewModel?.enviarFotoUsuarioParaAPI(base64Image: imageStringBase64)
        }
        
        finalizaActivityIndicator()
        dismiss(animated: true)
    }
}
