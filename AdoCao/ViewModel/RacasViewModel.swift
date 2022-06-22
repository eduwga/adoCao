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
    var racasPesquisa: [Raca] = []
    var todasAsRacas: [Raca] = []
    var service = Service()
    
    init() {
        obterTodasAsRacas()
    }
    
    private func obterTodasAsRacas() {
        service.loadBreeds(completion: { racas in
            self.todasAsRacas = racas
            self.iniciaListaDeRacas()
        }, failure: { error in
            print(error.localizedDescription)
        })
    }
    
    func iniciaListaDeRacas() {
        self.racasPesquisa = todasAsRacas
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
            let racasSelecionadas = self.todasAsRacas.filter({ raca in
                raca.nome.lowercased().contains(nomePesquisado.lowercased())
            })
            racasPesquisa = racasSelecionadas
        }
        delegate?.listaDeRacasFoiModificada()
    }
    
    func selecionouCelula(posicao: Any?) -> DetalhesRacaViewModel? {
        guard let posicao = posicao as? Int else { return nil }
        let racaSelecionada = racasPesquisa[posicao]
        let detalhesRacaVM = DetalhesRacaViewModel(raca: racaSelecionada)
        return detalhesRacaVM
    }
}
