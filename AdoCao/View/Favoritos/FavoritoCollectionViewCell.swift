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
    @IBOutlet weak var descricaoLabel: UILabel!
    @IBOutlet weak var localizacaoLabel: UILabel!
    @IBOutlet weak var idadeLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    var viewModel: FavoritoCellViewModel?
    
    func configura(vm: FavoritoCellViewModel) {
        self.viewModel = vm
        nomeLabel.text = vm.amigoFavorito.nome
        descricaoLabel.text = vm.amigoFavorito.descricao
        idadeLabel.text = "\(vm.amigoFavorito.idade) anos"
        localizacaoLabel.text = vm.amigoFavorito.localizacao
        configuraFoto(nomeFoto: vm.amigoFavorito.foto, imageView: fotoImageView)
        backView.roundCorners(cornerRadius: 20.0, cornerType: [.superiorEsquerdo, .inferiorDireito, .inferiorEsquerdo, .superiorDireito])
    }
    
}
extension FavoritoCollectionViewCell: FavoritoCellViewModelDelegate {
    func configuraCellFavorito(amigoFavorito: Amigo) {
        nomeLabel.text = amigoFavorito.nome
        descricaoLabel.text = amigoFavorito.descricao
        localizacaoLabel.text = amigoFavorito.localizacao
        idadeLabel.text = amigoFavorito.idade == 1 ? "\(amigoFavorito.idade) ano" : "\(amigoFavorito.idade) anos"
        configuraFoto(nomeFoto: amigoFavorito.foto, imageView: fotoImageView)
        backView.roundCorners(cornerRadius: 5.0, cornerType: [.superiorEsquerdo, .inferiorDireito])
//        self.backgroundView?.roundCorners(cornerRadius: 20.0, cornerType: [.superiorEsquerdo, .inferiorDireito])
    }
}
