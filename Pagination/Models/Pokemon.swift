//
//  Pokemon.swift
//  Pagination
//
//  Created by epismac on 16/10/24.
//

import Foundation

//Modelo de pokemon para almacenar los datos de la API
struct Pokemon: Identifiable, Decodable, Equatable {
    let id: UUID = UUID()
    let name: String
    let url: String
    
    static func ==(lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.name == rhs.name && lhs.url == rhs.url
    }
}

//Respuesta de la API
struct PokemonResponse: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Pokemon]
}
