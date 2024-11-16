//
//  SettingView.swift
//  Pokemon
//
//  Created by Masaki Sato on 2024/11/11.
//

import SwiftUI

struct SettingView: View {

    var body: some View {
        List {
            Section(header: Text("アプリ情報")) {
                SettingTile(
                    title: "App Version",
                    value: AppInfo.version
                )
                SettingTile(
                    title: "Build Number",
                    value: AppInfo.buildNumber
                )
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
}


struct SettingTile: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
            Spacer()
            Text(value)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 8)
    }
}

#Preview{
    SettingView()
}
