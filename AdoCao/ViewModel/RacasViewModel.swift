//
//  RacasViewModel.swift
//  AdoCao
//
//  Created by André N. dos Santos on 07/06/22.
//

import Foundation

protocol RacasViewModelDelegate {
    func listaDeRacasFoiModificada()
}

class RacasViewModel {
    
    var delegate: RacasViewModelDelegate?
    var dataBase = DataBase.shared
    var racasPesquisa: [Raca] = []
    
    init() {
        racasPesquisa = dataBase.racas
    }
    
    func obterTotalDeRacas() -> Int {
        return racasPesquisa.count
    }
    
    func obterRaca(posicao: Int) -> Raca {
        return racasPesquisa[posicao]
    }
    
    func pesquisarRacaPorNome(nome: String) {
        let racasSelecionadas = dataBase.racas.filter({ raca in
            raca.nome.contains(nome)
        })
        racasPesquisa = racasSelecionadas
        
    }
    
    func selecionouCelula(posicao: Any?) -> DetalhesRacaViewModel? {
        guard let posicao = posicao as? Int else { return nil }
        let racaSelecionada = racasPesquisa[posicao]
        let detalhesRacaVM = DetalhesRacaViewModel(raca: racaSelecionada)
        return detalhesRacaVM
    }
}
