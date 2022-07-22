//
//  EditarUsuarioViewModel.swift
//  AdoCao
//
//  Created by André N. dos Santos on 08/06/22.
//

import Foundation

protocol EditarUsuarioViewModelDelegate {
    
}

class EditarUsuarioViewModel {
    
    var delegate: EditarUsuarioViewModelDelegate?
    
    private var usuario: Usuario
    private let fotoPadrao = "customPerson"
    private let service = Service.shared
    
    init(usuario: Usuario) {
        self.usuario = usuario
    }
    
    func validarFoto(nomeFoto: String?) -> String {
        if let nomeFoto = nomeFoto {
            if nomeFoto != ""{
                return nomeFoto
            }
        }
        return fotoPadrao
    }
    
    func getUsuario() -> Usuario {
        return self.usuario
    }
    
    func enviarFotoUsuarioParaAPI(base64Image: String?) {
        guard let base64Image = base64Image else { return }

        service.postImage(id: usuario.id, base64Image: base64Image, endpoint: "usuarios") { imageUrl in
            guard let imageUrl = imageUrl else { return }
            print("O retorno foi: " + imageUrl)
        } failure: { error in
            print("Erro no envio: " + error.localizedDescription)
        }
    }
}
