//
//  AppInfo.swift
//  Pokemon
//
//  Created by Masaki Sato on 2024/11/16.
//

import Foundation

struct AppInfo {
    /// アプリのバージョンを取得
    static var version: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "N/A"
    }

    /// ビルド番号を取得
    static var buildNumber: String {
        Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "N/A"
    }
}
