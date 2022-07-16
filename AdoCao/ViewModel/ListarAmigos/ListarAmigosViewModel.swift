//
//  ListarAmigosViewModel.swift
//  AdoCao
//
//  Created by Eduardo Waked Gomes de Amorim on 31/05/22.
//

import Foundation
import UIKit

protocol ListarAmigosViewModelDelegate {
    func listaDeAmigosFoiAlterada()
}

class ListarAmigosViewModel {
    

    let service = Service.shared
    var amigos: [Amigo] = []
    var favoritos = [Int: Bool]()
    var minhaLista: [Amigo] = []


    var delegate: ListarAmigosViewModelDelegate?
    
    init() {
        service.getDogsForAdoption(completion: { amigos in
            self.amigos = amigos
            self.delegate?.listaDeAmigosFoiAlterada()
        })
    }
    
    func obterViewModelParaDetalhes(posicao: Any?) -> DetalheAmigoViewModel {
        let posicao = posicao as! Int 
        let amigo = amigos[posicao]
        let vm = DetalheAmigoViewModel(amigo: amigo)
        return vm
    }
    
    func obterViewModelParaCell(posicao: Any?, segmento: Int) -> ListarAmigosCustomCellViewModel? {
        guard let posicao = posicao as? Int else {
            return nil
        }
        let amigo = obterAmigoPela(posicao: posicao, segmento: segmento)
        let vm = ListarAmigosCustomCellViewModel(cao: amigo)
        return vm
    }
    
    func obterQuantidadeDeAmigos(segmento: Int) -> Int {
        switch segmento {
        case 0:
            return amigos.count
        case 1:
            return minhaLista.count
        default:
            return 0
    }
    }
    
    func obterAmigoPela(posicao: Int, segmento: Int) -> Amigo? {
        switch segmento {
        case 0:
            return amigos[posicao]
        case 1:
            return minhaLista[posicao]
        default:
            return nil
    }
    
}
}



