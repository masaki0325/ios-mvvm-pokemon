//
//  PokemonApp.swift
//  Pokemon
//
//  Created by Masaki Sato on 2024/11/11.
//

import SwiftUI
import Dependencies

@main
struct PokemonApp: App {

    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}


struct MainView: View {
    
    var body: some View {
        TabView {
            ForEach(TabItem.allCases) { tab in
                tab.view().tabItem {
                    Label(tab.title, systemImage: tab.iconName)
                }
            }
        }
    }
}

enum TabItem: String, CaseIterable, Identifiable {
    case pokemonList
    case favoriteList
    case setting
    
    var id: String { self.rawValue }
    
    var title: String {
        switch self {
        case .pokemonList:
            return "ポケモン一覧"
        case .favoriteList:
            return "お気に入り"
        case .setting:
            return "設定"
        }
    }
    
    var iconName: String {
        switch self {
        case .pokemonList:
            return SFSymbols.list
        case .favoriteList:
            return SFSymbols.starFilled
        case .setting:
            return SFSymbols.gear
        }
    }
}

struct SFSymbols {
    static let list = "list.bullet"
    static let starFilled = "star.fill"
    static let star = "star"
    static let gear = "gearshape"
}

private extension TabItem {

    @MainActor @ViewBuilder
    func view() -> some View {
        switch self {
        case .pokemonList:
            PokemonListView(viewModel: PokemonListViewModel())
        case .favoriteList:
            FavoriteListView(viewModel: FavoriteListViewModel())
        case .setting:
            SettingView()
        }
    }
}

#Preview {
    
}

