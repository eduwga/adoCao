//
//  UsuarioRequest.swift
//  AdoCao
//
//  Created by André N. dos Santos on 15/07/22.
//

import Foundation

// MARK: - UsuariosRequest
struct UsuariosRequest: Codable {
    let usuarioID: Int
    let nome, senha, email, cep: String
    let cidade, uf, contato, foto: String

    enum CodingKeys: String, CodingKey {
        case usuarioID = "usuarioId"
        case nome, senha, email, cep, cidade, uf, contato, foto
    }
}
