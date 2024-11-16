//
//  PokemonListRepository.swift
//  Pokemon
//
//  Created by Masaki Sato on 2024/11/11.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case dataFetchFailed
    case decodingFailed
}

protocol PokemonListRepositoryProtocol {
    func fetchPokemonList() async throws -> [Pokemon]
}

class PokemonListRepository: PokemonListRepositoryProtocol {
    
    func fetchPokemonList() async throws -> [Pokemon] {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=100") else {
            throw APIError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        do {
            let response = try JSONDecoder().decode(PokemonListResponse.self, from: data)
            return response.results
        } catch {
            throw APIError.decodingFailed
        }
    }
    
}
