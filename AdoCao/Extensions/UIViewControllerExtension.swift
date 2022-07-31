//
//  ViewControllerExtension.swift
//  AdoCao
//
//  Created by André N. dos Santos on 03/07/22.
//

import Foundation
import UIKit
import Kingfisher

extension UIViewController {
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
        let colorTop =  UIColor(red: 250.0/255.0, green: 214.0/255.0, blue: 255/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 255.0/255.0, green: 94.0/255.0, blue: 58.0/255.0, alpha: 0.0).cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 0.35]
        gradientLayer.frame = self.view.bounds
                
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    func iniciaActivityIndicator(activityIndicatorView: UIActivityIndicatorView) {
        activityIndicatorView.isHidden = false
        activityIndicatorView.color = UIColor.purple
        activityIndicatorView.style = .large
        activityIndicatorView.startAnimating()
    }
    
    func finalizaActivityIndicator(activityIndicatorView: UIActivityIndicatorView) {
        activityIndicatorView.isHidden = true
        activityIndicatorView.stopAnimating()
    }
    
    func configuraFoto(nomeFoto: String?, imageView: UIImageView) {
        if let nomeFoto = nomeFoto {
            imageView.kf.setImage(with: URL(string: nomeFoto))
        }
        let valorRadius = imageView.frame.size.height / 2.0
        imageView.layer.cornerRadius = valorRadius
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.purple.cgColor
        imageView.contentMode = .scaleAspectFill
    }
    
    func exibeAlertaSimples(mensagem: String) {
        let alertaErroLogin = UIAlertController(title: "Aviso", message: mensagem, preferredStyle: UIAlertController.Style.alert)
        let botaoLogin = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alertaErroLogin.addAction(botaoLogin)
        self.present(alertaErroLogin, animated: true, completion: nil)
    }
}
