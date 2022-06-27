//
//  BoasVindasViewModel.swift
//  AdoCao
//
//  Created by André N. dos Santos on 14/06/22.
//

import Foundation

protocol BoasVindasViewModelDelegate {
    func atualizaLogin(devePermitir: Bool, usuario: Usuario?)
}

class BoasVindasViewModel {
    
    private let service = Service.shared
    var delegate: BoasVindasViewModelDelegate?
    
    ///Buscar do CoreData e validar
//    func validaLogin(email: String, senha: String) {
//        service.loginAsync(email: email, password: senha,completion: { usuario in
//            if usuario == nil {
//                self.delegate?.atualizaLogin(devePermitir: false, usuario: nil)
//            }
//            else {
//                self.delegate?.atualizaLogin(devePermitir: true, usuario: usuario)
//            }
//        })
//    }
    
}
