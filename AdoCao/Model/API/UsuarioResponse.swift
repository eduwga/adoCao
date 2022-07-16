//
//  UsuarioResponse.swift
//  AdoCao
//
//  Created by André N. dos Santos on 15/07/22.
//

import Foundation

// MARK: - UsuarioResponse
struct UsuarioResponse: Codable {
    let usuarioID: Int
    let nome, email, cep, cidade: String
    let uf, contato, foto: String
    let ativo: Bool
    let amigosFavoritos: [AmigoParaAdocaoResponse]
    let amigosParaDoacao: [AmigoParaAdocaoResponse]

    enum CodingKeys: String, CodingKey {
        case usuarioID = "usuarioId"
        case nome, email, cep, cidade, uf, contato, foto, ativo, amigosFavoritos, amigosParaDoacao
    }
}

typealias UsuariosResponse = [UsuarioResponse]
