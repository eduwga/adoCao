//
//  CadastrarAmigoViewController.swift
//  AdoCao
//

//  Created by Marcos Vinicius on 08/06/22.
//

import UIKit

class CadastrarAmigoViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var amigoImageView: UIImageView!
    @IBOutlet weak var amigoNomeTextField: UITextField!
    @IBOutlet weak var amigoIdadeTextField: UITextField!
    @IBOutlet weak var amigoCaracteristicasTextField: UITextField!
    
    var viewModel: CadastrarAmigoViewModel?
    
    override func viewWillAppear(_ animated: Bool) {
        setGradientBackground(
            colorTop: UIColor(red: 250.0/255.0, green: 214.0/255.0, blue: 255/255.0, alpha: 1.0),
            colorBottom: UIColor(red: 255.0/255.0, green: 94.0/255.0, blue: 58.0/255.0, alpha: 0.0)
        )
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuraFoto(nomeFoto: viewModel?.getCaminhoDaFoto(), imageView: amigoImageView)
    }
    
    @IBAction func botaoCadastrar(_ sender: Any) {
        
    }
    
    @IBAction func tirarFotoButtonAction(_ sender: Any) {
        abrirImagePickerViewController(modo: .camera)
    }
    
    @IBAction func buscarNaGaleriaButtonAction(_ sender: Any) {
        abrirImagePickerViewController(modo: .photoLibrary)
    }
    
    private func abrirImagePickerViewController(modo: UIImagePickerController.SourceType) {
        iniciaActivityIndicator(activityIndicatorView: activityIndicator)
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = modo
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
}
extension CadastrarAmigoViewController:  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        finalizaActivityIndicator(activityIndicatorView: activityIndicator)
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            amigoImageView.image = image
            let imageStringBase64 = image.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
            self.viewModel?.enviarFotoAmigoParaAPI(base64Image: imageStringBase64)
        }
        
        finalizaActivityIndicator(activityIndicatorView: activityIndicator)
        dismiss(animated: true)
    }
}
