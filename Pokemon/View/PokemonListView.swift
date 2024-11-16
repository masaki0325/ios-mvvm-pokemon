//
//  PokemonListView.swift
//  Pokemon
//
//  Created by Masaki Sato on 2024/11/11.
//

import SwiftUI
import SwiftData

struct PokemonListView: View {
    
    @ObservedObject var viewModel: PokemonListViewModel

    var body: some View {
        NavigationStack {
            VStack {
                switch viewModel.uiState {
                case .initial:
                    ProgressView()
                case .loading:
                    ProgressView()
                case .success:
                    ListView(
                        pokemons: viewModel.pokemons,
                        toggleFavorite: { pokemon in
                            Task {
                                viewModel.toggleFavorite(pokemon: pokemon)
                            }
                        }
                    )
                case .error(let message):
                    ErrorView(message: message, retry: {
                        Task {
                            await viewModel.fetch()
                        }
                    })
                }
            }
            .navigationTitle("Pokemon List")
        }
    }
}


private struct ListView: View {
    let pokemons: [Pokemon]
    let toggleFavorite: (Pokemon) -> Void

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(pokemons) { pokemon in
                    ListItemView(
                        pokemon: pokemon,
                        didTapItem: { pokemon in
                            print("Tapped on \(pokemon.name)")
                        },
                        toggleFavorite: { pokemon in
                            toggleFavorite(pokemon)
                        }
                    )
                }
            }
        }
    }
    
}

private struct ListItemView: View {
    let pokemon: Pokemon
    let didTapItem: (Pokemon) -> Void
    let toggleFavorite: (Pokemon) -> Void

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(pokemon.pokemonIdString)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Spacer().frame(width: 16)
                Text(pokemon.name.capitalized)
                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
                Button(action: {
                    toggleFavorite(pokemon)
                }) {
                    Image(systemName: SFSymbols.starFilled)
                        .foregroundColor(.yellow)
                }
            }
            .frame(height: 50)
            .padding(.horizontal, 16)
            .background(Color.white)
            
            Divider()
        }.onTapGesture {
            didTapItem(pokemon)
        }
    }
}

let mockPokemons = [
    Pokemon(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/"),
    Pokemon(name: "ivysaur", url: "https://pokeapi.co/api/v2/pokemon/2/"),
    Pokemon(name: "venusaur", url: "https://pokeapi.co/api/v2/pokemon/3/")
]

#Preview {
    ListView(pokemons:mockPokemons, toggleFavorite: { _ in })
}
