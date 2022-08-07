//
//  CadastrarAmigoViewModel.swift
//  AdoCao
//
//  Created by André N. dos Santos on 20/07/22.
//

import Foundation

enum RacasEnum: Int {
    case SRD = 0
    case outros = 50
}

protocol CadastrarAmigoViewModelDelegate {
    func cadastroEfetuado(resultado: Bool)
    func listaDeRacasAtualizada()
}

class CadastrarAmigoViewModel {
    private let fotoPlaceHolder = "iconDog"
    private let service = Service.shared
    private var amigo: Amigo?
    private var fotoAmigoURL: String?
    private var listaDeRacas: [String] = []
    var delegate: CadastrarAmigoViewModelDelegate?
    
    init() {
        buscarRacasDisponiveis()
    }

    func enviarFotoAmigoParaAPI(base64Image: String?) {
        guard let base64Image = base64Image else { return }
        guard let amigo = amigo else { return }

        service.postImage(id: amigo.id, base64Image: base64Image, endpoint: "cachorros") { imageUrl in
            guard let imageUrl = imageUrl else { return }
            self.fotoAmigoURL =  imageUrl
        } failure: { error in
            print("Erro no envio: " + error.localizedDescription)
        }
    }
    
    func getCaminhoDaFoto() -> String {
        return amigo?.foto ?? fotoPlaceHolder
    }
    
    func buscarRacasDisponiveis() {
        if listaDeRacas.count == 0 {
            service.loadBreeds(completion: { racas in
                self.listaDeRacas = racas.map({ raca in
                    raca.nome
                })
                self.delegate?.listaDeRacasAtualizada()
            }) { error in
                print(error.localizedDescription)
            }
        }
    }
    
    func obterRacas() -> [String] {
        return listaDeRacas
    }
    
    func cadastrarAmigo(nome: String?, idade: String?, raca: Int, descricao: String?, latitude: Double, longitude: Double) {
        //validar campos
        guard let nome = nome,
              let idadeString = idade,
              let idade = Int(idadeString),
              let descricao = descricao
        else { return }
        let fotoUrl: String = fotoAmigoURL ?? ""
        //Buscar raca
        let nomeRaca = listaDeRacas[raca]
        
        //Busca Usuario atual
        if let usuario = service.getLoggedUser() {
            
            //Cria objeto do amigo a ser cadastrado
            let amigo = Amigo(
                id: 0,
                nome: nome,
                idade: idade,
                raca: nomeRaca,
                tutor: usuario,
                porte: Porte.medio,
                foto: fotoUrl,
                localizacao: "\(usuario.cidade) - \(usuario.uf)",
                descricao: descricao,
                latitude: latitude,
                longitude: longitude
            )
            
            //salva o cadastro através do service
            service.addForAdoption(dog: amigo, completion: { resultado in
                //exibe o resultado
                self.delegate?.cadastroEfetuado(resultado: resultado)
            })
        }
    }
}
