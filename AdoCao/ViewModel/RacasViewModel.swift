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
        iniciaListaDeRacas()
    }
    
    func obterTotalDeRacas() -> Int {
        return racasPesquisa.count
    }
    
    func obterRaca(posicao: Int) -> Raca {
        return racasPesquisa[posicao]
    }
    
    func pesquisarRacaPorNome(nomePesquisado: String) {
        if nomePesquisado == "" {
            iniciaListaDeRacas()
        }
        else {
            let racasSelecionadas = dataBase.racas.filter({ raca in
                raca.nome.lowercased().contains(nomePesquisado.lowercased())
            })
            racasPesquisa = racasSelecionadas
        }
        delegate?.listaDeRacasFoiModificada()
    }
    
    func selecionouCelula(posicao: Any?) -> AndreDetalhesRacaViewModel? {
        guard let posicao = posicao as? Int else { return nil }
        let racaSelecionada = racasPesquisa[posicao]
        let detalhesRacaVM = AndreDetalhesRacaViewModel(raca: racaSelecionada)
        return detalhesRacaVM
    }
    private func iniciaListaDeRacas() {
        racasPesquisa = dataBase.racas
    }
}
