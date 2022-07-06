//
//  LoginResultDTO.swift
//  AdoCao
//
//  Created by André N. dos Santos on 26/06/22.
//

//   let loginResult = try? newJSONDecoder().decode(LoginResult.self, from: jsonData)

import Foundation

// MARK: - LoginResult
struct LoginResult: Codable {
    let user: UsuarioAPI
    let token: String
}

struct LoginFailure: Codable {
    let message: String
}
