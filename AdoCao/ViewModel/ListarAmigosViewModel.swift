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
    
    //var amigos = ListarAmigosService().listaDeCaesQueOServidorConhece()
    let service = Service()
    var amigos: [Amigo] = []
    var delegate: ListarAmigosViewModelDelegate?
    
    init() {
        self.amigos = service.getDogsForAdoption()
    }
    
    func obterViewModelParaDetalhes(posicao: Any?) -> DetalheAmigoViewModel? {
        guard let posicao = posicao as? Int else {
            return nil
        }
        let amigo = amigos[posicao]
        let vm = DetalheAmigoViewModel(amigo: amigo)
        return vm
    }
    
    func obterQuantidadeDeAmigosParaAdocao() -> Int {
        return amigos.count
    }
    
    func obterAmigoPela(posicao: Int) -> Amigo {
        return amigos[posicao]
    }
}


