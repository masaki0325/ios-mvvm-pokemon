# ポケモンアプリ

SwiftUI と MVVM アーキテクチャで作成したシンプルなポケモンアプリです。Pokémon API を活用して、ポケモンの一覧表示、検索、お気に入り登録、お気に入りリストの表示ができます。

---

## 📱 機能

- **ポケモン一覧表示**  
  ポケモンのリストを表示し、スクロール可能です。

- **検索機能**  
  名前や ID を入力してポケモンを検索できます。

- **お気に入り機能**  
  気に入ったポケモンをお気に入りリストに追加し、管理できます。

- **ポケモン詳細画面**  
  ポケモンの画像や詳細情報（名前、高さ、重さなど）を表示します。

---

## 🛠️ 技術スタック

- **SwiftUI** - UI フレームワーク
- **MVVM** - アーキテクチャ設計
- **Combine** - リアクティブなデータ管理
- **Core Data** または **Realm** - ローカルデータベース
- **Pokémon API** - ポケモンデータ取得

---

## 📂 プロジェクト構成

```plaintext
PokemonApp/
├── Models/                   # データモデル (例: Pokemon, FavoritePokemon)
├── ViewModels/               # 各画面に対応する ViewModel
│   ├── PokemonListViewModel.swift
│   ├── PokemonDetailViewModel.swift
│   └── FavoriteListViewModel.swift
├── Views/                    # 各画面の UI
│   ├── PokemonListView.swift
│   ├── PokemonDetailView.swift
│   ├── FavoriteListView.swift
│   └── SearchView.swift
├── Services/                 # API 呼び出しやリポジトリ管理
│   ├── PokemonAPI.swift      # ポケモン API サービス
│   └── FavoriteRepository.swift # お気に入りデータの管理
├── Resources/                # リソースファイル
│   ├── Assets.xcassets
│   ├── Localizable.strings
│   └── PokemonApp.entitlements
└── SupportingFiles/          # アプリの設定ファイル
    ├── AppDelegate.swift
    └── SceneDelegate.swift
```

## 🚀 動作環境

- **Xcode**: 14.0 以上  
- **iOS**: 16.0 以上  
- **Swift**: 5.7 以上  

---

## セットアップ

ローカル環境でプロジェクトをセットアップする手順です。

### 1. リポジトリをクローン  
以下のコマンドを使用してリポジトリをローカルにクローンします。

```bash
git clone https://github.com/your-repo/pokemon-app.git
cd pokemon-app
