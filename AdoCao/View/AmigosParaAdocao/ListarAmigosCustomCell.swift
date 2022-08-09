//
//  ListarAmigosCustomCell.swift
//  AdoCao
//
//  Created by Eduardo Waked Gomes de Amorim on 31/05/22.
//

import UIKit

class ListarAmigosCustomCell: UITableViewCell {
    


    var clickFavorito = false
    var viewModel: ListarAmigosCustomCellViewModel?
    
    
    @IBOutlet weak var imagemCaoImageView: UIImageView!
    @IBOutlet weak var nomeCaoLabel: UILabel!
    @IBOutlet weak var descriCaoLabel: UILabel!
    @IBOutlet weak var localizaCaoLabel: UILabel!
    
    @IBOutlet weak var favoritarImagemButton: UIButton!
    
    @IBAction func favoritarButtonAction(_ sender: Any) {
        viewModel?.verificaSeAmigoEFavorito()
    }
    
    func configura(vm: ListarAmigosCustomCellViewModel) {
        self.viewModel = vm
        
        vm.delegate = self
        nomeCaoLabel.text = vm.getNome()
        descriCaoLabel.text = vm.getDescricao()
        localizaCaoLabel.text = vm.getLocalizacao()
        configuraFoto(nomeFoto: vm.getFoto(), imageView: imagemCaoImageView)
        
        if vm.caoIsFavorite() {
            self.favoritarImagemButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            self.favoritarImagemButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
}

extension ListarAmigosCustomCell: ListarAmigosCustomCellViewModelDelegate {
    func amigoFoiAdicionado() {
        self.favoritarImagemButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
    }
    
    func amigoFoiRemovido() {
        self.favoritarImagemButton.setImage(UIImage(systemName: "heart"), for: .normal)
    }
    
    func exibeMensagemResposta(sucesso: Bool) {
        if sucesso {
            self.favoritarImagemButton.setImage(UIImage(systemName: "heart"), for: .normal)
        } else {
            self.favoritarImagemButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }        
    }
}
  
    
    


