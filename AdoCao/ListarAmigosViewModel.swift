//
//  ListarAmigosViewModel.swift
//  AdoCao
//
//  Created by Eduardo Waked Gomes de Amorim on 31/05/22.
//

import Foundation

protocol ListarAmigosViewModelDelegate {
    
}

class ListarAmigosViewModel {
    
    var amigos = ListarAmigosService().listaDeCaesQueOServidorConhece()
    
    var delegate: ListarAmigosViewModelDelegate?
    
    func obterViewModelParaDetalhes(posicao: Any?) -> DetalheAmigoViewModel? {
        guard let posicao = posicao as? Int else {
            return nil
        }
        
        let vm = DetalheAmigoViewModel(amigo: amigos[posicao])
        return vm

    }
    
}


