//
//  FavoriteListView.swift
//  Pokemon
//
//  Created by Masaki Sato on 2024/11/11.
//

import SwiftUI
import RealmSwift

struct FavoriteListView: View {
    
    @ObservedObject var viewModel: FavoriteListViewModel
    @State private var isSearchPresented = false
    
    var body: some View {
        NavigationStack {
            VStack {
                switch viewModel.uiState {
                case .initial:
                    ProgressView()
                case .loading:
                    ProgressView()
                case .success:
                    List {
                        ForEach(viewModel.pokemons) { pokemon in
                            Text(pokemon.name)
                        }
                        .onDelete(perform: viewModel.deleteItem)
                    }
                case .error(let message):
                    ErrorView(message: message, retry: {
                        Task {
                            viewModel.fetch()
                        }
                    })
                case .empty:
                    VStack {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                        Text("結果がありません")
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("お気に入り")
            .onAppear {
                Task {
                    viewModel.fetch()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isSearchPresented = true
                    }) {
                        Image(systemName: "magnifyingglass")
                    }
                }
            }
            .sheet(isPresented: $isSearchPresented) {
                SearchView { query, id in
                    viewModel.search(query: query, id: id)
                }
            }
        }
    }
}

private struct ListView: View {
    let pokemons: [FavoritePokemon]
    let toggleFavorite: (FavoritePokemon) -> Void

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
    let pokemon: FavoritePokemon
    let didTapItem: (FavoritePokemon) -> Void
    let toggleFavorite: (FavoritePokemon) -> Void

    var body: some View {
        VStack(spacing: 0) {
            HStack {
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
