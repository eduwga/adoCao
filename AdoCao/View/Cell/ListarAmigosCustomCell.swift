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
    var service = Service()
    
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
        let usuarioAtual = service.getLoggedUser()
        let estaNaLista = verificaSeAmigoEFavorito(amigoSelecionado: cao)
        guard let cao = cao else {
            return
        }

        if estaNaLista {
            usuarioAtual?.amigosFavoritos.removeAll(where: { amigo in
                amigo.nome == cao.nome
            })
            tapButtonFavorite.setImage(UIImage(systemName: "heart"), for: .normal)
        } else {
            usuarioAtual?.amigosFavoritos.append(cao)
            tapButtonFavorite.setImage(UIImage(systemName: "heart.fill")?.withTintColor(.yellow), for: .normal)
        }
        
    }
    func verificaSeAmigoEFavorito(amigoSelecionado: Amigo?) -> Bool {
            let usuarioAtual = service.getLoggedUser()
            
            guard let usuarioAtual = usuarioAtual else {
                return false
            }

            return usuarioAtual.amigosFavoritos.contains(where: { amigo in
                amigo.nome == amigoSelecionado?.nome
            })
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
    
//    @objc func clickImage(tapGestureRecognizer: UITapGestureRecognizer) {
//        let favoritar = tapGestureRecognizer.view as! UIImageView
//

    }
  
    
    



