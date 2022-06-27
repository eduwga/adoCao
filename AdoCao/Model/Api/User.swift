//
//  User.swift
//  AdoCao
//
//  Created by André N. dos Santos on 26/06/22.
//

import Foundation

// MARK: - User

struct UserLogin: Codable {
    var email: String
    var senha: String
}

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let usuario = try? newJSONDecoder().decode(Usuario.self, from: jsonData)

// MARK: - Usuario
struct UsuarioAPI: Codable {
    let id: Int?
    let email, senha, imagemURL: String
    let ativo: Bool
    let ultimoAcesso, funcao: String
    let tutor: Tutor

    enum CodingKeys: String, CodingKey {
        case id, email, senha, imagemURL, ativo, ultimoAcesso, funcao
        case tutor
    }
}

// MARK: - Tutor
struct Tutor: Codable {
    let id: Int
    let nome, cpf, telefone, celular: String
    let ativo: Bool
    let endereco: Endereco
    let amigosDoacao: [AmigosDoacao]
}

// MARK: - AmigosDoacao
struct AmigosDoacao: Codable {
    let id: Int
    let nome: String
    let idade, tamanho: Int
    let imagemURL, descricao, caracteristicas: String
    let ativo: Bool
    let adotadoEm: String
    let localizacao: Endereco
    let tutor: String
}

// MARK: - Endereco
struct Endereco: Codable {
    let logradouro: String
    let numero: String
    let complemento: String
    let bairro: String
    let cidade: String
    let uf: String
    let cep: String
}
