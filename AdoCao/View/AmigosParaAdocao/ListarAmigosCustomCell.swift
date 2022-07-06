//
//  ListarAmigosCustomCell.swift
//  AdoCao
//
//  Created by Eduardo Waked Gomes de Amorim on 31/05/22.
//

import UIKit

class ListarAmigosCustomCell: UITableViewCell {
    

    var cao: Amigo?
    var minhaLista: Amigo?
    var clickFavorito = false
    var viewModel: ListarAmigosCustomCellViewModel?
    
    
    @IBOutlet weak var imagemCaoImageView: UIImageView!
    @IBOutlet weak var nomeCaoLabel: UILabel!
    @IBOutlet weak var descriCaoLabel: UILabel!
    @IBOutlet weak var localizaCaoLabel: UILabel!
    
    @IBOutlet weak var favoritarImagemButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBAction func favoritarButtonAction(_ sender: Any) {
        guard let tapButtonFavorite = sender as? UIButton else { return }
        guard let estaNaLista = viewModel?.verificaSeAmigoEFavorito() else { return }
        
        if estaNaLista {
            viewModel?.removeFavoritos()
            tapButtonFavorite.setImage(UIImage(systemName: "heart"), for: .normal)
        } else {
            viewModel?.adicionaFavoritos()
            tapButtonFavorite.setImage(UIImage(systemName: "heart.fill")?.withTintColor(.yellow), for: .normal)
        }
        
    }
    
    func configura(vm: ListarAmigosCustomCellViewModel) {
        self.viewModel = vm
        imagemCaoImageView.image = UIImage(named: vm.getFoto())
        nomeCaoLabel.text = vm.getNome()
        descriCaoLabel.text = vm.getDescricao()
        localizaCaoLabel.text = vm.getLocalizacao()
    }
    
    }
  
    
    


