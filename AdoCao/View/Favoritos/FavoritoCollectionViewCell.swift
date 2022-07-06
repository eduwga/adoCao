//
//  FavoritoCollectionViewCell.swift
//  AdoCao
//
//  Created by André N. dos Santos on 11/06/22.
//

import UIKit

class FavoritoCollectionViewCell: UICollectionViewCell {
    

    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var fotoImageView: UIImageView!
    var viewModel: FavoritoCellViewModel?
    
    private func configuraFotoDoUsuario(nomeFoto: String?) {
        if let nomeFoto = viewModel?.validarFoto(nomeFoto: nomeFoto) {
            fotoImageView.image = UIImage(named: nomeFoto)
        }
        let menorLado = fotoImageView.frame.size.height < fotoImageView.frame.size.width ? fotoImageView.frame.size.height : fotoImageView.frame.size.width
        fotoImageView.frame.size.height = menorLado
        fotoImageView.frame.size.width = menorLado
        fotoImageView.bounds.size.height = menorLado
        fotoImageView.bounds.size.width = menorLado
        let valorRadius = menorLado / 2.0
        fotoImageView.layer.cornerRadius = valorRadius
        fotoImageView.layer.borderWidth = 1
        fotoImageView.layer.borderColor = UIColor.purple.cgColor
    }
    
    func configura(vm: FavoritoCellViewModel) {
        self.viewModel = vm
        nomeLabel.text = vm.amigoFavorito.nome
        configuraFotoDoUsuario(nomeFoto: vm.amigoFavorito.foto)
//        containerView.layer.shadowOffset = .init(width: -1, height: -3)
//        containerView.layer.shadowColor = UIColor.gray.cgColor
//        containerView.layer.shadowOpacity = 0.7
//        containerView.clipsToBounds = false
//        containerView.roundCorners(cornerRadius: 30, cornerType: [.inferiorDireito,.superiorEsquerdo,.superiorDireito,.inferiorEsquerdo])
    }
}
extension FavoritoCollectionViewCell: FavoritoCellViewModelDelegate {
    func configuraCellFavorito(amigoFavorito: Amigo) {
        nomeLabel.text = amigoFavorito.nome
        configuraFotoDoUsuario(nomeFoto: amigoFavorito.foto)
        self.backgroundView?.roundCorners(cornerRadius: 50.0, cornerType: [.superiorEsquerdo, .inferiorDireito])
    }
}
