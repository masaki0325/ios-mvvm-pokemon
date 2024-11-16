//
//  FavoriteListViewModel.swift
//  Pokemon
//
//  Created by Masaki Sato on 2024/11/15.
//

import Foundation
import RealmSwift
import Dependencies

@MainActor
class FavoriteListViewModel : ObservableObject {
    @Published var pokemons: [FavoritePokemon] = []
    @Published var uiState: FavoriteListUIState = .initial

    @Dependency(\.favoriteRepository) private var favoriteRepository: FavoriteRepositoryProtocol

    init() {
        fetch()
    }
    
    func fetch() {
        self.uiState = .loading
        self.pokemons =  favoriteRepository.fetchFavorites()
        self.uiState = .success
    }
    
    func deleteItem(at offsets: IndexSet) {
        offsets.forEach { index in
            let pokemon = pokemons[index]
            favoriteRepository.removeFavorite(pokemonId: pokemon.pokemonId)
        }
        fetch()
    }
    
    func search(query: String, id: String) {
        self.uiState = .loading
        
        var results =  favoriteRepository.fetchFavorites()

        // 名前でフィルタリング
        if !query.isEmpty {
            results = results.filter { $0.name.localizedCaseInsensitiveContains(query) }
        }

        // IDでフィルタリング
        if let idInt = Int(id), !id.isEmpty {
            results = results.filter { $0.pokemonId == idInt }
        }
        
        
        if (results.isEmpty) {
            self.uiState = .empty
        } else {
            self.uiState = .success
        }

        self.pokemons = results
    }
}

enum FavoriteListUIState {
    case initial
    case loading
    case success
    case empty
    case error(String)
}
