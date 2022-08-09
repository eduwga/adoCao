//
//  AmigoParaAdocaoResponse.swift
//  AdoCao
//
//  Created by André N. dos Santos on 15/07/22.
//

import Foundation

// MARK: - Amigos
struct AmigoParaAdocaoResponse: Codable {
    let id: Int
    let nome: String
    let idade:Int
    let tamanho: Int
    let imagemURL: String
    let descricao: String
    let caracteristicas: String
    let racaID: Int
    let racaNome: String
    let latitude: Double
    let longitude: Double
    let tutorID: Int
    let tutorNome: String
    let tutorEndereco: String
    let isFavorite: Bool
    
    enum CodingKeys: String, CodingKey {
        case id, nome, idade, tamanho, imagemURL, descricao, caracteristicas
        case racaID = "racaId"
        case racaNome, latitude, longitude
        case tutorID = "tutorId"
        case tutorNome, tutorEndereco
        case isFavorite
    }
}

typealias AmigosParaAdocaoResponse = [AmigoParaAdocaoResponse]
