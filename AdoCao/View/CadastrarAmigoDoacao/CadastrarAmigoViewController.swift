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
    
    override func viewWillAppear(_ animated: Bool) {
        setGradientBackground()
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func botaoCadastrar(_ sender: Any) {
        
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
    
    private func configuraFotoDoUsuario(nomeFoto: String?) {
        if let nomeFoto =  nomeFoto {
            amigoImageView.image = UIImage(named: nomeFoto)
        }
        let valorRadius = amigoImageView.frame.size.height / 2.0
        amigoImageView.layer.cornerRadius = valorRadius
        amigoImageView.layer.borderWidth = 1
        amigoImageView.layer.borderColor = UIColor.purple.cgColor
    }
    
    private func iniciaActivityIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.color = UIColor.purple
        activityIndicator.style = .large
        activityIndicator.startAnimating()
    }
    
    private func finalizaActivityIndicator() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
}
