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
                contato: "(11) 91234-1234",
                foto: "Usuaria"
            )
        )
        usuarios.append(
            Usuario(
                nome: "André Nepomuceno",
                email: "andre@projetoadocao.com.br",
                cep: "01001-000",
                cidade: "São Paulo",
                uf: "SP",
                contato: "(11) 91234-1234",
                foto: "Usuario"
            )
        )
        usuarios.append(
            Usuario(
                nome: "Marcos Vinícius",
                email: "marcos@projetoadocao.com.br",
                cep: "01001-000",
                cidade: "São Paulo",
                uf: "SP",
                contato: "(11) 91234-1234",
                foto: "Usuario"
            )
        )
        usuarios.append(
            Usuario(
                nome: "Thales Bernardes",
                email: "thales@projetoadocao.com.br",
                cep: "01001-000",
                cidade: "Bauru",
                uf: "SP",
                contato: "(11) 91234-1234",
                foto: "Usuario"
            )
        )
        usuarios.append(
            Usuario(
                nome: "Eduardo Waked",
                email: "eduardo@projetoadocao.com.br",
                cep: "01001-000",
                cidade: "Ibiúna",
                uf: "SP",
                contato: "(11) 91234-1234",
                foto: "Usuario"
            )
        )
        usuarios.append(
            Usuario(
                nome: "Murilo Oliveira",
                email: "murilo@projetoadocao.com.br",
                cep: "01001-000",
                cidade: "Jundiaí",
                uf: "SP",
                contato: "",
                foto: "Usuario"
            )
        )
    }
    
    private func preencheAmigos() {
        amigos.append(
            Amigo(
                nome: "Bilu",
                idade: 2,
                raca: "Daschund",
                tutor: .init(nome: "Teste1", email: "teste@teste.com.br", cep: "01001-001", cidade: "São Paulo", uf: "SP", contato: "(11) 1234-5678"),
                porte: .medio,
                foto: "Bilu"
            )
        )
        amigos.append(
            Amigo(
                nome: "Torresmo",
                idade: 1,
                raca: "Sharpei",
                tutor: .init(nome: "Teste2", email: "teste@teste.com.br", cep: "01001-001", cidade: "São Paulo", uf: "SP", contato: "(11) 1234-5678"),
                porte: .medio,
                foto: "Torresmo"
            )
        )
        amigos.append(
            Amigo(
                nome: "Nina",
                idade: 2,
                raca: "Lhasa Apso",
                tutor: .init(nome: "Teste3", email: "teste@teste.com.br", cep: "01001-001", cidade: "São Paulo", uf: "SP", contato: "(11) 1234-5678"),
                porte: .grande,
                foto: ""
            )
        )
        amigos.append(
            Amigo(
                nome: "Bolinha",
                idade: 1,
                raca: "Bull Terrier",
                tutor: .init(nome: "Teste3", email: "teste@teste.com.br", cep: "01001-001", cidade: "São Paulo", uf: "SP", contato: "(11) 1234-5678"),
                porte: .grande,
                foto: ""
            )
        )
        amigos.append(
            Amigo(
                nome: "Sapecao",
                idade: 4,
                raca: "Fox Paulistinha",
                tutor: .init(nome: "Teste3", email: "teste@teste.com.br", cep: "01001-001", cidade: "São Paulo", uf: "SP", contato: "(11) 1234-5678"),
                porte: .medio,
                foto: "Sapecao"
            )
        )
    }
    
    private func preencheRacas() {
        racas.append(Raca(nome: "SRD - Sem Raça Definida", foto: "viralata"))
        racas.append(Raca(nome: "Bull Terrier", foto: "bullTerrier"))
        racas.append(Raca(nome: "Cocker", foto: "cockerSpaniel"))
        racas.append(Raca(nome: "Daschund", foto: "dachshund"))
        racas.append(Raca(nome: "Husky Siberiano", foto: "huskySiberiano"))
        racas.append(Raca(nome: "Border Collie", foto: "borderCollie"))
        racas.append(Raca(nome: "American Staffordshire Terrier", foto: "americanStaffordshire"))
        racas.append(Raca(nome: "Lhasa Apso", foto: "lhasaApso"))
        racas.append(Raca(nome: "Cane Corso", foto: "caneCorso"))
        racas.append(Raca(nome: "Dálmata", foto: "dalmata"))
        racas.append(Raca(nome: "Sharpei", foto: "sharpei"))
        racas.append(Raca(nome: "Bulldogue Inglês", foto: "bulldogueIngles"))
        racas.append(Raca(nome: "Boxer", foto: "boxer"))
        racas.append(Raca(nome: "Pastor de Shetland", foto: "pastorShetland"))
        racas.append(Raca(nome: "Poodle", foto: "poodle"))
        racas.append(Raca(nome: "Bernese da Montanha", foto: "bernesseDaMontanha"))
        racas.append(Raca(nome: "Fox Paulistinha", foto: "foxPaulistinha"))
    }
}
