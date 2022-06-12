//
//  ListarAmigosCustomCell.swift
//  AdoCao
//
//  Created by Eduardo Waked Gomes de Amorim on 31/05/22.
//

import UIKit

class ListarAmigosCustomCell: UITableViewCell {

    var cao: Amigo?
    
    @IBOutlet weak var imagemCaoImageView: UIImageView!
    @IBOutlet weak var nomeCaoLabel: UILabel!
    @IBOutlet weak var descriCaoLabel: UILabel!
    @IBOutlet weak var localizaCaoLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    public func configura(cao: Amigo) {
        self.cao = cao
        imagemCaoImageView.image = UIImage(named: cao.foto)
        nomeCaoLabel.text = cao.nome
        descriCaoLabel.text = cao.descricao
        localizaCaoLabel.text = cao.localizacao
    }

}


