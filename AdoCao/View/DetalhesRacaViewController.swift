//
//  DetalhesRacaViewController.swift
//  AdoCao
//
//  Created by Marcos Vinicius on 08/06/22.
//

import UIKit

class DetalhesRacaViewController: UIViewController {

    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var racaImageView: UIImageView!
    @IBOutlet weak var carcteristicasLabel: UILabel!
    @IBOutlet weak var naturalidadeLabel: UILabel!
    @IBOutlet weak var pesoLabel: UILabel!
    @IBOutlet weak var alturaLabel: UILabel!
    @IBOutlet weak var estimativaDeVidaLabel: UILabel!
    
    var viewModel: DetalhesRacaViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        iniciaActivityIndicator()
        configuraFotoDoUsuario(nomeFoto: "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setGradientBackground()
        super.viewWillAppear(animated)
    }
    
    func setGradientBackground() {
        let colorTop =  UIColor(red: 250.0/255.0, green: 214.0/255.0, blue: 255/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 255.0/255.0, green: 94.0/255.0, blue: 58.0/255.0, alpha: 0.0).cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 0.35]
        gradientLayer.frame = self.view.bounds
                
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    func configInicial(vm: DetalhesRacaViewModel?) {
        self.viewModel = vm
        self.viewModel?.delegate = self
        self.viewModel?.configuracaotela()
    }
    
    private func configuraFotoDoUsuario(nomeFoto: String?) {
        if let nomeFoto = viewModel?.validarFoto(nomeFoto: nomeFoto) {
            racaImageView.image = UIImage(named: nomeFoto)
        }
        let valorRadius = racaImageView.frame.size.height / 2.0
        racaImageView.layer.cornerRadius = valorRadius
        racaImageView.layer.borderWidth = 1
        racaImageView.layer.borderColor = UIColor.purple.cgColor
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
}
extension DetalhesRacaViewController: DetalhesRacaViewModelDelegate {
    func exibeDadosIniciais(raca: Raca) {
        self.configuraFotoDoUsuario(nomeFoto: raca.imagemURL)
        carcteristicasLabel.text = raca.caracteristicas
        naturalidadeLabel.text = raca.origem
        pesoLabel.text = raca.pesoMedio
        alturaLabel.text = raca.alturaMedia
        estimativaDeVidaLabel.text = raca.estimativaDeVida
        finalizaActivityIndicator()
    }
}
