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
    
    func configura(vm: FavoritoCellViewModel) {
        self.viewModel = vm
        nomeLabel.text = vm.amigoFavorito.nome
        configuraFoto(nomeFoto: vm.amigoFavorito.foto, imageView: fotoImageView)
    }
}
extension FavoritoCollectionViewCell: FavoritoCellViewModelDelegate {
    func configuraCellFavorito(amigoFavorito: Amigo) {
        nomeLabel.text = amigoFavorito.nome
        configuraFoto(nomeFoto: amigoFavorito.foto, imageView: fotoImageView)
        self.backgroundView?.roundCorners(cornerRadius: 50.0, cornerType: [.superiorEsquerdo, .inferiorDireito])
    }
}
