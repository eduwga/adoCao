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
    @IBOutlet weak var racaLabel: UILabel!
    
    var viewModel: DetalhesRacaViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        iniciaActivityIndicator(activityIndicatorView: activityIndicatorView)
        configuraFoto(nomeFoto: "", imageView: racaImageView)
        exibeDadosIniciais()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setGradientBackground(
            colorTop: UIColor(red: 250.0/255.0, green: 214.0/255.0, blue: 255/255.0, alpha: 1.0),
            colorBottom: UIColor(red: 255.0/255.0, green: 94.0/255.0, blue: 58.0/255.0, alpha: 0.0)
        )
        super.viewWillAppear(animated)
    }
    
    func configInicial(vm: DetalhesRacaViewModel?) {
        self.viewModel = vm
    }
    
    func exibeDadosIniciais() {
        if let raca = viewModel?.getRaca() {
            self.configuraFoto(nomeFoto: raca.imagemURL, imageView: racaImageView)
            carcteristicasLabel.text = raca.caracteristicas
            naturalidadeLabel.text = raca.origem
            pesoLabel.text = raca.pesoMedio
            alturaLabel.text = raca.alturaMedia
            estimativaDeVidaLabel.text = raca.estimativaDeVida
            racaLabel.text = raca.nome
            finalizaActivityIndicator(activityIndicatorView: activityIndicatorView)
        }
    }
}
