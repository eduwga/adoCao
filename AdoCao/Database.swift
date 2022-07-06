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
    var minhaLista: [Amigo] = []
    
    static var shared = DataBase()
    
    private init() {
        preencheAmigos()
        preencheUsuarios()
        preencheRacas()
    }
    
    private func preencheUsuarios() {
        
        let admin = Usuario(id: 1,
            nome: "Admin",
            email: "admin",
            senha: "123",
            cep: "---",
            cidade: "---",
            uf: "---",
            contato: "---")
        
        let marcia = Usuario(id: 2,
            nome: "Marcia Araújo",
            email: "marcia@projetoadocao.com.br",
            senha: "123",
            cep: "01001-000",
            cidade: "São Paulo",
            uf: "SP",
            contato: "(11) 91234-1234",
            foto: "Usuaria"
        )
        
        let juliana = Usuario(id: 3,
            nome: "Juliana Ferreira",
            email: "juliana@projetoadocao.com.br",
            senha: "123",
            cep: "01001-000",
            cidade: "São Paulo",
            uf: "SP",
            contato: "(11) 91234-1234",
            foto: "usrJuliana"
        )
        
        let andre = Usuario(id: 4,
            nome: "André Nepomuceno",
            email: "andre@projetoadocao.com.br",
            senha: "123",
            cep: "01001-000",
            cidade: "São Paulo",
            uf: "SP",
            contato: "(11) 91234-1234",
            foto: "usrAndre"
        )
        
        
        let marcos = Usuario(id: 5,
            nome: "Marcos Vinícius",
            email: "marcos@projetoadocao.com.br",
            senha: "123",
            cep: "01001-000",
            cidade: "São Paulo",
            uf: "SP",
            contato: "(11) 91234-1234",
            foto: "Usuario"
        )
        
        let thales = Usuario(id: 6,
            nome: "Thales Bernardes",
            email: "thales@projetoadocao.com.br",
            senha: "123",
            cep: "01001-000",
            cidade: "Bauru",
            uf: "SP",
            contato: "(11) 91234-1234",
            foto: "Usuario"
        )
        
        let eduardo = Usuario(id: 7,
            nome: "Eduardo Waked",
            email: "eduardo@projetoadocao.com.br",
            senha: "123",
            cep: "01001-000",
            cidade: "Ibiúna",
            uf: "SP",
            contato: "(11) 91234-1234",
            foto: "Usuario"
        )
        
        let murilo = Usuario(id: 8,
            nome: "Murilo Oliveira",
            email: "murilo@projetoadocao.com.br",
            senha: "123",
            cep: "01001-000",
            cidade: "Jundiaí",
            uf: "SP",
            contato: "",
            foto: "Usuario"
        )
        
        usuarios.append(admin)
        
        let amigoAndre = amigos.first { amigo in
            amigo.nome == "Jimmy"
        }
        if let amigoAndre = amigoAndre {
            andre.amigosCadastrados.append(amigoAndre)
        }
        usuarios.append(andre)
        
        let amigoMarcia = amigos.first { amigo in
            amigo.nome == "Nina"
        }
        if let amigoMarcia = amigoMarcia {
            marcia.amigosFavoritos.append(amigoMarcia)
        }
        usuarios.append(marcia)
        
        usuarios.append(juliana)
        
        let amigoMarcos = amigos.first { amigo in
            amigo.nome == "Sapecao"
        }
        if let amigoMarcos = amigoMarcos {
            marcos.amigosFavoritos.append(amigoMarcos)
        }
        usuarios.append(marcos)
        
        usuarios.append(thales)
        
        let amigoMurilo = amigos.first { amigo in
            amigo.nome == "Bilu"
        }
        if let amigoMurilo = amigoMurilo {
            murilo.amigosFavoritos.append(amigoMurilo)
        }
        usuarios.append(murilo)
        
        let amigoEduardo = amigos.first { amigo in
            amigo.nome == "Torresmo"
        }
        if let amigoEduardo = amigoEduardo {
            eduardo.amigosFavoritos.append(amigoEduardo)
        }
        usuarios.append(eduardo)
    }

    private func preencheAmigos() {
        amigos.append(
            Amigo(
                nome: "Bilu",
                idade: 2,
                raca: "Daschund",
                tutor: .init(id: 1, nome: "Teste1", email: "teste@teste.com.br", senha: "123", cep: "01001-001", cidade: "São Paulo", uf: "SP", contato: "(11) 1234-5678"),
                porte: .medio,
                foto: "Bilu",
                localizacao: "Sumaré - SP",
                descricao: "Vira-lata da ONG Adote um Cão"
            )
        )
        amigos.append(
            Amigo(
                nome: "Torresmo",
                idade: 1,
                raca: "Sharpei",
                tutor: .init(id: 2, nome: "Teste2", email: "teste@teste.com.br", senha: "123", cep: "01001-001", cidade: "São Paulo", uf: "SP", contato: "(11) 1234-5678"),
                porte: .medio,
                foto: "Torresmo",
                localizacao: "Goiania - GO",
                descricao: "Filhote de Sharpei, lindo fofo e teimoso"
            )
        )
        amigos.append(
            Amigo(
                nome: "Nina",
                idade: 2,
                raca: "Lhasa Apso",
                tutor: .init(id: 3, nome: "Teste3", email: "teste@teste.com.br", senha: "123", cep: "01001-001", cidade: "São Paulo", uf: "SP", contato: "(11) 1234-5678"),
                porte: .grande,
                foto: "",
                localizacao: "Piracicaba - SP",
                descricao: "Baixinha, esquentada mais de belos pelos"
            )
        )
        amigos.append(
            Amigo(
                nome: "Jimmy",
                idade: 1,
                raca: "Bull Terrier",
                tutor: .init(id: 4, nome: "Teste3", email: "teste@teste.com.br", senha: "123", cep: "01001-001", cidade: "São Paulo", uf: "SP", contato: "(11) 1234-5678"),
                porte: .grande,
                foto: "jimmy",
                localizacao: "São Paulo",
                descricao: "Web Celebridade"
            )
        )
        amigos.append(
            Amigo(
                nome: "Sapecao",
                idade: 4,
                raca: "Fox Paulistinha",
                tutor: .init(id: 4, nome: "Teste3", email: "teste@teste.com.br", senha: "123", cep: "01001-001", cidade: "São Paulo", uf: "SP", contato: "(11) 1234-5678"),
                porte: .medio,
                foto: "Sapecao",
                localizacao: "São José dos Campos",
                descricao: "Fox paulistinha, brincalhão e ligado no 220v"
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
