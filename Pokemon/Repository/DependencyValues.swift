//
//  DependencyValues.swift
//  Pokemon
//
//  Created by Masaki Sato on 2024/11/11.
//

import Dependencies

extension DependencyValues {
    var pokemonListRepository: PokemonListRepositoryProtocol {
        get { self[PokemonListRepositoryProtocolKey.self] }
        set { self[PokemonListRepositoryProtocolKey.self] = newValue }
    }
    
    private enum PokemonListRepositoryProtocolKey: DependencyKey {
        static let liveValue: PokemonListRepositoryProtocol = PokemonListRepository()
    }
}

extension DependencyValues {
    var favoriteRepository: FavoriteRepositoryProtocol {
        get { self[FavoriteRepositoryProtocolKey.self] }
        set { self[FavoriteRepositoryProtocolKey.self] = newValue }
    }
    
    private enum FavoriteRepositoryProtocolKey: DependencyKey {
        static let liveValue: FavoriteRepositoryProtocol = FavoriteRepository()
    }
}
