//
//  RacasViewModel.swift
//  AdoCao
//
//  Created by André N. dos Santos on 07/06/22.
//

import Foundation
import Kingfisher
import SwiftUI

protocol RacasViewModelDelegate {
    func listaDeRacasFoiModificada()
    func listaDeRacasFoiModificada(racas: [Raca])
}

class RacasViewModel {
    
    var delegate: RacasViewModelDelegate?
    var racasPesquisa: [Raca] = []
    var todasAsRacas: [Raca] = []
    var service = Service.shared
    var listaDeImagens: [Int: UIImage] = [:]

    init() {
        obterTodasAsRacas()
    }
    
//    func carregarImagensRacas() {
//        imagensCarregadas += 1
//        if imagensCarregadas == todasAsRacas.count {
//            self.delegate?.listaDeRacasFoiModificada()
//        }
//    }
    
    func carregarImagensRacas(posicao: Int, image: UIImage) {
        listaDeImagens[posicao] = image
        if listaDeImagens.count == todasAsRacas.count {
            self.delegate?.listaDeRacasFoiModificada()
        }
    }
    
    func buscarImagem(posicao: Int) -> UIImage? {
        return listaDeImagens[posicao]
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
    
    func obterURLImagem(raca:  Raca) -> URL? {
        let url = URL(string: raca.imagemURL)
        return url
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
    
    private func obterTodasAsRacas() {
        service.loadBreeds(completion: { racas in
            self.todasAsRacas = racas
            self.iniciaListaDeRacas()
            self.delegate?.listaDeRacasFoiModificada(racas: racas)
        }, failure: { error in
            print(error.localizedDescription)
        })
    }
}
