//
//  DetalheAmigoViewController.swift
//  AdoCao
//
//  Created by Eduardo Waked Gomes de Amorim on 08/06/22.
//

import UIKit

class DetalheAmigoViewController: UIViewController {
    @IBOutlet weak var fotoCaoImageView: UIImageView!
    @IBOutlet weak var nomeCaoLabel: UILabel!
    @IBOutlet weak var localizaCaoLabel: UILabel!
    @IBOutlet weak var descriCaoLabel: UILabel!
    @IBOutlet weak var logoFundoImageView: UIImageView!
    @IBOutlet weak var saibaMaisRacaLabel: UILabel!
    @IBOutlet weak var racaLabel: UILabel!
    
    var viewModel: DetalheAmigoViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuraTela()
    }

    @IBAction func caracteristicaRacaButtonAction(_ sender: Any) { }
    
    func configura(viewModel: DetalheAmigoViewModel) {
        self.viewModel = viewModel
    }
    
    private func configuraTela() {
        if let viewModel = viewModel {
            nomeCaoLabel.text = viewModel.getNome()
            localizaCaoLabel.text = viewModel.getLocalizacao()
            descriCaoLabel.text = viewModel.getDescricao()
            configuraFoto(nomeFoto: viewModel.getFoto(), imageView: fotoCaoImageView)
        }
    }
    
    private func configuraFotoDoUsuario(nomeFoto: String) {
        fotoCaoImageView.image = UIImage(named: nomeFoto)

        let valorRadius = fotoCaoImageView.frame.size.height / 2.0
        fotoCaoImageView.layer.cornerRadius = valorRadius
        fotoCaoImageView.layer.borderWidth = 1
        fotoCaoImageView.layer.borderColor = UIColor.purple.cgColor
    }
}
