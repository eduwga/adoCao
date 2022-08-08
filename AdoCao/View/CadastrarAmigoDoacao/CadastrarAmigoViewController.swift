//
//  CadastrarAmigoViewController.swift
//  AdoCao
//

//  Created by Marcos Vinicius on 08/06/22.
//

import UIKit
import CoreLocation

class CadastrarAmigoViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var amigoImageView: UIImageView!
    @IBOutlet weak var amigoNomeTextField: UITextField!
    @IBOutlet weak var idadeStepper: UIStepper!
    @IBOutlet weak var idadeAproxTextField: UITextField!
    @IBOutlet weak var amigoDescricaoTextField: UITextField!
    @IBOutlet weak var racaPikerView: UIPickerView!
    
    //MARK: - Properties
    private let locationManager: CLLocationManager = .init()
    var localizacaoDoUsuario: CLLocationCoordinate2D?
    var viewModel: CadastrarAmigoViewModel = .init()

    //MARK: - Initializers
    override func viewWillAppear(_ animated: Bool) {
        setGradientBackground(
            colorTop: UIColor(red: 250.0/255.0, green: 214.0/255.0, blue: 255/255.0, alpha: 1.0),
            colorBottom: UIColor(red: 255.0/255.0, green: 94.0/255.0, blue: 58.0/255.0, alpha: 0.0)
        )
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        locationManager.delegate = self
        racaPikerView.dataSource = self
        racaPikerView.delegate = self
        
        configuraFotoPlaceholder(imageView: amigoImageView)
        
        idadeStepper.wraps = true
        idadeStepper.autorepeat = true
        idadeStepper.maximumValue = 30

        locationManager.desiredAccuracy = .greatestFiniteMagnitude
        locationManager.requestAlwaysAuthorization()
        
        finalizaActivityIndicator(activityIndicatorView: activityIndicator)
    }
    
    //MARK: - IBActions
    @IBAction func idadeStepperValueChanged(_ sender: UIStepper) {
        idadeAproxTextField.text = Int(sender.value).description
    }
    
    @IBAction func botaoCadastrar(_ sender: Any) {
        //enviar dados para cadastro na VM
        viewModel.cadastrarAmigo(
            nome: amigoNomeTextField.text,
            idade: idadeAproxTextField.text,
            raca: racaPikerView.selectedRow(inComponent: 0),
            descricao: amigoDescricaoTextField.text,
            latitude: localizacaoDoUsuario?.latitude ?? 0,
            longitude: localizacaoDoUsuario?.longitude ?? 0
        )
    }
    
    @IBAction func tirarFotoButtonAction(_ sender: Any) {
        abrirImagePickerViewController(modo: .camera)
    }
    
    @IBAction func buscarNaGaleriaButtonAction(_ sender: Any) {
        abrirImagePickerViewController(modo: .photoLibrary)
    }
    
    //MARK: - Private Functions
    private func abrirImagePickerViewController(modo: UIImagePickerController.SourceType) {
        iniciaActivityIndicator(activityIndicatorView: activityIndicator)
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = modo
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    private func limpaTela() {
        amigoImageView.image = UIImage(named: "iconDog")
        amigoNomeTextField.text = ""
        idadeAproxTextField.text = "0"
        amigoDescricaoTextField.text = ""
    }
}
    //MARK: - ImagePicker Delegate
extension CadastrarAmigoViewController:  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        finalizaActivityIndicator(activityIndicatorView: activityIndicator)
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            amigoImageView.image = image
            let imageStringBase64 = image.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
            self.viewModel.enviarFotoAmigoParaAPI(base64Image: imageStringBase64)
        }
        
        finalizaActivityIndicator(activityIndicatorView: activityIndicator)
        dismiss(animated: true)
    }
}

    //MARK: - Location Delegate
extension CadastrarAmigoViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let userLocation = locations.first {
            self.localizacaoDoUsuario = userLocation.coordinate
        }
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }
}

//MARK: - PikerView Datasource & Delegate
extension CadastrarAmigoViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.obterRacas().count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let racas = viewModel.obterRacas()
        return racas[row]
    }
}

//MARK: - ViewModel Delegate
extension CadastrarAmigoViewController: CadastrarAmigoViewModelDelegate {
    func cadastroEfetuado(resultado: Bool) {
        if resultado {
            self.limpaTela()
            self.navigationController?.popViewController(animated: true)
        }
        else {
            self.exibeAlertaSimples(mensagem: "Erro ao efetuar cadastro, tente novamente mais tarde")
        }
    }
    
    func listaDeRacasAtualizada() {
        self.racaPikerView.reloadAllComponents()
    }
}
