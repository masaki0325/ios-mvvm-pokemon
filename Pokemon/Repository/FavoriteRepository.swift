//
//  FavoriteRepository.swift
//  Pokemon
//
//  Created by Masaki Sato on 2024/11/11.
//

import Foundation
import Dependencies
import RealmSwift

protocol FavoriteRepositoryProtocol {
    func addFavorite(pokemonId: Int, name: String)
    func removeFavorite(pokemonId: Int)
    func fetchFavorites() -> [FavoritePokemon]
}

class FavoriteRepository: FavoriteRepositoryProtocol {
    
    func addFavorite(pokemonId: Int, name: String) {
        let favorite = FavoritePokemon(pokemonId: pokemonId, name: name)
        do {
            let realm = RealmManager.shared.realm
            try realm.write {
                realm.add(favorite, update: .modified)
            }
        } catch {
            print("Realm にお気に入りを追加する際にエラーが発生しました: \(error)")
        }
    }
    
    func removeFavorite(pokemonId: Int) {
        do {
            let realm = RealmManager.shared.realm
            let favorite = realm.objects(FavoritePokemon.self).filter("pokemonId == %@", pokemonId)
            try realm.write {
                realm.delete(favorite)
            }
        } catch {
            print("Realm からお気に入りを削除する際にエラーが発生しました: \(error)")
        }
    }
    
    func fetchFavorites() -> [FavoritePokemon] {
        let realm = RealmManager.shared.realm
        return Array(realm.objects(FavoritePokemon.self))
    }
}


class RealmManager {
    static let shared = RealmManager()
    let realm: Realm

    private init() {
        do {
            print(Realm.Configuration.defaultConfiguration.fileURL!)
            realm = try Realm()
        } catch {
            fatalError("Realm の初期化に失敗しました: \(error)")
        }
    }
}
