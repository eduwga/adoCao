//
//  AmigoParaAdocaoRequest.swift
//  AdoCao
//
//  Created by André N. dos Santos on 15/07/22.
//

import Foundation

// MARK: - CachorroParaAdocaoRequest
struct AmigoParaAdocaoRequest: Codable {
    let nome: String
    let idade: Int
    let tamanho: Int
    let imagem: String
    let descricao: String
    let caracteristicas: String
    let nomeRaca: String
    let latitude: Double
    let longitude: Double
    let tutorID: Int
    let racaID: Int

    enum CodingKeys: String, CodingKey {
        case nome, idade, tamanho, imagem, descricao, caracteristicas, nomeRaca, latitude, longitude
        case tutorID = "tutorId"
        case racaID = "racaId"
    }
    
    init(amigo: Amigo) {
        nome = amigo.nome
        idade =  amigo.idade
        tamanho = amigo.porte.rawValue
        imagem = ""
        descricao = amigo.descricao
        caracteristicas = ""
        nomeRaca = amigo.raca
        latitude =  0
        longitude = 0
        tutorID = amigo.tutor.id
        racaID = 0
    }
}
