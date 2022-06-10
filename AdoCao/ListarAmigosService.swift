//
//  ListarAmigosService.swift
//  AdoCao
//
//  Created by Eduardo Waked Gomes de Amorim on 31/05/22.
//

import Foundation
import UIKit

class ListarAmigosService {
    
    public var listaDeCaes: [ListarAmigosClient] = []
    
    init() {
        listaDeCaesQueOServidorConhece()
    }
    
     public func listaDeCaesQueOServidorConhece() -> [ListarAmigosClient] {
        
        
         listaDeCaes.append(ListarAmigosClient(
                nome: "Sapecao",
                descricao: "Fox paulistinha, brincalhão e ligado no 220v",
                localizacao: "São José dos Campos",
                foto: "Sapecao"))
         listaDeCaes.append(ListarAmigosClient(
                nome: "Torresmo",
                descricao: "Filhote de Sharpei, lindo fofo e teimoso",
                localizacao: "Goiania - GO",
                foto: "Torresmo"))
         listaDeCaes.append(ListarAmigosClient(
                nome: "Bilu",
                descricao: "Vira-lata da ONG Adote um Cão",
                localizacao: "Sumaré - SP",
                foto: "Bilu"))

         
         return listaDeCaes
     }
    
    func pegarCaoPelo(_ nome: String) -> ListarAmigosClient? {
        let dogs = listaDeCaesQueOServidorConhece()
        
        for dog in dogs {
            if dog.nome == nome {
                return dog
            }
        }
        return nil
    }
}
