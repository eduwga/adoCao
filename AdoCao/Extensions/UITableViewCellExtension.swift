//
//  UITableViewCellExtension.swift
//  AdoCao
//
//  Created by André N. dos Santos on 07/07/22.
//

import Foundation
import UIKit
extension UITableViewCell {
    func configuraFoto(nomeFoto: String?, imageView: UIImageView) {
        if let nomeFoto = nomeFoto {
            imageView.kf.setImage(with: URL(string: nomeFoto))
        }
        let valorRadius = imageView.frame.size.width / 6.0
        imageView.layer.cornerRadius = valorRadius
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.purple.cgColor
        imageView.contentMode = .scaleAspectFill
    }
}
