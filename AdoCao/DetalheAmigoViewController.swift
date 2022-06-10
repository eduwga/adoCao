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
    
    var dog: ListarAmigosClient?
    
    var viewModel: DetalheAmigoViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let service = ListarAmigosService()
//        viewModel = DetalheAmigoViewModel(amigo: service.listaDeCaesQueOServidorConhece()[0])
        viewModel?.delegate = self
        viewModel?.telaInicial()
    }

    @IBAction func caracteristicaRacaButtonAction(_ sender: Any) {
        
        
        
    }
    
    private func configuraFotoDoUsuario(nomeFoto: String?) {
        if let nomeFoto = viewModel?.validarFoto(nomeFoto: nomeFoto) {
            fotoCaoImageView.image = UIImage(named: nomeFoto)
        }
        let valorRadius = fotoCaoImageView.frame.size.height / 2.0
        fotoCaoImageView.layer.cornerRadius = valorRadius
        fotoCaoImageView.layer.borderWidth = 1
        fotoCaoImageView.layer.borderColor = UIColor.purple.cgColor
    }
}

extension DetalheAmigoViewController: DetalheAmigoViewModelDelegate {
    func configura(tela: ListarAmigosClient) {
        nomeCaoLabel.text = tela.obterNome()
        localizaCaoLabel.text = tela.obterLocalizaCao()
        descriCaoLabel.text = tela.obterDescriCao()
        configuraFotoDoUsuario(nomeFoto: tela.foto)
        
    }
    
}