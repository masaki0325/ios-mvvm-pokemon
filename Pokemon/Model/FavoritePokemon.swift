//
//  FavoritePokemon.swift
//  Pokemon
//
//  Created by Masaki Sato on 2024/11/11.
//

import Foundation
import RealmSwift

class FavoritePokemon: Object, Identifiable {
    @Persisted(primaryKey: true) var _id: UUID = UUID()
    @Persisted var pokemonId: Int
    @Persisted var name: String
    
    convenience init(pokemonId: Int, name: String) {
        self.init()
        self.pokemonId = pokemonId
        self.name = name
    }
}
