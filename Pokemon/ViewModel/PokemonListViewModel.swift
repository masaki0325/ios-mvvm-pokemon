//
//  PokemonListViewModel.swift
//  Pokemon
//
//  Created by Masaki Sato on 2024/11/11.
//

import SwiftUI
import Combine
import SwiftData
import Dependencies

enum UIState {
    case initial
    case loading
    case success
    case error(String)
}

@MainActor
class PokemonListViewModel: ObservableObject {
    @Published var pokemons: [Pokemon] = []
    @Published var uiState: UIState = .initial
    
    @Dependency(\.pokemonListRepository) private var listRepository: PokemonListRepositoryProtocol
    @Dependency(\.favoriteRepository) private var favoriteRepository: FavoriteRepositoryProtocol

    init() {
        Task {
            await fetch()
        }
    }
    
    func fetch() async {
        self.uiState = .loading
        do {
            let pokemons = try await listRepository.fetchPokemonList()
            self.pokemons = pokemons
            self.uiState = .success
        } catch {
            self.uiState = .error(error.localizedDescription)
        }
    }
    
    func toggleFavorite(pokemon: Pokemon) {
        let isFavorite = favoriteRepository.fetchFavorites().contains(where: { $0.pokemonId == pokemon.pokemonId })
        if isFavorite {
            favoriteRepository.removeFavorite(pokemonId: pokemon.pokemonId)
        } else {
            favoriteRepository.addFavorite(pokemonId: pokemon.pokemonId, name: pokemon.name)
        }
    }
}
