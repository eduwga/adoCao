//
//  DetalheAmigoViewController.swift
//  AdoCao
//
//  Created by Eduardo Waked Gomes de Amorim on 08/06/22.
//

import UIKit
import CoreLocation
import MapKit

class DetalheAmigoViewController: UIViewController {
    @IBOutlet weak var fotoCaoImageView: UIImageView!
    @IBOutlet weak var nomeCaoLabel: UILabel!
    @IBOutlet weak var localizaCaoLabel: UILabel!
    @IBOutlet weak var descriCaoLabel: UILabel!
    @IBOutlet weak var saibaMaisRacaLabel: UILabel!
    @IBOutlet weak var racaLabel: UILabel!
    @IBOutlet weak var localMapView: MKMapView!
    
    var viewModel: DetalheAmigoViewModel?
    var tipoOperacao: TipoListagem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuraTela()
    }

    @IBAction func caracteristicaRacaButtonAction(_ sender: Any) { }
    
    func configura(viewModel: DetalheAmigoViewModel, tipoOperacao: TipoListagem) {
        self.viewModel = viewModel
        self.tipoOperacao = tipoOperacao
    }
    
    private func configuraTela() {
        defineCorDeFundo()
        defineValorLabels()
        configuraFoto(nomeFoto: viewModel?.getFoto(), imageView: fotoCaoImageView)
        adicionaCoordenadasNoMapa()
    }
    
    private func defineCorDeFundo() {
        setGradientBackground(
            colorTop: UIColor(red: 250.0/255.0, green: 214.0/255.0, blue: 255/255.0, alpha: 1.0),
            colorBottom: UIColor(red: 255.0/255.0, green: 94.0/255.0, blue: 58.0/255.0, alpha: 0.0)
        )
    }
    
    private func defineValorLabels() {
        if let viewModel = viewModel {
            nomeCaoLabel.text = viewModel.getNome()
            localizaCaoLabel.text = viewModel.getLocalizacao()
            descriCaoLabel.text = viewModel.getDescricao()
        }
    }
    
    private func adicionaCoordenadasNoMapa() {
        if let viewModel = viewModel {
            let coordenadas = viewModel.getCoordenadas()
            if coordenadas.count > 0 {
                localMapView.isHidden = false
                let local = Local(title: viewModel.getNome(), subtitle: viewModel.getEndereco(), coordinate: CLLocationCoordinate2D(latitude: coordenadas[0], longitude: coordenadas[1]))
                configuraMapa(local: local)
            }
            else {
                localMapView.isHidden = true
            }
        }
    }
    
    private func configuraMapa(local: Local) {
        localMapView.addAnnotations([local])
        localMapView.showAnnotations([local], animated: true)
        localMapView.camera.altitude *= 1.4;
    }
    
    private func configuraFotoDoUsuario(nomeFoto: String) {
        fotoCaoImageView.image = UIImage(named: nomeFoto)

        let valorRadius = fotoCaoImageView.frame.size.height / 2.0
        fotoCaoImageView.layer.cornerRadius = valorRadius
        fotoCaoImageView.layer.borderWidth = 1
        fotoCaoImageView.layer.borderColor = UIColor.purple.cgColor
    }
}
