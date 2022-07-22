//
//  EnvioImagemResponse.swift
//  AdoCao
//
//  Created by André N. dos Santos on 19/07/22.
//

import Foundation

// MARK: - EnvioImagemResponse
struct EnvioImagemResponse: Codable {
    let sucesso: Bool
    let mensagem, imagemURL: String?
}
