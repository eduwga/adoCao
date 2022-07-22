//
//  CadastrarAmigoViewModel.swift
//  AdoCao
//
//  Created by André N. dos Santos on 20/07/22.
//

import Foundation

protocol CadastrarAmigoViewModelDelegate {
    
}

class CadastrarAmigoViewModel {
    
    let service = Service.shared
    var delegate: CadastrarAmigoViewModelDelegate?
    var amigo: Amigo?
    
    func enviarFotoAmigoParaAPI(base64Image: String?) {
        guard let base64Image = base64Image else { return }
        guard let amigo = amigo else { return }

        service.postImage(id: amigo.id, base64Image: base64Image, endpoint: "cachorros") { imageUrl in
            guard let imageUrl = imageUrl else { return }
            print("O retorno foi: " + imageUrl)
        } failure: { error in
            print("Erro no envio: " + error.localizedDescription)
        }
    }
    
    func getCaminhoDaFoto() -> String? {
        return amigo?.foto
    }
}
