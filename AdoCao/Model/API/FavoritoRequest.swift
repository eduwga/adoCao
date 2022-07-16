//
//  FavoritoRequest.swift
//  AdoCao
//
//  Created by André N. dos Santos on 15/07/22.
//

import Foundation

// MARK: - FavoritosRequest
struct FavoritoRequest: Codable {
    let cachorroID, usuarioID: Int

    enum CodingKeys: String, CodingKey {
        case cachorroID = "cachorroId"
        case usuarioID = "usuarioId"
    }
}
