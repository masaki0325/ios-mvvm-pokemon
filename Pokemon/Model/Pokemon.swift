//
//  Pokemon.swift
//  Pokemon
//
//  Created by Masaki Sato on 2024/11/11.
//

import Foundation

struct Pokemon: Decodable, Equatable, Identifiable {
    let id: UUID = UUID()
    let name: String
    let url: String
    
    private enum CodingKeys: String, CodingKey {
        case name
        case url
    }
    
    var pokemonIdString: String {
        return URL(string: url)?.lastPathComponent ?? ""
    }
    
    var pokemonId: Int {
        return Int(pokemonIdString) ?? 0
    }
}

struct PokemonListResponse : Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Pokemon]
}
