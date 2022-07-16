//
//  LoginResponse.swift
//  AdoCao
//
//  Created by André N. dos Santos on 15/07/22.
//

import Foundation

struct LoginResponse: Codable {
    let user: UsuarioResponse
    let token: String
}
