//
//  EditarUsuarioViewController.swift
//  AdoCao
//
//  Created by André N. dos Santos on 08/06/22.
//

import UIKit

class EditarUsuarioViewController: UIViewController {
    
    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var contatoTextField: UITextField!
    @IBOutlet weak var ufTextField: UITextField!
    @IBOutlet weak var cidadetextField: UITextField!
    @IBOutlet weak var fotoImageView: UIImageView!
    @IBOutlet weak var novaSenhaTextField: UITextField!
    @IBOutlet weak var confirmarSenhaTextField: UITextField!
    
    var viewModel: EditarUsuarioViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.fotoImageView.image = UIImage(named: "customPerson")
        viewModel?.delegate = self
    }
    
    func recarregaTela() {
        viewModel?.forcarInicioTela()
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

    private func abrirImagePickerViewController(modo: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = modo
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    private func exibirAlertConfirmacao() {
        let alerta = UIAlertController(title: "Alterando Usuario",message: "Deseja realmente alterar os dados de usuário?",preferredStyle: .alert)
        
        let actionConfirma = UIAlertAction(title: "Sim", style: .default)
        let actionCancela = UIAlertAction(title: "Cancelar", style: .destructive)
        
        alerta.addAction(actionConfirma)
        alerta.addAction(actionCancela)
        
        present(alerta, animated: true)
    }
}
extension EditarUsuarioViewController: EditarUsuarioViewModelDelegate {
    
    func configuraTelaCom(usuario: Usuario) {
        self.nomeTextField.text = usuario.getNome()
        self.cidadetextField.text = usuario.getCidade()
        self.ufTextField.text = usuario.getUF()
        self.contatoTextField.text = usuario.getContato()
        
        self.fotoImageView.image = UIImage(named: usuario.getCaminhoDaFoto())
    }
}

extension EditarUsuarioViewController:  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            fotoImageView.image = image
        }
        dismiss(animated: true)
    }
}
