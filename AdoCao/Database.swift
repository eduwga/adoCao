//
//  Database.swift
//  AdoCao
//
//  Created by André N. dos Santos on 05/06/22.
//

import Foundation

public class DataBase {
    var usuarios: [Usuario] = []
    var amigos: [Amigo] = []
    var racas: [Raca] = []
    
    static var shared: DataBase = {
        let instance = DataBase()
        return instance
    }()
    
    private init() {
        preencheUsuarios()
        preencheAmigos()
        preencheRacas()
    }
    
    private func preencheUsuarios() {
        usuarios.append(
            Usuario(
                nome: "Marcia Araújo",
                email: "marcia@projetoadocao.com.br",
                cep: "01001-000",
                cidade: "São Paulo",
                uf: "SP",
                contato: "(11) 91234-1234"
            )
        )
        usuarios.append(
            Usuario(
                nome: "André Nepomunceno",
                email: "andre@projetoadocao.com.br",
                cep: "01001-000",
                cidade: "São Paulo",
                uf: "SP",
                contato: "(11) 91234-1234"
            )
        )
        usuarios.append(
            Usuario(
                nome: "Marcos Vinícius",
                email: "marcos@projetoadocao.com.br",
                cep: "01001-000",
                cidade: "São Paulo",
                uf: "SP",
                contato: "(11) 91234-1234"
            )
        )
        usuarios.append(
            Usuario(
                nome: "Thales Bernardes",
                email: "thales@projetoadocao.com.br",
                cep: "01001-000",
                cidade: "Bauru",
                uf: "SP",
                contato: "(11) 91234-1234"
            )
        )
        usuarios.append(
            Usuario(
                nome: "Eduardo Waked",
                email: "eduardo@projetoadocao.com.br",
                cep: "01001-000",
                cidade: "Ibiúna",
                uf: "SP",
                contato: "(11) 91234-1234"
            )
        )
        usuarios.append(
            Usuario(
                nome: "Murilo Oliveira",
                email: "murilo@projetoadocao.com.br",
                cep: "01001-000",
                cidade: "Jundiaí",
                uf: "SP",
                contato: ""
            )
        )
    }
    
    private func preencheAmigos() {
        amigos.append(
            Amigo(
                nome: "Bilu",
                idade: 2,
                raca: .init(nome: "Daschund"),
                tutor: .init(nome: "Teste1", email: "teste@teste.com.br", cep: "01001-001", cidade: "São Paulo", uf: "SP", contato: "(11) 1234-5678"),
                porte: .medio
            )
        )
        amigos.append(
            Amigo(
                nome: "Torresmo",
                idade: 1,
                raca: .init(nome: "Sharpei"),
                tutor: .init(nome: "Teste2", email: "teste@teste.com.br", cep: "01001-001", cidade: "São Paulo", uf: "SP", contato: "(11) 1234-5678"),
                porte: .medio
            )
        )
        amigos.append(
            Amigo(
                nome: "Nina",
                idade: 2,
                raca: .init(nome: "Lhasa Apso"),
                tutor: .init(nome: "Teste3", email: "teste@teste.com.br", cep: "01001-001", cidade: "São Paulo", uf: "SP", contato: "(11) 1234-5678"),
                porte: .grande
            )
        )
        amigos.append(
            Amigo(
                nome: "Bolinha",
                idade: 1,
                raca: .init(nome: "Bull Terrier"),
                tutor: .init(nome: "Teste3", email: "teste@teste.com.br", cep: "01001-001", cidade: "São Paulo", uf: "SP", contato: "(11) 1234-5678"),
                porte: .grande
            )
        )
        amigos.append(
            Amigo(
                nome: "Titi",
                idade: 4,
                raca: .init(nome: "SRD"),
                tutor: .init(nome: "Teste3", email: "teste@teste.com.br", cep: "01001-001", cidade: "São Paulo", uf: "SP", contato: "(11) 1234-5678"),
                porte: .grande
            )
        )
    }
    
    private func preencheRacas() {
        racas.append(Raca(nome: "SRD"))
        racas.append(Raca(nome: "Bull Terrier"))
        racas.append(Raca(nome: "Cocker"))
        racas.append(Raca(nome: "Daschund"))
        racas.append(Raca(nome: "Husky Siberiano"))
        racas.append(Raca(nome: "Border Collie"))
        racas.append(Raca(nome: "American Staffordshire Terrier"))
        racas.append(Raca(nome: "Lhasa Apso"))
        racas.append(Raca(nome: "Cane Corso"))
        racas.append(Raca(nome: "Dálmata"))
        racas.append(Raca(nome: "Sharpei"))
        racas.append(Raca(nome: "Bulldogue Inglês"))
        racas.append(Raca(nome: "Boxer"))
        racas.append(Raca(nome: "Pastor de Shetland"))
        racas.append(Raca(nome: "Poodle"))
        racas.append(Raca(nome: "Bernese da Montanha"))
    }
}
